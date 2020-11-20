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

    const options = {
      uri     : `${process.env.SAFEA_URL}/auth/token/check`,
      method  : 'GET',
      headers : {
        'Authorization' : authorization,
      }
    };
    try {
      const response = await request.handler(options);
      req.authorizer = response.payloadToken;
  
      return next();
    } catch (err) {
      if (err.error) {
        throw new error.HttpError(err.error.message, err.status_code, err.error.code);
      }
      throw new error.HttpError('Error on validate token.', 403, '<%= apiName %>-403_error-validate-token');
    }
  }
  throw new error.HttpError('Missing autentication token.', 403, '<%= apiName %>-403_missing-authentication-token');
};

module.exports = {
  verify
};