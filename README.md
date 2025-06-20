# Odoo 18 Installation Script

Este repositorio contiene un script para instalar **Odoo 18 Community Edition** en Ubuntu 24.04.2 LTS.

## Ejemplo para usuarios novatos

1. Crea una máquina virtual en **VirtualBox** con Ubuntu 24.04.2 LTS (puedes asignar 2 GB de RAM y 2 núcleos).
2. Desde tu sistema anfitrión abre una terminal y accede a la VM. Para este ejemplo la IP del servidor será `127.0.0.1` (también puedes usar `localhost`).
3. Copia este repositorio a la VM y ejecuta el script con privilegios de superusuario:

```bash
sudo bash install_odoo18.sh
```

El script instalará todas las dependencias y dejará Odoo escuchando en [http://127.0.0.1:8069](http://127.0.0.1:8069).

## Acceso inicial a Odoo

1. Una vez finalizada la instalación, abre un navegador en tu equipo y visita `http://127.0.0.1:8069`.
2. Para crear la base de datos introduce la contraseña maestra **admin** (configurada por el script).
3. Registra tus datos de administrador. Como ejemplo puedes usar el usuario `aaron` con el correo `aaron@example.com` y la contraseña que prefieras.

¡Listo! Con estos pasos tendrás Odoo 18 funcionando en tu VM.
