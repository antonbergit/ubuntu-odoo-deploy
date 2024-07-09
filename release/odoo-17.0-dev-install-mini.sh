#!/bin/bash

wget -O /tmp/odoo-helper-install.bash https://gitlab.com/katyukha/odoo-helper-scripts/raw/master/install-system.bash;
bash /tmp/odoo-helper-install.bash;
odoo-helper install pre-requirements
odoo-helper install postgres
odoo-helper install postgres odoo odoo

odoo-install --install-dir /opt/odoo-17.0 --odoo-version 17.0 --odoo-branch 17.0 --download-archive on --single-branch on --build-python 3.10.13 --http-port 8069 --conf-opt-admin_passwd Bla-blA --conf-opt-workers 3 --conf-opt-proxy_mode False --conf-opt-gevent_port 8072 --sys-deps --ikwid

chown -R $USER:odoo /opt/odoo-17.0

ln -s /opt/odoo-17.0/odoo-helper.conf /home/$USER
