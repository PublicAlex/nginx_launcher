@echo off
REM Script para crear una instancia EC2 en AWS usando variables de entorno

REM Cargar variables desde el archivo .env
for /f "tokens=1,* delims==" %%a in (.env) do (
    set %%a=%%b
)

REM Mostrar información de la configuración
echo Configuración de la instancia EC2:
echo Imagen ID: %IMAGE_ID%
echo Tipo de instancia: %INSTANCE_TYPE%
echo Nombre de la clave: %KEY_NAME%
echo ID del grupo de seguridad: %SECURITY_GROUP_ID%
echo ID de la subred: %SUBNET_ID%
echo.

REM Crear instancia
echo Creando instancia EC2...
aws ec2 run-instances --image-id %IMAGE_ID% --count 1 --instance-type %INSTANCE_TYPE% --key-name %KEY_NAME% --security-group-ids %SECURITY_GROUP_ID% --subnet-id %SUBNET_ID%

REM Esperar para que la instancia se inicialice
echo Esperando %WAIT_TIME% segundos para que la instancia se inicialice...
timeout /t %WAIT_TIME%

REM Listar las instancias en ejecución y obtener el DNS para conexión SSH
echo Obteniendo información de las instancias en ejecución...
aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query "Reservations[*].Instances[*].[InstanceId,PublicDnsName,PublicIpAddress,State.Name,LaunchTime]" --output table

echo.
echo Proceso completado. Revise la tabla anterior para obtener la información de conexión de su nueva instancia (puede observar la mas reciente segun la fecha).
pause