---
to: ../<%= folderName %>/azure-pipelines.yml
---
# Node.js
# Build a general Node.js project with npm.
# Add steps that analyze code, save build artifacts, deploy, and more:
# https://docs.microsoft.com/azure/devops/pipelines/languages/javascript

trigger:
  branches:
    include:
    - master
    - development
    - release/*
    - hotfix/*
  paths:
    exclude:
    - .vscode/*
    - scripts/*
    - README.md

pool:
  vmImage: 'ubuntu-latest'

steps:
- task: NodeTool@0
  displayName: 'Install Node.js'
  inputs:
    versionSpec: '10.x'

- script: npm install
  displayName: 'NPM Install'
  
- script: npm run lint
  displayName: 'Lint'

- script: |
    sudo apt-get install -y postgresql postgresql-contrib
    sudo /etc/init.d/postgresql start
    sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'postgres';"
    sudo -u postgres createdb database-test
    sudo -u postgres psql database-test < test/database/init.sql
  displayName: 'Install PgSQL and create database'

- script: npm install -g mocha
  displayName: 'NPM Install Mocha'

- script: npm install mocha-multi-reporters -g
  displayName: 'NPM Install Mocha Multi Reporters'

- script: npm install -g nyc
  displayName: 'NPM Install Instambul'

- script: nyc --reporter cobertura mocha --reporter mocha-multi-reporters -t 5000 --exit
  displayName: 'Tests'

- task: CopyFiles@2
  displayName: 'Generate Build Artifacts'
  inputs:
    SourceFolder: '$(System.DefaultWorkingDirectory)'
    Contents: |
      **/*
      !.vscode/*
      !.git/**/*
      !node_modules/**/*
      !scripts/*
      !test/*
      !.gitignore
      !.eslintrc.yml
      !azure-pipelines.yml
      !README.md
    TargetFolder: '$(Build.ArtifactStagingDirectory)'

- task: PublishBuildArtifacts@1
  displayName: 'Copy Files'

- task: PublishBuildArtifacts@1
  displayName: 'Publish Artifacts'

- task: PublishCodeCoverageResults@1
  inputs: 
    codeCoverageTool: Cobertura
    summaryFileLocation: '$(System.DefaultWorkingDirectory)/**/*coverage.xml'
    reportDirectory: '$(System.DefaultWorkingDirectory)/**/coverage'
 
- task: PublishTestResults@2
  condition: succeededOrFailed()
  inputs:
    testRunner: JUnit
    testResultsFiles: 'xunit.xml'

