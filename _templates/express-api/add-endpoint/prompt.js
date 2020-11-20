
// see types of prompts:
// https://github.com/enquirer/enquirer/tree/master/examples
//
module.exports = [
  {
    type: 'input',
    name: 'apiFolderName',
    message: "What's the folder's name that contains your api? (The folder must be at the same level as your generator)"
  },
  {
    type: 'input',
    name: 'apiName',
    message: "What's your API's name?"
  },
  {
    type: 'input',
    name: 'versionApi',
    message: "What's your API's version?"
  },
  {
    type: 'input',
    name: 'endpointName',
    message: "What's your endpoint's name?"
  },
  {
    type: 'input',
    name: 'endpointUrl',
    message: "What's your endpoint's URL? (Ex.: /auth/users)" 
  },
  {
    type: 'input',
    name: 'folderName',
    message: "What's the full path in controller? (Ex.: folder1/folder2/folder3)"
  }//,
  // {
  //   type: 'input',
  //   name: 'endpointName',
  //   message: "What's your entity's name?"
  // }
]
