const express = require('express');
const router = express.Router();
const hostelController = require('../controllers/hostelcontoller');
const authMiddleware = require('../middleware/authMiddleware'); // Adjust path if needed

router.get('/status/:id',hostelController.getStatus);
router.post('/apply',hostelController.applyHostel);

module.exports = router;