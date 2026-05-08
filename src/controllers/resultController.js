const Result = require('../models/Result');

exports.getResults = async (req, res) => {
  try {
    const results = await Result.find({ studentId: req.user.id }).populate('courseId', 'name');
    res.json({ data: results });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
