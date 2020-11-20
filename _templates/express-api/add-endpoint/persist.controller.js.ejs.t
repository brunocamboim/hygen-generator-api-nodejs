---
to: ../<%= apiFolderName %>/src/controllers/<%= folderName %>/persist.controller.js
---
<%
  endpointNameCamel     = h.inflection.camelize(endpointName);
  endpointNameCamelTrue = h.inflection.camelize(endpointName, true);
%>
'use strict';

//
// dependencies
const { validator, response, error } = require('common-api');

//
// services
const serviceDB = require('../../services/service.db');

//
// private
const _validateCreateBody = (body) =>{
  const createSchema = {
    'id'        : '/Create<%= endpointNameCamel %>',
    'type'      : 'object',
    'properties': {
      'name': {'type' : 'string'}
    },
    'required': ['name']
  };
  return validator.validate(createSchema, body);
};

const _validateEditBody = (body) =>{
  const editSchema = {
    'id'        : '/Edit<%= endpointNameCamel %>',
    'type'      : 'object',
    'properties': {
      'name': {'type' : 'string'}
    },
    'required': ['name']
  };
  return validator.validate(editSchema, body);
};

//
// exports
const create = async (req, res) => {
  const { name } = _validateCreateBody(req.body);

  try {
    const <%= endpointNameCamelTrue %> = {
      name
    };

    const <%= endpointNameCamelTrue %>Created  = await serviceDB.<%= endpointName %>.create(<%= endpointNameCamelTrue %>);
    <%= endpointNameCamelTrue %>.id           = <%= endpointNameCamelTrue %>Created.id;

    return response.success(res, <%= endpointNameCamelTrue %>, 201);
  } catch (err) {
    if (err.name === 'HttpError') {
      throw err;
    }

    throw new error.HttpError('Error registering <%= endpointName %>', 400, '<%= apiName %>-400_error-register-<%= endpointNameCamelTrue %>');
  }
};

const edit = async (req, res) => {
  const { name }  = _validateEditBody(req.body);
  const { id }    = req.params;

  const <%= endpointNameCamelTrue %> = await serviceDB.<%= endpointName %>.getById(id);
  if (!<%= endpointNameCamelTrue %>){
    throw new error.HttpError(`<%= endpointNameCamel %> ${id} not found.`, 404, '<%= apiName %>-404_<%= endpointName %>-not-found');
  }

  <%= endpointNameCamelTrue %>.name = name;

  try{
    await serviceDB.<%= endpointName %>.edit(<%= endpointNameCamelTrue %>);
  } catch (err) {
    if (err.constraint == '<%= endpointName %>_fk0') {
      throw new error.HttpError('Invalid Params', 400, '<%= apiName %>-400_invalid-params');
    } 
    throw err;
    
  } 

  return response.success(res, <%= endpointNameCamelTrue %>);
};

const remove = async (req, res) => {
  const { id } = req.params;

  const <%= endpointNameCamelTrue %> = await serviceDB.<%= endpointName %>.getById(id);
  if (!<%= endpointNameCamelTrue %>){
    throw new error.HttpError(`<%= endpointNameCamel %> ${id} not found.`, 404, '<%= apiName %>-404_<%= endpointName %>-not-found');
  }

  await serviceDB.<%= endpointName %>.remove(id);
  return response.success(res, `<%= endpointNameCamel %> ${id} was deleted!`);
};

module.exports = {
  create,
  edit,
  remove
};