#Build Phase
# Use an existing docker image as a base
FROM node:alpine as builder

WORKDIR /app

# Download and install a dependency
COPY ./package.json ./
RUN npm install

COPY ./ ./

RUN npm run build


#Run Phase
# Use Nginx docker image as a base
FROM nginx:alpine as runner
EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html