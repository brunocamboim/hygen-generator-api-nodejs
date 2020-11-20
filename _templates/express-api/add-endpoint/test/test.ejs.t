---
to: ../<%= apiFolderName %>/test/<%= endpointName %>.test.js
---
<%
  endpointNameCamel     = h.inflection.camelize(endpointName);
  endpointNameCamelTrue = h.inflection.camelize(endpointName, true);
%>
'use strict';

//
// dependencies
const chai = require('chai'), chaiHttp = require('chai-http');
chai.use(chaiHttp);

//
// running local
if (process.env.NODE_ENV === 'local') {
  const path      = require('path');
  var dotEnvPath  = path.resolve('.env');
  require('dotenv').config({ path: dotEnvPath});
}

let id;

const registerData = {
  name: 'Editar este dado'
};

const registerDataError = {
  uname: 'Editar este dado'
};

const app = require('../src/api');

describe('XY - Test Case Register <%= endpointNameCamel %> through endpoint /<%= endpointName %>', () => {
  it('Should register an /<%= versionApi %><%= endpointUrl %>.', (done) => {
    chai.request(app)
      .post('/<%= versionApi %><%= endpointUrl %>')
      .send(registerData)
      .then(res => {
        chai.expect(res.statusCode).eq(201);
        const body = JSON.parse(res.body);

        chai.expect(body).to.be.an('object', 'Your body is not an object!');
        chai.expect(body.name).to.be.a('string', 'The field name is not a string!');

        id = body.id;
        done();
      })
      .catch(err => {
        return done(err);
      });
  });

  it('Should throw an error when user sent an invalid body.', (done) => {
    chai.request(app)
      .post('/<%= versionApi %><%= endpointUrl %>')
      .send(registerDataError)
      .then(res => {
        chai.expect(res.statusCode).eq(400);
        done();
      })
      .catch(err => {
        return done(err);
      });
  });
});

describe('XY - Test Case Edit <%= endpointNameCamel %> through endpoint /<%= versionApi %><%= endpointUrl %>/:id', () => {
  it('Should edit the field name.', (done) => {
    chai.request(app)
      .put(`/<%= versionApi %><%= endpointUrl %>/${id}`)
      .send(registerData)
      .then(res => {
        chai.expect(res.statusCode).eq(200);

        const body = JSON.parse(res.body);

        chai.expect(body).to.be.an('object', 'Your body is not an object!');
        chai.expect(body.name).to.be.a('string', 'The field name is not a string!');

        done();
      })
      .catch(err => {
        return done(err);
      });
  });

  it('Should throw an error because the <%= endpointNameCamel %> was not found.', (done) => {
    chai.request(app)
      .put('/<%= versionApi %><%= endpointUrl %>/0')
      .send(registerData)
      .then(res => {
        chai.expect(res.statusCode).eq(404);
        done();
      })
      .catch(err => {
        return done(err);
      });
  });

  it('Should throw an error when send an invalid body.', (done) => {
    chai.request(app)
      .put(`/<%= versionApi %><%= endpointUrl %>/${id}`)
      .send(registerDataError)
      .then(res => {
        chai.expect(res.statusCode).eq(400);
        done();
      })
      .catch(err => {
        return done(err);
      });
  });
});

describe('XY - Test Case Get <%= endpointNameCamel %> id through endpoint /<%= versionApi %><%= endpointUrl %>/:id', () => {
  it('Should retrieve the register.', (done) => {
    chai.request(app)
      .get(`/<%= versionApi %><%= endpointUrl %>/${id}`)
      .then(res => {
        chai.expect(res.statusCode).eq(200);

        const body = JSON.parse(res.body);
        chai.expect(body).to.be.an('object', 'Your body is not an object!');
        chai.expect(body.name).to.be.a('string', 'The field name is not a string!');

        done();
      })
      .catch(err => {
        return done(err);
      });
  });

  it('Should throw an error because the <%= endpointNameCamel %> was not found.', (done) => {
    chai.request(app)
      .get(`/<%= versionApi %><%= endpointUrl %>/${id}`)
      .then(res => {
        chai.expect(res.statusCode).eq(404);
        done();
      })
      .catch(err => {
        return done(err);
      });
  });
});

describe('XY - Test Case Get All <%= endpointNameCamel %> through endpoint /<%= versionApi %><%= endpointUrl %>', () => {
  it('Should retrieve all <%= endpointNameCamel %>.', (done) => {
    chai.request(app)
      .get('/<%= versionApi %><%= endpointUrl %>')
      .query({})
      .then(res => {
        chai.expect(res.statusCode).eq(200);
        const body = JSON.parse(res.body);

        chai.expect(body).to.be.an('object', 'Your body is not an object!');
        chai.expect(body.<%= endpointNameCamelTrue %>).to.be.an('array', 'The field <%= endpointNameCamelTrue %> is not an array!');
        chai.expect(body.nextPage).to.exist;
        done();
      })
      .catch(err => {
        return done(err);
      });
  });
});

describe('XY - Test Case Delete <%= endpointNameCamel %> id through endpoint /<%= versionApi %><%= endpointUrl %>/:id', () => {
  it('Should delete the register.', (done) => {
    chai.request(app)
      .delete(`/<%= versionApi %><%= endpointUrl %>/${id}`)
      .then(res => {
        chai.expect(res.statusCode).eq(200);
        const body = JSON.parse(res.body);

        chai.expect(body).to.be.an('object', 'Your body is not an object!');
        chai.expect(body.<%= endpointNameCamelTrue %>).to.be.an('array', 'The field <%= endpointNameCamelTrue %> is not an array!');
        chai.expect(body.nextPage).to.exist;
        done();
      })
      .catch(err => {
        return done(err);
      });
  });

  it('Should throw an error because the <%= endpointNameCamel %> was not found.', (done) => {
    chai.request(app)
      .delete(`/<%= versionApi %><%= endpointUrl %>/${id}`)
      .then(res => {
        chai.expect(res.statusCode).eq(404);
        done();
      })
      .catch(err => {
        return done(err);
      });
  });
});