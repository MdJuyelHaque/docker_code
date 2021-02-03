FROM node:alpine as build
WORKDIR /app
COPY ./app/renderer /app
ENV PATH /app/node_modules/.bin:$PATH
RUN npm install
RUN npm run build-web

FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/nginx.conf /etc/nginx/conf.d
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

