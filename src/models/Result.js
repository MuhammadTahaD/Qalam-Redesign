const mongoose = require('mongoose');

const resultSchema = new mongoose.Schema({
  studentId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  courseId: { type: mongoose.Schema.Types.ObjectId, ref: 'Course', required: true },
  grade: { type: String, required: true },
  gpa: { type: Number, required: true },
});

module.exports = mongoose.model('Result', resultSchema);
