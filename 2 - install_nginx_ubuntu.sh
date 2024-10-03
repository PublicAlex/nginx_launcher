#!/bin/bash

# Configuración de rutas fijas
KEY_PATH="./key/mepkey.pem"
LOCAL_PATH="./nginx_manager"
REMOTE_PATH="/home/ubuntu/nginx_manager"

# Solicitar el dominio del servidor SSH al usuario
read -p "Ingrese el dominio del servidor SSH (ejemplo: ec2-xx-xxx-xx-xx.compute-1.amazonaws.com): " SSH_DOMAIN

# Copiando datos a SSH
echo "----------------------------------------------------------------"
echo "------------------Copiando archivos...-------------------------"
echo "----------------------------------------------------------------"
scp -i "$KEY_PATH" -r "$LOCAL_PATH" ubuntu@"$SSH_DOMAIN":"$REMOTE_PATH"

# Esperar 30 segundos
echo "Esperando 30 segundos..."
sleep 30

# Ejecutar el script launcher.sh
echo "----------------------------------------------------------------"
echo "----------------Ejecutando launcher.sh-------------------------"
echo "----------------------------------------------------------------"
ssh -i "$KEY_PATH" ubuntu@"$SSH_DOMAIN" "cd $REMOTE_PATH && chmod +x launcher.sh && ./launcher.sh"

# Esperar antes de cerrar la ventana
echo "----------------------------------------------------------------"
echo "---Proceso completado. Presione Enter para salir.---------------"
echo "----------------------------------------------------------------"
read -p "Presione Enter para salir..."