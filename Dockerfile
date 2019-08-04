# in this step we want to create a build for our project
# for that we need to use node that's why we choose node:alpine
# then we specified the work directory to be '/app'
# then we copied the package.josn and run npm install to install the packages
# then we copy the rest of files
# then make  a build for our project
# we copied first our package.json cause we don't want to rerun it every time we change in a file
# docker will be updated when we change a file from the COPY . . again and eventually we run npm build
# when npm build finished we get a folder /build which has the js required to run the website
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm build
 
# docker will know that now in the next step from the word FROM
# we specify the container we want to use nginx and the copy from the last stage ( we called builder ) the folder
# build and put it in the html according to the doc from nginx
# elsasticbeanstalk will look the EXPOSE and map to port 80
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /user/share/nginx/html