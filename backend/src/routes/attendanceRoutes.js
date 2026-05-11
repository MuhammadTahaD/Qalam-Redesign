/**
 * File: backend/src/routes/attendanceRoutes.js
 * Purpose: Endpoint for retrieving attendance records.
 */
const express = require('express');
const auth = require('../middleware/authMiddleware');
const { getAttendance } = require('../controllers/attendanceController');

const router = express.Router();

router.get('/', auth, getAttendance);

module.exports = router;
