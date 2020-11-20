---
to: ../<%= apiFolderName %>/src/services/service.db/_<%= endpointName %>.js
---
<%
  endpointNameCamel     = h.inflection.camelize(endpointName);
  endpointNameCamelTrue = h.inflection.camelize(endpointName, true);
%>
'use strict';

//
// commom api
const { postgres } = require('common-api').database;

//
// exports
const getById = async (id) => {
  const query = `
    SELECT
      name
    FROM
      <%= endpointName %>
    WHERE
      <%= endpointName %>.id = $1
  `;

  const values = [id];
  return await postgres.read.queryFirstOrNull(query, values);
};

const getAll = async (offset, limit) => {
  const query = `
    SELECT
      name
    FROM
      <%= endpointName %>
    ORDER BY
      <%= endpointName %>.id
    LIMIT $1 OFFSET $2
  `;

  const values = [limit, offset];
  return await postgres.read.query(query, values);
};

const create = async (name) => {
  const query = `
    INSERT INTO <%= endpointName %> (
      name
    ) VALUES (
      $1
    ) RETURNING *
  `;

  const values = [name];
  return await postgres.write.query(query, values);
};

const edit = async (id, name) => {
  const query = `
    UPDATE 
      <%= endpointName %>
    SET
      name = $1
    WHERE
      <%= endpointName %>.id = $2
  `;

  const values = [id, name];
  return await postgres.write.query(query, values);
};

const remove = async (id) => {
  const query = `
    DELETE FROM 
      <%= endpointName %>
    WHERE
      <%= endpointName %>.id = $1
  `;

  const values = [id];
  return await postgres.write.query(query, values);
};

module.exports = {
  getById,
  getAll,
  create,
  edit,
  remove
};