/**
 * File: backend/src/controllers/attendanceController.js
 * Purpose: Retrieves attendance records for student with course details.
 */
const Attendance = require('../models/Attendance');

exports.getAttendance = async (req, res) => {
  try {
    const attendance = await Attendance.find({ studentId: req.user.id }).populate('courseId', 'name semester');
    res.json({ data: attendance });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
