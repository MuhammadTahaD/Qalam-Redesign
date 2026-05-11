/**
 * File: backend/src/routes/resultRoutes.js
 * Purpose: Endpoint for fetching student academic results.
 */
const express = require('express');
const auth = require('../middleware/authMiddleware');
const { getResults } = require('../controllers/resultController');

const router = express.Router();

router.get('/', auth, getResults);

module.exports = router;
