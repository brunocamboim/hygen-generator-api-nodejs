---
to: ../<%= apiFolderName %>/src/routes/_<%= endpointName %>.js
---
<%
  endpointNameCamel     = h.inflection.camelize(endpointName);
  endpointNameCamelTrue = h.inflection.camelize(endpointName, true);
%>
'use strict';

//
// middlewares
// const authorizerMiddleware = require('../middlewares/authorizer.middleware');

//
// <%= endpointName %>
const <%= endpointName %>RetrieveController = require('../controllers/<%= folderName %>/retrieve.controller');
const <%= endpointName %>PersistController  = require('../controllers/<%= folderName %>/persist.controller');

const init = (expressInstance, basePath) => {
  expressInstance.get(`${basePath}<%= endpointUrl %>/:id`, <%= endpointName %>RetrieveController.getById);
  expressInstance.get(`${basePath}<%= endpointUrl %>`, <%= endpointName %>RetrieveController.getAll);
  expressInstance.post(`${basePath}<%= endpointUrl %>`, <%= endpointName %>PersistController.create);
  expressInstance.put(`${basePath}<%= endpointUrl %>/:id`, <%= endpointName %>PersistController.edit);
  expressInstance.delete(`${basePath}<%= endpointUrl %>/:id`, <%= endpointName %>PersistController.remove);

  //
  // If you need a middleware, use this example:
  // expressInstance.post(`${basePath}<%= endpointUrl %>`, authorizerMiddleware.verify, <%= endpointName %>PersistController.register<%= endpointNameCamel %>);
};

module.exports = {
  init
};