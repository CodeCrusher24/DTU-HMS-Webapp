import bcrypt from 'bcryptjs';


export async function hashPassword(password) {
  try {
    const SALT_ROUNDS = 12; 
    const salt = await bcrypt.genSalt(SALT_ROUNDS);
    const hashedPassword = await bcrypt.hash(password, salt);
    return hashedPassword;
  } catch (err) {
    console.error('Error hashing password:', err);
    throw new Error('Could not hash password');
  }
}


export async function comparePasswords(plainPassword, hashedPassword) {
  try {
    return await bcrypt.compare(plainPassword, hashedPassword);
  } catch (err) {
    console.error('Error comparing passwords:', err);
    throw new Error('Could not verify password');
  }
}
