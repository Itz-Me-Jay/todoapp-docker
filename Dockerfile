FROM node:18-alpine AS installer
WORKDIR /app
COPY package*.json ./
RUN npm install -g npm@10.4.0
COPY . .
RUN npm install react-scripts
RUN npm run build
FROM nginx:latest AS deployer
COPY --from=installer /app/build /usr/share/nginx/html
