const express = require('express');
const auth = require('../middleware/authMiddleware');
const { getResults } = require('../controllers/resultController');

const router = express.Router();

router.get('/', auth, getResults);

module.exports = router;
