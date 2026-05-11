/**
 * File: backend/src/routes/notificationRoutes.js
 * Purpose: Endpoints for fetching and marking notifications as read.
 */
const express = require('express');
const auth = require('../middleware/authMiddleware');
const { getNotifications, markRead } = require('../controllers/notificationController');

const router = express.Router();

router.get('/', auth, getNotifications);
router.put('/:id/read', auth, markRead);

module.exports = router;
