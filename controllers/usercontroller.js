let users = [
    { id: 1, username: 'alice', password: '1234', hostelStatus: 'Pending' },
    { id: 2, username: 'bob', password: '1235', hostelStatus: 'Approved', room: 'A101' },
    { id: 3, username: 'lily', password: '1264', hostelStatus: 'Rejected' },
];

exports.getAllUsers = (req, res) => {
    res.json(users.map(user => {
        return {
            id: user.id,
            username: user.username,
            hostelStatus: user.hostelStatus,
            room: user.room || null
        };
    }));
};

exports.getUserById = (req, res) => {
    const user = users.find(u => u.id === parseInt(req.params.id));
    if (!user) return res.status(404).json({ error: 'User not found' });
    
    res.json({
        id: user.id,
        username: user.username,
        hostelStatus: user.hostelStatus,
        room: user.room || null
    });
};

exports.createUser = (req, res) => {
    const { username, password } = req.body;
    
    if (!username || !password) {
        return res.status(400).json({ error: 'Username and password required' });
    }

    const newUser = {
        id: users.length + 1,
        username,
        password,
        hostelStatus: 'Pending'
    };
    
    users.push(newUser);
    res.status(201).json({
        id: newUser.id,
        username: newUser.username,
        hostelStatus: newUser.hostelStatus
    });
};

exports.updateUser = (req, res) => {
    const user = users.find(u => u.id === parseInt(req.params.id));
    if (!user) return res.status(404).json({ error: 'User not found' });

    if (req.body.username) user.username = req.body.username;
    if (req.body.password) user.password = req.body.password;
    
    res.json({
        id: user.id,
        username: user.username,
        hostelStatus: user.hostelStatus,
        room: user.room || null
    });
};

exports.deleteUser = (req, res) => {
    users = users.filter(u => u.id !== parseInt(req.params.id));
    res.json({ message: 'User deleted successfully' });
};
