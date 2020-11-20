---
to: ../<%= folderName %>/docker-compose.yml
---
version: '3.7'

services:
  api:
    build: ./docker
    image: node:12-alpine
    volumes:
      - ./:/api
    ports:
      - $PORT:$PORT
    command: sh -c "npm i; npm run local"