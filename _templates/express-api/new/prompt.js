
// see types of prompts:
// https://github.com/enquirer/enquirer/tree/master/examples
//
module.exports = [
  {
    type: 'input',
    name: 'folderName',
    message: "What's the folder's name that contains your repository? (The folder must be at the same level as your generator)"
  },
  {
    type: 'input',
    name: 'apiName',
    message: "What's your API's name?"
  },
  {
    type: 'input',
    name: 'nameSpace',
    message: "What's your name space?"
  },
  {
    type: 'input',
    name: 'versionApi',
    message: "What's your API version?"
  },
  {
    type: 'input',
    name: 'basePath',
    message: "What's your base path to health check?"
  }
]
