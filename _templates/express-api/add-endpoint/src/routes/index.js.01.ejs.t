---
inject: true
to: ../<%= apiFolderName %>/src/routes/index.js
after: // routes
---
const <%= endpointName %> = require('./_<%= endpointName %>.js');