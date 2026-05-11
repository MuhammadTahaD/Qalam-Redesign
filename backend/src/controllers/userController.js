/**
 * File: backend/src/controllers/userController.js
 * Purpose: Retrieves authenticated user profile data.
 */
const User = require('../models/User');

exports.getProfile = async (req, res) => {
  try {
    const user = await User.findById(req.user.id).select('-password');
    if (!user) return res.status(404).json({ message: 'User not found' });
    res.json({ data: user });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
