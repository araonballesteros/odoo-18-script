# Odoo 18 Installation Script

Este repositorio contiene un script para instalar **Odoo 18 Community Edition** en Ubuntu 24.04.2 LTS.

## Cómo ejecutar el script

1. Clona este repositorio o copia su contenido en tu servidor Ubuntu 24.04.2 LTS.
2. Accede al directorio `odoo-18-script` donde se encuentra el archivo `install_odoo18.sh`.
3. Otorga permisos de ejecución si es necesario:
   ```bash
   chmod +x install_odoo18.sh
   ```
4. Ejecuta el script con privilegios de superusuario:
   ```bash
   sudo ./install_odoo18.sh
   ```
   El proceso instalará todas las dependencias, creará el usuario del sistema `odoo18` y dejará Odoo escuchando en [http://127.0.0.1:8069](http://127.0.0.1:8069).

- Si el script se detiene por un error, se mostrará en pantalla el comando y la línea que lo provocaron, para que puedas corregirlo antes de volver a ejecutarlo.
## Ejemplo para usuarios novatos

1. Crea una máquina virtual en **VirtualBox** con Ubuntu 24.04.2 LTS (puedes asignar 2 GB de RAM y 2 núcleos).
2. Desde tu sistema anfitrión abre una terminal y accede a la VM. Para este ejemplo la IP del servidor será `127.0.0.1` (también puedes usar `localhost`).
3. Copia este repositorio a la VM y ejecuta el script como se indicó antes:

```bash
sudo ./install_odoo18.sh
```

El script instalará todas las dependencias y dejará Odoo escuchando en [http://127.0.0.1:8069](http://127.0.0.1:8069).

## Acceso inicial a Odoo

1. Una vez finalizada la instalación, abre un navegador en tu equipo y visita `http://127.0.0.1:8069`.
2. Para crear la base de datos introduce la contraseña maestra **admin** (configurada por el script).
3. Registra tus datos de administrador. Como ejemplo puedes usar el usuario `aaron` con el correo `aaron@example.com` y la contraseña que prefieras.

¡Listo! Con estos pasos tendrás Odoo 18 funcionando en tu VM.
