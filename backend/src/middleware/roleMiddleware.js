/**
 * File: backend/src/middleware/roleMiddleware.js
 * Purpose: Role-based access control middleware checking user permissions.
 */
const User = require('../models/User');

module.exports = (...roles) => async (req, res, next) => {
  try {
    const user = await User.findById(req.user.id).select('role');
    if (!user || !roles.includes(user.role)) {
      return res.status(403).json({ message: 'Forbidden' });
    }
    next();
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};
