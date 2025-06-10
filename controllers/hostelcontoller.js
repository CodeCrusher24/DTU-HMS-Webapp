let users = [
    { id: 1, username: 'alice', password: '1234', hostelStatus: 'Pending' },
    { id: 2, username: 'bob', password: '1235', hostelStatus: 'Approved', room: 'A101' },
    { id: 3, username: 'lily', password: '1264', hostelStatus: 'Rejected' },
];

exports.getStatus = (req, res) => {
    const user = users.find(u => u.id === parseInt(req.params.id));
    if (!user) return res.status(404).json({ error: 'User not found' });
    
    res.json({
        studentId: user.id,
        status: user.hostelStatus,
        room: user.room || null
    });
};

exports.applyHostel = (req, res) => {
    const { userId, name, course, year } = req.body;
    
    const user = users.find(u => u.id === parseInt(userId));
    if (!user) return res.status(404).json({ error: 'User not found' });
    
    user.hostelStatus = 'Pending';
    user.hostelApplication = { name, course, year };
    
    res.status(201).json({
        message: 'Hostel application submitted',
        applicationId: Math.floor(Math.random() * 1000),
        status: user.hostelStatus
    });
};