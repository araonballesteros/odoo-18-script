# Odoo 18 Installation Script

Este repositorio contiene un script para instalar **Odoo 18 Community Edition** en Ubuntu 24.04.2 LTS. El script está pensado para entornos de desarrollo locales o máquinas virtuales.

## Cómo copiar el script a tu servidor

1. Ubica el archivo `install_odoo18.sh` en tu equipo local. En este ejemplo se
   supone que se descargó en `C:\descargas`.
2. Copia el archivo a tu VM o VPS con `scp` (debes tener `scp` disponible en tu
   sistema, por ejemplo mediante Git Bash o WSL):

   ```bash
   scp C:\descargas\install_odoo18.sh usuario@IP_DEL_SERVIDOR:/home/usuario/
   ```

   - Reemplaza `usuario` e `IP_DEL_SERVIDOR` por los datos de tu instancia.
   - El archivo se copiará al directorio `/home/usuario/` del servidor, aunque
     puedes elegir otra ruta si lo prefieres.
3. Conéctate al servidor mediante SSH:

   ```bash
   ssh usuario@IP_DEL_SERVIDOR
   ```
4. Una vez dentro de la VM o VPS, sitúate en el directorio donde copiaste el
   script y dale permisos de ejecución:

   ```bash
   chmod +x install_odoo18.sh
   ```

5. Ejecuta el instalador con privilegios de administrador:

   ```bash
   sudo ./install_odoo18.sh
   ```

El script realizará todos los pasos necesarios para dejar Odoo escuchando en [http://127.0.0.1:8069](http://127.0.0.1:8069).

Si prefieres no anteponer `sudo` en cada ejecución, puedes iniciar sesión como
`root` y luego lanzar el script directamente.


