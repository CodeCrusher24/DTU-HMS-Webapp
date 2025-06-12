// middlewares/sanitize.js

export function sanitizeInput(str) {
  if (typeof str !== 'string') return '';

  return str
    .replace(/<[^>]*>?/gm, '')           // remove HTML tags
    .replace(/\s+/g, ' ')                // collapse extra spaces
    .replace(/[^\x20-\x7E]/g, '')        // remove non-printable chars
    .trim();
}

export function sanitizeBodyFields(req, res, next) {
  if (typeof req.body.name === 'string') {
    req.body.name = sanitizeInput(req.body.name);
  }
  // Add more fields if needed
  next();
}

