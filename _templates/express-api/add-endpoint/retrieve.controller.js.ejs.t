---
to: ../<%= apiFolderName %>/src/controllers/<%= folderName %>/retrieve.controller.js
---
<%
  endpointNameCamel     = h.inflection.camelize(endpointName);
  endpointNameCamelTrue = h.inflection.camelize(endpointName, true);
%>
'use strict';

//
// common api
const { response, error } = require('common-api');

//
// services
const serviceDB = require('../../services/service.db');

//
// exports
const getById = async (req, res) => {
  const { id } = req.params;

  const <%= endpointNameCamelTrue %> = await serviceDB.<%= endpointName %>.getById(id);
  if (!<%= endpointNameCamelTrue %>){
    throw new error.HttpError(`<%= endpointNameCamelTrue %> ${id} not found.`, 404, '<%= apiName %>-404_<%= endpointName %>-not-found');
  }

  return response.success(res, <%= endpointNameCamelTrue %>);
};

const getAll = async (req, res) => {
  let offset = req.query.offset || 0;
  let limit  = req.query.limit  || 20;

  offset = parseInt(offset);
  limit  = parseInt(limit);
  if (offset < 0 || limit < 0){
    throw new error.HttpError('Invalid Parameters, limit and offset cannot be negative', 400, '<%= apiName %>-400_invalid-parameters');
  }

  const <%= endpointNameCamelTrue %>List = await serviceDB.<%= endpointName %>.getAll(offset, limit + 1);

  let nextPage = false;
  if (<%= endpointNameCamelTrue %>List.length > limit){
    nextPage = true;
    <%= endpointNameCamelTrue %>List.pop();
  }

  const returnBody = {
    <%= endpointNameCamelTrue %>  : <%= endpointNameCamelTrue %>List,
    nextPage : nextPage
  };

  return response.success(res, returnBody);
};


module.exports = {
  getById,
  getAll
};