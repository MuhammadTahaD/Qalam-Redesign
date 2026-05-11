/**
 * File: backend/src/middleware/authMiddleware.js
 * Purpose: JWT authentication middleware validating Bearer tokens.
 */
const jwt = require('jsonwebtoken');

module.exports = (req, res, next) => {
  const authHeader = req.headers.authorization;
  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return res.status(401).json({ message: 'Unauthorized' });
  }

  const token = authHeader.split(' ')[1];

  try {
    const payload = jwt.verify(token, process.env.JWT_SECRET);
    req.user = payload;
    next();
  } catch (_error) {
    return res.status(401).json({ message: 'Invalid token' });
  }
};
