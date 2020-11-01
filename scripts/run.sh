#!/bin/sh

consul agent -data-dir=/tmp/consul

export CONSUL_HOST=consul-cluster.default.svc.cluster.local
export NATS_HOST=nats-cluster.default.svc.cluster.local
export DISCOVERY_HOST=service-account.default.svc.cluster.local

export NODE_ENV=production
export DOCKER_REGISTRY=azimuth1
export DOCKER_REPO=ultimate-backend
export IMAGE_TAG=latest

node_modules/.bin/concurrently \
    "node dist/apps/service-account/main.js" \
    "node dist/apps/service-notification/main.js" \
    "node dist/apps/service-billing/main.js" \
    "node dist/apps/service-project/main.js" \
    "node dist/apps/service-tenant/main.js" \
    "node dist/apps/service-access/main.js" \
    "node dist/apps/service-role/main.js"

npx nest build service-account  
npx nest build service-notification  
npx nest build service-billing  
npx nest build service-project  
npx nest build service-tenant  
npx nest build service-access  
npx nest build service-role  




#npx nest start --watch api-admin

# export AUTH_GITHUB_CLIENT_ID=33b6808fddf278506048 \
# export AUTH_GITHUB_CLIENT_SECRET=97545d20aa2807df03fc68115dbf0c0840ba3a29 \
