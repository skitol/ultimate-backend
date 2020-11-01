FROM node:12-alpine
# set our node environment, either development or production
# defaults to production, compose overrides this to development on build and run
ARG NODE_ENV=production
ENV NODE_ENV $NODE_ENV

RUN mkdir -p /nest
ADD . /nest

WORKDIR /nest

#RUN yarn global add @nestjs/cli

RUN yarn install

# Build production files
#RUN yarn nest build proto-schema
# RUN yarn nest build service-account  
# RUN yarn nest build service-notification  
# RUN yarn nest build service-billing  
# RUN yarn nest build service-project  
# RUN yarn nest build service-tenant  
# RUN yarn nest build service-access  
# RUN yarn nest build service-role  
## RUN yarn nest build api-admin
# Bundle app source
#COPY . .

#EXPOSE 50020
#CMD ["node", "dist/apps/api-admin/main.js"]
