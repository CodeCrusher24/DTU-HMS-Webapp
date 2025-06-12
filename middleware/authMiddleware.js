const jwt = require('jsonwebtoken'); // Import jsonwebtoken

// This middleware function will be used to protect routes
module.exports = (req, res, next) => {
    // Get token from the 'Authorization' header (e.g., "Bearer TOKEN")
    const authHeader = req.headers['authorization'];

    // 1. Check if Authorization header exists
    if (!authHeader) {
        return res.status(401).json({ message: 'Access Denied: No Token Provided!' });
    }

    // 2. Extract the token (remove "Bearer " prefix)
    const token = authHeader.split(' ')[1]; // Splits "Bearer TOKEN" into ["Bearer", "TOKEN"]

    // Check if token exists after splitting
    if (!token) {
        return res.status(401).json({ message: 'Access Denied: Token malformed or not found!' });
    }

    // 3. Verify the token
    try {
        // Verify the token using your JWT_SECRET
        const decoded = jwt.verify(token, process.env.JWT_SECRET);

        // Attach the decoded user information to the request object
        // This makes user data (like id, username, role) available in subsequent route handlers
        req.user = decoded; // E.g., req.user = { id: 'someUserId', username: 'testuser', role: 'student' }

        // If token is valid, proceed to the next middleware or route handler
        next();
    } catch (err) {
        // If token is invalid (e.g., expired, malformed secret)
        console.error("JWT verification error:", err.message); // Log error for debugging
        return res.status(403).json({ message: 'Invalid Token' });
    }
};