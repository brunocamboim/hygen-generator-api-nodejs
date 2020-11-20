---
to: ../<%= folderName %>/src/middlewares/authorizer.middleware.js
---

'use strict';

//
// dependencies
const { error, request } = require('common-api');

//
// exports
const verify = async (req, res, next) => {
  const authorization = req.headers.authorization;
  if (authorization) {
    if (process.env.NODE_ENV === 'local') {
      req.authorizer = JSON.parse(authorization);
      return next();
    }
  }
  throw new error.HttpError('Missing autentication token.', 403, '<%= apiName %>-403_missing-authentication-token');
};

module.exports = {
  verify
};