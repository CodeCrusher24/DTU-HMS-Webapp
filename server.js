const express = require('express');
const app = express();
const port = 4000;

app.use(express.json());

// Import routes - verify these paths are correct
const userRoutes = require('./routes/users');
const authRoutes = require('./routes/auth');
const hostelRoutes = require('./routes/hostels');

// Use routes
app.use('/api/users', userRoutes);
app.use('/api/auth', authRoutes);
app.use('/api/hostels', hostelRoutes);

app.get('/', (req, res) => {
  res.send('🚀 API is working!');
});

app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});