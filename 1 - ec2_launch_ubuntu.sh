#!/bin/bash
# Script para crear una instancia EC2 en AWS usando variables de entorno

# Cargar variables desde el archivo .env
export $(grep -v '^#' .env | xargs)

# Mostrar información de la configuración
echo "Configuración de la instancia EC2:"
echo "Imagen ID: $IMAGE_ID"
echo "Tipo de instancia: $INSTANCE_TYPE"
echo "Nombre de la clave: $KEY_NAME"
echo "ID del grupo de seguridad: $SECURITY_GROUP_ID"
echo "ID de la subred: $SUBNET_ID"
echo

# Crear instancia
echo "Creando instancia EC2..."
aws ec2 run-instances --image-id $IMAGE_ID --count 1 --instance-type $INSTANCE_TYPE --key-name $KEY_NAME --security-group-ids $SECURITY_GROUP_ID --subnet-id $SUBNET_ID

# Esperar para que la instancia se inicialice
echo "Esperando $WAIT_TIME segundos para que la instancia se inicialice..."
sleep $WAIT_TIME

# Listar las instancias en ejecución y obtener el DNS para conexión SSH
echo "Obteniendo información de las instancias en ejecución..."
aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query "Reservations[*].Instances[*].[InstanceId,PublicDnsName,PublicIpAddress,State.Name,LaunchTime]" --output table

echo
echo "Proceso completado. Revise la tabla anterior para obtener la información de conexión de su nueva instancia (puede observar la más reciente según la fecha)."
