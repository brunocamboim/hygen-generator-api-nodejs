---
to: ../<%= folderName %>/.vscode/launch.json
---
{
  // Use IntelliSense to learn about possible attributes.
  // Hover to view descriptions of existing attributes.
  // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
  "version": "1.0.0",
  "configurations": [
    {
      "type": "node",
      "request": "launch",
      "name": "Debug - API <%= apiName %>",
      "runtimeExecutable": "nodemon",
      "restart": true,
      "envFile": "${workspaceRoot}/.env",
      "internalConsoleOptions": "neverOpen",
      "skipFiles": [
        "<node_internals>/**"
      ],
      "env": {
        "NODE_ENV": "development"
      }
    }
  ]
}