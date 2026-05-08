const express = require('express');
const auth = require('../middleware/authMiddleware');
const { getAttendance } = require('../controllers/attendanceController');

const router = express.Router();

router.get('/', auth, getAttendance);

module.exports = router;
