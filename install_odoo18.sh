#!/bin/bash

# Odoo 18 Community Edition Installation Script
# Author: Aaron Ballesteros, SofBiz Technologies – 2025

# Cómo copiar este script a tu servidor
# 1. Ubica el archivo `install_odoo18.sh` en tu equipo local. Por ejemplo en
#    `C:\descargas`.
# 2. Copia el archivo a tu VM o VPS con `scp` (puedes usar Git Bash o WSL):
#      scp C:\descargas\install_odoo18.sh usuario@IP_DEL_SERVIDOR:/home/usuario/
#    Reemplaza `usuario` e `IP_DEL_SERVIDOR` por los datos de tu instancia. El
#    archivo se copiará a `/home/usuario/` aunque puedes elegir otra ruta.
# 3. Conéctate vía SSH:
#      ssh usuario@IP_DEL_SERVIDOR
# 4. Ubica el directorio donde copiaste el script y dale permisos de ejecución:
#      chmod +x install_odoo18.sh
# 5. Ejecuta el instalador con privilegios de administrador:
#      sudo ./install_odoo18.sh

set -Ee
trap 'exit_code=$?; echo "El script se detuvo en la línea ${BASH_LINENO[0]} ejecutando: ${BASH_COMMAND}. Código de salida: ${exit_code}" >&2' ERR

if [ $(id -u) -ne 0 ]; then
    echo "Este script debe ejecutarse como root o con sudo."
    exit 1
fi

# Mostrar información del sistema
echo "===== Instalación Odoo 18 Community Edition ====="
echo "Autor: Aaron Ballesteros, SofBiz Technologies – 2025"
lsb_release -a

# Actualizar el sistema
echo "Actualizando el sistema..."
apt update && apt -y upgrade

# Instalar PostgreSQL
echo "Instalando PostgreSQL..."
apt install -y postgresql
systemctl status postgresql --no-pager | grep Active

# Crear usuario del sistema odoo18
if id "odoo18" >/dev/null 2>&1; then
    echo "El usuario odoo18 ya existe"
else
    useradd -m -d /opt/odoo18 -U -r -s /bin/bash odoo18
    echo "Usuario del sistema odoo18 creado"
fi

# Crear usuario de PostgreSQL
sudo -u postgres createuser -s odoo18 || true

# Instalar dependencias de Python y herramientas
echo "Instalando dependencias de Python y librerías necesarias..."
apt install -y git wget python3-pip python3-venv build-essential \
    libxslt-dev libzip-dev libldap2-dev libsasl2-dev python3-dev \
    libjpeg-dev libpq-dev libxml2-dev libffi-dev libssl-dev \
    pkg-config node-less libjpeg8-dev zlib1g-dev

# Instalar wkhtmltopdf
echo "Instalando wkhtmltopdf..."
WKHTML_DEB=wkhtmltox_0.12.6-1.jammy_amd64.deb
if wget -q https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.6/$WKHTML_DEB; then
    apt install -y ./$WKHTML_DEB
    rm -f $WKHTML_DEB
else
    echo "Descarga directa fall\u00f3, instalando wkhtmltopdf desde apt..."
    apt install -y wkhtmltopdf
fi

# Descargar código de Odoo
echo "Clonando código de Odoo 18 Community Edition..."
if [ ! -d /opt/odoo18/odoo ]; then
    sudo -H -u odoo18 git clone --depth 1 --branch 18.0 https://github.com/odoo/odoo.git /opt/odoo18/odoo
fi

# Crear entorno virtual
echo "Creando entorno virtual..."
if [ ! -d /opt/odoo18/odoo-venv ]; then
    sudo -H -u odoo18 python3 -m venv /opt/odoo18/odoo-venv
fi

sudo -H -u odoo18 /opt/odoo18/odoo-venv/bin/pip install --upgrade pip wheel
sudo -H -u odoo18 /opt/odoo18/odoo-venv/bin/pip install -r /opt/odoo18/odoo/requirements.txt

# Directorio para addons personalizados
mkdir -p /opt/odoo18/odoo-custom-addons
chown odoo18:odoo18 /opt/odoo18/odoo-custom-addons

# Crear archivo de configuración
cat <<'CFG' > /etc/odoo18.conf
[options]
admin_passwd = admin
db_user = odoo18
db_host = False
db_port = False
db_password = False
addons_path = /opt/odoo18/odoo/addons,/opt/odoo18/odoo-custom-addons
xmlrpc_port = 8069
longpolling_port = 8072
workers = 2
CFG
chown odoo18:odoo18 /etc/odoo18.conf
chmod 640 /etc/odoo18.conf

# Crear servicio systemd
cat <<'SERVICE' > /etc/systemd/system/odoo18.service
[Unit]
Description=Odoo18
Requires=postgresql.service
After=network.target postgresql.service

[Service]
Type=simple
SyslogIdentifier=odoo18
User=odoo18
Group=odoo18
ExecStart=/opt/odoo18/odoo-venv/bin/python /opt/odoo18/odoo/odoo-bin -c /etc/odoo18.conf

[Install]
WantedBy=multi-user.target
SERVICE

# Habilitar e iniciar el servicio
systemctl daemon-reload
systemctl enable --now odoo18

echo "Odoo 18 está instalado y ejecutándose en http://127.0.0.1:8069"

cat <<'EOM'

===== Instrucciones para acceder =====
1. Abra su navegador y vaya a http://127.0.0.1:8069
2. Use la contraseña maestra **admin** para crear la base de datos.
3. Como ejemplo, introduzca el usuario *aaron* y la contraseña que desee.

EOM

