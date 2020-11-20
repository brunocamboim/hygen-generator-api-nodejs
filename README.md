# Introduction 
This generator was made up with [Hygen](https://www.hygen.io/). Access the website for more info and docs.

#Requisites
In order to use it, you'll need to:
1. Have Node.js installed on your computer (version > 10). If you need to install it go to [Node](https://nodejs.org/en/)
2. Have Git CLI installed or Git GUI. More info at: [Git](https://git-scm.com/downloads)

# Getting Started
1.	Clone the project
2.  Open your terminal or GIT CLI.
3.	Run 'npm install -g hygen'

# API
1.  From your cloned folder root, run: hygen express-api new.  
2.  Answer each input asked in a proper and careful way.
    - Example:
      API Name    : api-name
      Service Name: user
3.  After answering it, the api will be generated.

# Adding each endpoint
1.  From your cloned folder root, run: hygen express-api add-endpoint.  
2.  Answer each input asked in a proper and careful way.
3.  After answering it, the api will be generated.

###PS: For each new API or Endpoint, you should run the generator again and again.  

# Build and Test
In order to test it, go into your API's folder and run the following commands:
'npm install'
'npm run local'
