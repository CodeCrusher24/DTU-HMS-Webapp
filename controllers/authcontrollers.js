let users = [
    { id: 1, username: 'alice', password: '1234', hostelStatus: 'Pending' },
    { id: 2, username: 'bob', password: '1235', hostelStatus: 'Approved', room: 'A101' },
    { id: 3, username: 'lily', password: '1264', hostelStatus: 'Rejected' },
];

exports.login = (req, res) => {
    const { username, password } = req.body;
    
    if (!username || !password) {
        return res.status(400).json({ error: 'Username and password required' });
    }

    const user = users.find(u => u.username === username && u.password === password);
    
    if (user) {
        res.json({ 
            message: 'Login successful',
            userId: user.id,
            username: user.username,
            hostelStatus: user.hostelStatus,
            token: 'abc123' 
        });
    } else {
        res.status(401).json({ error: 'Invalid credentials' });
    }
};