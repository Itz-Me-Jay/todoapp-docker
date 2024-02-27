FROM node:lts-alpine AS installer

WORKDIR /src
COPY package*.json ./ 
RUN npm config set registry https://registry.npmjs.org/

RUN npm ci



COPY . .
RUN npm run build

FROM nginx:alpine AS deployer
COPY --from=installer /src/build /usr/share/nginx/html
