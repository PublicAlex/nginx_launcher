@echo off
REM Configuración de rutas fijas
set KEY_PATH=./key/mepkey.pem
set LOCAL_PATH=./nginx_manager
set REMOTE_PATH=/home/ubuntu/nginx_manager

REM Solicitar el dominio del servidor SSH al usuario
set /p SSH_DOMAIN=Ingrese el dominio del servidor SSH (ejemplo: ec2-xx-xxx-xx-xx.compute-1.amazonaws.com): 

REM Copiando datos a SSH
echo ----------------------------------------------------------------
echo ------------------Copiando archivos...--------------------------
echo ----------------------------------------------------------------

scp -i %KEY_PATH% -r %LOCAL_PATH% ubuntu@%SSH_DOMAIN%:%REMOTE_PATH%

REM Esperar 30 segundos
echo Esperando 30 segundos...
timeout /t 30

REM Ejecutar el script launcher.sh
echo ----------------------------------------------------------------
echo ----------------Ejecutando launcher.sh...-----------------------
echo ----------------------------------------------------------------

ssh -i %KEY_PATH% ubuntu@%SSH_DOMAIN% "cd %REMOTE_PATH% && chmod +x launcher.sh && ./launcher.sh"

REM Esperar antes de cerrar la ventana
echo ----------------------------------------------------------------
echo ---Proceso completado. Presione cualquier tecla para salir.-----
echo ----------------------------------------------------------------

pause