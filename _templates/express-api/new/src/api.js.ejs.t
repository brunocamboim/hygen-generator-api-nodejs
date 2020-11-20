---
to: ../<%= folderName %>/src/api.js
---
'use strict';

//
// common api
const { express } = require('common-api');
const serviceDB   = require('./services/service.db');

//
// health check to target group
express.instance.get('/healthcheck', async (req, res) => {
  await serviceDB.ping();
  res.status(200).send({ message: 'ok', build: process.env.BUILD_NUMBER || null });
});

//
// routes
const basePath = '/<%= versionApi %>/<%= basePath %>';
const routes   = require('./routes/index.js');
routes.init(express.instance, basePath);

//
// route health check application
express.instance.get(`${basePath}/healthcheck`, async (req, res) => {
  await serviceDB.ping();
  res.status(200).send({ message: 'ok' });
});

//
// express 
express.init();
module.exports = express.instance;