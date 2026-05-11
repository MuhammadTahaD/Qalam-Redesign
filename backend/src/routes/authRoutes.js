/**
 * File: backend/src/routes/authRoutes.js
 * Purpose: Endpoints for user registration and login.
 */
const express = require('express');
const { register, login } = require('../controllers/authController');

const router = express.Router();

router.post('/register', register);
router.post('/login', login);

module.exports = router;
