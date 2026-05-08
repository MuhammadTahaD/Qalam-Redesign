const mongoose = require('mongoose');

const attendanceSchema = new mongoose.Schema({
  studentId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  courseId: { type: mongoose.Schema.Types.ObjectId, ref: 'Course', required: true },
  percentage: { type: Number, required: true },
  absencesAllowed: { type: Number, required: true },
});

module.exports = mongoose.model('Attendance', attendanceSchema);
