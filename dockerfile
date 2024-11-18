FROM node:18.13.0 as build

WORKDIR /app

COPY package*.json ./

RUN npm install

RUN npm install -g @angular/cli

COPY . .

RUN ng build --configuration=production --no-progress

FROM nginx:latest

# Asegúrate de que la ruta aquí coincida con el outputPath de Angular
COPY --from=build /app/dist/aftas-angular /usr/share/nginx/html

EXPOSE 80
