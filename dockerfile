# Usa una imagen base de Python
FROM python:3.9-slim

# Establece el directorio de trabajo
WORKDIR /app

# Instala las dependencias del sistema necesarias
RUN apt-get update && apt-get install -y \
    build-essential \
    default-libmysqlclient-dev \
    pkg-config

# Copia los archivos de requirements y el código de la aplicación
COPY requirements.txt requirements.txt
COPY . .

# Instala las dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# Expone el puerto en el que corre la aplicación
EXPOSE 5000

# Define el comando de inicio
CMD ["python", "app.py"]
