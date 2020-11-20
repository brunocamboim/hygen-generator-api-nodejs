---
inject: true
to: ../<%= apiFolderName %>/src/services/service.db/index.js
after: module.exports.ping = ping;
---
module.exports.<%= endpointName %> = require('./_<%= endpointName %>.js');