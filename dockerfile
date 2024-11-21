# Etapa 1: Construcción de la aplicación Angular
FROM node:20.17.0 AS build

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar los archivos necesarios para la instalación de dependencias
COPY package*.json ./

# Instalar dependencias
RUN npm install

# Instalar Angular CLI globalmente
RUN npm install -g @angular/cli

# Copiar el resto del código fuente
COPY . .

# Construir la aplicación en modo producción
RUN ng build --configuration=production --no-progress

# Etapa 2: Configuración de NGINX
FROM nginx:latest

# Copiar los archivos generados por Angular al directorio estándar de NGINX
COPY --from=build /app/dist/frontend /usr/share/nginx/html

# Exponer el puerto 80
EXPOSE 80

# Usar el comando por defecto de NGINX
CMD ["nginx", "-g", "daemon off;"]
