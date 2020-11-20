---
to: ../<%= folderName %>/src/services/service.db/index.js
---
'use strict';

//
// commom api
const { postgres } = require('common-api').database;

//
// queries
const ping = () => {
  const query = 'SELECT $1::text as message';
  const values = ['ping'];

  return postgres.read.query(query, values);
};

//
// exports
module.exports.ping = ping;