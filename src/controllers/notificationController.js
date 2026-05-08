const Notification = require('../models/Notification');

exports.getNotifications = async (req, res) => {
  try {
    const page = Math.max(parseInt(req.query.page || '1', 10), 1);
    const limit = Math.max(parseInt(req.query.limit || '20', 10), 1);
    const skip = (page - 1) * limit;

    const items = await Notification.find({ userId: req.user.id }).sort({ createdAt: -1 }).skip(skip).limit(limit);
    res.json({ data: items });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.markRead = async (req, res) => {
  try {
    const item = await Notification.findOneAndUpdate(
      { _id: req.params.id, userId: req.user.id },
      { isRead: true },
      { new: true }
    );
    if (!item) return res.status(404).json({ message: 'Notification not found' });
    res.json({ data: item });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
