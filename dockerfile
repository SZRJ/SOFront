# Usar una imagen base con Node.js
FROM node:20.17.0 AS build-stage

# Crear el directorio de la aplicación dentro del contenedor
WORKDIR /usr/src/app

# Copiar package.json y package-lock.json para instalar dependencias
COPY package*.json ./

# Instalar las dependencias de Angular
RUN npm install

# Copiar todo el proyecto al contenedor
COPY . .

# Exponer el puerto 8080 para servir la aplicación
EXPOSE 8080

# Comando para iniciar Angular en modo desarrollo con ng serve
CMD ["npx", "ng", "serve", "--host", "0.0.0.0", "--port", "8080"]
