const Course = require('../models/Course');

exports.getCourses = async (req, res) => {
  try {
    const courses = await Course.find({ students: req.user.id });
    res.json({ data: courses });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
