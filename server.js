// Load environment variables from .env file first
require('dotenv').config();

const helmet = require('helmet');
const cors = require('cors');
const express = require('express');
const app = express(); // Create an instance of the Express application

// --- Essential Middleware ---
app.use(express.json()); // Middleware to parse JSON bodies
app.use(express.urlencoded({ extended: true })); // Middleware to parse URL-encoded bodies
app.use(cors()); // Enable CORS for all routes (important for frontend communication)
app.use(helmet()); // Add various security HTTP headers

// --- Routing Setup ---
// Import your main router from the routes folder
const mainRoutes = require('./routes/index'); // This will handle all your specific API routes

// Use your main router, prefixing all its routes with '/api'
// For example, the '/health' route defined in routes/index.js will be accessible at /api/health
app.use('/api', mainRoutes);

// --- 404 Not Found Handler ---
// This middleware catches any requests that did not match any of the defined routes above.
// It should be placed after all your specific routes.
app.use((req, res, next) => {
    res.status(404).send('404 Not Found: The requested API endpoint does not exist.');
});

// --- Server Listening ---
// Define the port from environment variables or default to 3000
// We will stick to your .env driven PORT and not Chitra's hardcoded port 4000
const PORT = process.env.PORT || 3000;

// Start the server
app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
    console.log(`Current time (IST): ${new Date().toLocaleString('en-IN', { timeZone: 'Asia/Kolkata' })}`);
});