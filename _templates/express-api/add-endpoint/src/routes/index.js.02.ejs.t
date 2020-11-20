---
inject: true
to: ../<%= apiFolderName %>/src/routes/index.js
after: module.exports.init
---
  <%= endpointName %>.init(expressInstance, basePath);