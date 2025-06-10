const express = require('express');
const router = express.Router();
const authController = require('../controllers/authcontrollers');

router.post('/login', authController.login);

module.exports = router; // Fixed typo (exports instead of export)