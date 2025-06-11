const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken'); // Import jsonwebtoken

// Import your new email validation middleware
const emailValidationMiddleware = require('../middleware/emailValidationMiddleware');

// POST /api/auth/login
// This route now applies the emailValidationMiddleware before its main logic.
// This means the email will be validated first, and if invalid, the request
// will not even reach the login logic below.
router.post('/login', emailValidationMiddleware, (req, res) => {
    // We expect 'username', 'password', and 'email' in the request body
    const { username, password, email } = req.body;

    // --- Login Logic ---
    // In a real application, you'd fetch user from DB and compare hashed password.
    // The 'email' validation has already happened in the middleware before this point.
    // For now, let's use hardcoded credentials for demonstration,
    // including a check for the email as part of the "successful" hardcoded login.
    
    // Basic validation for username/password (email already checked by middleware)
    if (!username || !password) {
        return res.status(400).json({ message: 'Username and password are required' });
    }

    // Simulate a successful login with hardcoded user details.
    // The `email.toLowerCase().endsWith('@dtu.in')` check is redundant here
    // because the `emailValidationMiddleware` already handles it.
    // However, including it in the hardcoded `if` ensures that this specific
    // testuser is only considered valid with a DTU email for full testing.
    if (username === 'testuser' && password === 'password123' && email.toLowerCase() === 'testuser@dtu.ac.in') {
        // Sign a JWT. The payload usually contains non-sensitive user info (e.g., user ID, role).
        // process.env.JWT_SECRET should be defined in your .env file
        const token = jwt.sign(
            { id: 'someUserId', username: username, role: 'student', email: email }, // Include email in payload
            process.env.JWT_SECRET, // Secret key from .env
            { expiresIn: '1h' } // Token expires in 1 hour
        );

        // Send the token back to the client
        return res.json({ message: 'Login successful', token: token });
    } else {
        // If username/password don't match, or if the email was not 'testuser@dtu.in'
        // (even though it passed @dtu.in validation), send an invalid credentials message.
        return res.status(401).json({ message: 'Invalid credentials or incorrect DTU email for testuser' });
    }
});

module.exports = router;