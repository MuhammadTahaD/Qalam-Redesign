/**
 * File: backend/src/controllers/resultController.js
 * Purpose: Manages student results retrieval and instructor result updates.
 */
const Result = require('../models/Result');

exports.getResults = async (req, res) => {
  try {
    const results = await Result.find({ studentId: req.user.id }).populate('courseId', 'name');
    res.json({ data: results });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.getAllResultsForInstructor = async (_req, res) => {
  try {
    const results = await Result.find()
      .populate('courseId', 'name semester')
      .populate('studentId', 'name email');
    res.json({ data: results });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.updateStudentMarks = async (req, res) => {
  try {
    const { grade, gpa } = req.body;

    if (grade == null || gpa == null) {
      return res.status(400).json({ message: 'grade and gpa are required' });
    }

    const result = await Result.findByIdAndUpdate(
      req.params.id,
      { grade, gpa: Number(gpa) },
      { new: true, runValidators: true }
    )
      .populate('courseId', 'name semester')
      .populate('studentId', 'name email');

    if (!result) {
      return res.status(404).json({ message: 'Result not found' });
    }

    res.json({ data: result, message: 'Marks updated successfully' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
