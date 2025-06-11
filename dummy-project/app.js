// import express from 'express';
// import mysql from 'mysql2/promise';

// const app = express();

// app.use(express.json()); 

// // MySQL connection setup
// const db = await mysql.createConnection({
//   host: 'localhost',
//   user: 'root',
//   password: 'root',     // replace with your MySQL password
//   database: 'testdb'
// });

//   //  await db.execute(`CREATE DATABASE testdb`);

// console.log(await db.execute('SHOW DATABASES'))

import express from 'express';
import { registerValidation } from './validations/userValidation.js';
import { validate, errorHandler } from './middlewares/errorHandler.js';
import { hashPassword } from './utils/hash.js';
import { sanitizeBodyFields } from './utils/sanitize.js';

const app = express();
app.use(express.json());

// HTML form test route (GET)
app.get('/', (req, res) => {
  res.send(`
    <form method="POST" action="/test">
      <label>Email: <input name="email" type="email" /></label><br/>
      <label>Password: <input name="password" type="password" /></label><br/>
      <label>Name: <input name="name" type="text" /></label><br/>
      <label>Room Number (optional): <input name="roomNumber" type="text" /></label><br/>
      <button type="submit">Submit</button>
    </form>
  `);
});

// Test POST route
app.post(
  '/test',
  express.urlencoded({ extended: false }), // so form data is parsed
  sanitizeBodyFields,
  registerValidation,
  validate,
  async (req, res) => {
    const { email, password, name, roomNumber } = req.body;
    const hashedPassword = await hashPassword(password);

    res.send(`
      <h2>Success</h2>
      <p>Email: ${email}</p>
      <p>Name: ${name}</p>
      <p>Room: ${roomNumber || '(none)'}</p>
      <p>Hashed Password: ${hashedPassword}</p>
    `);
  }
);

// Error handler last
app.use(errorHandler);

app.listen(3000, () => console.log('Server running at http://localhost:3000'));
