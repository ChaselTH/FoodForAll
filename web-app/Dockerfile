FROM node:16-alpine AS build

WORKDIR /app

ARG REACT_APP_API_BASE_URL=http://localhost:8000/
ENV REACT_APP_API_BASE_URL=${REACT_APP_API_BASE_URL}

COPY web-app/package.json web-app/package-lock.json ./
RUN npm ci

COPY web-app/ .
RUN npm run build

FROM nginx:alpine

COPY web-app/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
