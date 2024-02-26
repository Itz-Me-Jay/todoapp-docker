FROM node:lts-alpine AS installer

WORKDIR /app
COPY package*.json ./ 
RUN npm install

COPY . .
RUN npm run build

FROM nginx:alpine AS deployer
COPY --from=installer /app/build /usr/share/nginx/html
