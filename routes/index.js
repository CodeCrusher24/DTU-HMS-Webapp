const express = require('express');
const router = express.Router(); // Create a new router instance
const jwt = require('jsonwebtoken'); // You might not strictly need this here if only used in authRoutes, but it's good practice for general JWT operations.
                                    // If you plan to use JWT in other routes, keep it.

// Import other route files here
const authRoutes = require('./authRoutes'); // Import your new authentication routes
const authMiddleware = require('../middleware/authMiddleware'); // Import your new auth middleware

// --- Main API Routes ---

// Define a simple health check route, now PROTECTED by authMiddleware
router.get('/health', authMiddleware, (req, res) => {
    // If the request reaches here, it means the token was valid.
    // req.user contains the decoded JWT payload (e.g., { id: 'someUserId', username: 'testuser', role: 'student' })
    res.status(200).json({ 
        status: 'API is healthy', 
        timestamp: new Date(), 
        user: req.user.username // Display the username from the authenticated user
    });
});

// Use the authentication routes, prefixing them with '/auth'
// This means any route defined in authRoutes.js (like /login)
// will now be accessible under /api/auth/login
router.use('/auth', authRoutes);

// Export the main router to be used in server.js
module.exports = router;