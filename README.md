## README

El presente repositorio contiene los scripts necesarios para desplegar servidores EC2 de AWS usando AWS CLI. De igual modo, también cuenta con un script para desplegar Nginx Proxy Manager directamente en el servidor EC2.

Esto tiene como finalidad poder desplegar servicios web de forma muy simplificada.

### Requisitos
- Cuenta de AWS debidamente registrada y activada.
- Instalar y configurar AWS CLI en su dispositivo de trabajo.
- Crear en su panel de AWS: grupo de seguridad, ID de la subred, `key.pem`, definir el tipo de instancia y obtener el ID de la imagen a desplegar.  
  *(guiarse con el archivo `.env.example`)*
- El archivo `key.pem` debe guardarse en la carpeta `/key` con el nombre "mepkey.pem".

### Ejecución
Luego de tener instalado el servicio de AWS CLI en tu equipo y después de haber configurado las variables de ejecución, ejecuta el script `"1 - ec2_launch_win"` o `"1 - ec2_launch_ubuntu"`, según corresponda.

Esto creará la instancia EC2 en tu cuenta de AWS y, al finalizar todo, te retornará una tabla con tus instancias activas, incluyendo fechas de creación.

Posteriormente, procede a ejecutar el script `"2 - install_nginx_win"` o `"2 - install_nginx_ubuntu"`. El script te preguntará por el DNS de tu instancia EC2; ahí usarás la tabla que generó el paso anterior para obtener el DNS de tu servidor. Luego de esto, se instalará y configurará automáticamente Nginx Proxy Manager para desplegar tus servicios web.

### Nota
Estos scripts están pensados para desplegar servicios web ligeros (aplicaciones de prueba, servicios temporales o servicios sin mucha demanda). Si requiere desplegar servicios concurrentes o con mucha demanda, contáctame y usaremos herramientas profesionales para esta labor (aragonantar@gmail.com).
