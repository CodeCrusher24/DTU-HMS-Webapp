import { body } from 'express-validator';

export const registerValidation = [
  body('email')
    .isEmail().withMessage('Please provide a valid email address')
    .normalizeEmail(),

  body('password')
    .isLength({ min: 8, max: 64 }).withMessage('Password must be between 8–64 characters')
    .matches(/\d/).withMessage('Password must contain at least one number')
    .matches(/[A-Z]/).withMessage('Password must contain at least one uppercase letter')
    .matches(/[a-z]/).withMessage('Password must contain at least one lowercase letter')
    .matches(/[!@#$%^&*(),.?":{}|<>]/).withMessage('Password must contain at least one special character'),

  body('name')
    .notEmpty().withMessage('Name is required')
    .isLength({ min: 2, max: 50 }).withMessage('Name must be 2–50 characters')
    .matches(/^[a-zA-Z\s]+$/).withMessage('Name must only contain letters and spaces'),

  body('roomNumber')
    .optional()
    .isNumeric().withMessage('Room number must be numeric')
    .isLength({ min: 3, max: 3 }).withMessage('Room number must be 3 digits')
];
