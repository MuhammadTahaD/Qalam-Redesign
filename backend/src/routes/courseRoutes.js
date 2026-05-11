/**
 * File: backend/src/routes/courseRoutes.js
 * Purpose: Endpoint for fetching student's enrolled courses.
 */
const express = require('express');
const auth = require('../middleware/authMiddleware');
const { getCourses } = require('../controllers/courseController');

const router = express.Router();

router.get('/', auth, getCourses);

module.exports = router;
