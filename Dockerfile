FROM node:lts-alpine AS installer

WORKDIR /src
COPY package*.json package-lock.json ./
COPY . .
RUN npm config set registry https://registry.npmjs.org/
RUN npm install
RUN npm run build

FROM nginx:alpine AS deployer
COPY --from=installer /src/build /usr/share/nginx/html
