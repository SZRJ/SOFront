# Etapa 1: Construcción de la aplicación Angular
FROM node:20.17.0 AS build

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia los archivos de dependencias (para aprovechar la cache de Docker)
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Instala Angular CLI globalmente
RUN npm install -g @angular/cli

# Copia todo el código fuente al contenedor
COPY . .

# Compila la aplicación Angular en modo producción
RUN ng build --configuration=production --no-progress

# Depuración: Verifica si la carpeta de salida se generó correctamente
RUN ls -l /app/dist/

# Etapa 2: Configuración del servidor NGINX para servir la aplicación
FROM nginx:latest

# Copia los archivos de Angular construidos a la carpeta estándar de NGINX
# Cambia '/app/dist/aftas-angular' si el outputPath es diferente
COPY --from=build /app/dist/aftas-angular /usr/share/nginx/html

# Exponer el puerto 80 para NGINX
EXPOSE 80

# Inicia NGINX (comando predeterminado del contenedor base)
