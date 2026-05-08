const express = require('express');
const auth = require('../middleware/authMiddleware');
const { getProfile } = require('../controllers/userController');

const router = express.Router();

router.get('/profile', auth, getProfile);

module.exports = router;
