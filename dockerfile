FROM node:20.17.0 as build

WORKDIR /app

COPY package*.json ./

RUN npm install

RUN npm install -g @angular/cli

COPY . .

RUN ng build --configuration=production --no-progress

FROM nginx:latest

# Copia los archivos de la aplicación Angular construida a la carpeta estándar de NGINX
COPY --from=build /app/dist/frontend/browser /usr/share/nginx/html

# Exponer el puerto 80 para NGINX
EXPOSE 80
