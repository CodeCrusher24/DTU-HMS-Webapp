import { validationResult } from 'express-validator';

export function validate(req, res, next) {
  const errors = validationResult(req);

  if (!errors.isEmpty()) {
    const formattedErrors = errors.array().map(err => ({
      field: err.param,
      message: err.msg,
      value: err.value,
      location: err.location
    }));

    const validationError = new Error('Invalid input in your request');
    validationError.status = 422; 
    validationError.details = formattedErrors;

    return next(validationError);
  }

  next();
}

export function errorHandler(err, req, res, next) {
  console.error('[ErrorHandler]', err); 

  res.status(err.status || 500).json({
    success: false,
    message: err.message || 'Something went wrong!',
    errors: err.details || null,
    timestamp: new Date().toISOString(), 
    path: req.originalUrl 
  });
}

