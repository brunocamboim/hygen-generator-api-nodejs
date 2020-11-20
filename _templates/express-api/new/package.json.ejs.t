---
to: ../<%= folderName %>/package.json
---
{
  "name": "<%= apiName %>",
  "version": "1.0.0",
  "description": "",
  "main": "src/api.js",
  "scripts": {
    "lint": "eslint src/**",
    "local": "dotenv node src/api.js",
    "test": "nyc --reporter=html mocha -t 10000 --exit",
    "start": "node src/api.js"
  },
  "license": "ISC",
  "dependencies": {
    "common-api": "git+https://github.com/grupo-a/common-nodejs-tools.git"
  },
  "devDependencies": {
    "chai": "4.2.0",
    "chai-http": "^4.3.0",
    "dotenv": "^8.2.0",
    "eslint": "^6.6.0",
    "faker": "^4.1.0",
    "mocha": "^6.2.0",
    "mocha-junit-reporter": "^1.23.1",
    "nodemon": "^2.0.3",
    "nyc": "^14.1.1"
  }
}
