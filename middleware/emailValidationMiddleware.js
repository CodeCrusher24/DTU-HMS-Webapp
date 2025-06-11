// This middleware checks if the email in the request body ends with '@dtu.ac.in'
module.exports = (req, res, next) => {
    // We'll assume the email field is named 'email' in the request body.
    // If your frontend uses a different name (e.g., 'userEmail'), change 'req.body.email' accordingly.
    const { email } = req.body;

    // 1. Check if email is provided in the request body
    if (!email) {
        return res.status(400).json({ message: 'Email field is required.' });
    }

    // 2. Check if the email ends with '@dtu.in' (case-insensitive)
    if (!email.toLowerCase().endsWith('@dtu.ac.in')) {
        return res.status(400).json({ message: 'Only @dtu.ac.in email addresses are allowed.' });
    }

    // If the email is valid, proceed to the next middleware or route handler
    next();
};
