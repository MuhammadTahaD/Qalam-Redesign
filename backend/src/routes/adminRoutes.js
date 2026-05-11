/**
 * File: backend/src/routes/adminRoutes.js
 * Purpose: Instructor endpoints for viewing and updating student results.
 */
const express = require('express');
const auth = require('../middleware/authMiddleware');
const allowRoles = require('../middleware/roleMiddleware');
const {
  getAllResultsForInstructor,
  updateStudentMarks,
} = require('../controllers/resultController');

const router = express.Router();

router.get('/results', auth, allowRoles('instructor'), getAllResultsForInstructor);
router.put('/results/:id', auth, allowRoles('instructor'), updateStudentMarks);

module.exports = router;
