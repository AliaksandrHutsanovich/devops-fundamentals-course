#!/bin/bash

SERVER_HOST_DIR=/home/alex/devops_fundamentals/projects/nestjs-rest-api
CLIENT_HOST_DIR=/home/alex/devops_fundamentals/projects/shop-react-redux-cloudfront

SERVER_REMOTE_DIR=/var/app
CLIENT_REMOTE_DIR=/var/www/html

echo "---> Building and copying server files - START <---"
cd $SERVER_HOST_DIR && yarn build
cp package.json $SERVER_REMOTE_DIR
cp package-lock.json $SERVER_REMOTE_DIR
cp yarn.lock $SERVER_REMOTE_DIR
cp -R dist/ $SERVER_REMOTE_DIR
cd $SERVER_REMOTE_DIR && yarn install
chmod ugo=rwx package.json package-lock.json yarn.lock dist dist/* node_modules node_modules/*
echo "---> Building and transfering server - COMPLETE <---"

echo "---> Building and transfering client files, cert and ngingx config - START <---"
cd $CLIENT_HOST_DIR && npm run build
cd $CLIENT_HOST_DIR/dist
cp index.html $CLIENT_REMOTE_DIR
cp mockServiceWorker.js $CLIENT_REMOTE_DIR
cp -R assets/ $CLIENT_REMOTE_DIR
chmod ugo=rwx index.html mockServiceWorker.js assets assets/*
echo "---> Building and transfering - COMPLETE <---"
