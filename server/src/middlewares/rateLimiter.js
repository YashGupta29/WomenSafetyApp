const rateLimit = require('express-rate-limit');
const config = require('../config/config');

const rateLimiter = rateLimit({
  windowMs: config.rateLimit.windowSize * 60 * 1000,
  max: config.rateLimit.maxRequestAllowed,
});

module.exports = {
  rateLimiter,
};
