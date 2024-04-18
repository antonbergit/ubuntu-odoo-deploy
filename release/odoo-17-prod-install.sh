#!/bin/bash

apt install apg -y

TMPUSR=support
TMPPWD=$(apg -a 1 -M ncl -E 1lO0 -n 1 -m 14 -x 14 -d -q)
ODOPWD=$(apg -a 1 -M ncl -E 1lO0 -n 1 -m 14 -x 14 -d -q)
echo ${TMPUSR}:${TMPPWD} > info.log

addgroup ssh
addgroup odoo
useradd -d /home/support -s /bin/bash -G sudo,ssh,odoo -m -p${TMPPWD} ${TMPUSR}

/usr/bin/sed -i '/^'"AllowGroups "'/d' /etc/ssh/sshd_config
/usr/bin/sed -i '/^'"PermitRootLogin "'/d' /etc/ssh/sshd_config
/usr/bin/sed -i '/^'"PasswordAuthentication "'/d' /etc/ssh/sshd_config
/usr/bin/sed -i '/^'"PermitEmptyPasswords "'/d' /etc/ssh/sshd_config

/usr/bin/echo "AllowGroups ssh" >> /etc/ssh/sshd_config
/usr/bin/echo "PermitRootLogin no" >> /etc/ssh/sshd_config
/usr/bin/echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
/usr/bin/echo "PermitEmptyPasswords no" >> /etc/ssh/sshd_config

systemctl restart sshd

locale-gen uk_UA
locale-gen uk_UA.UTF-8
locale-gen en_US
locale-gen en_US.UTF-8
update-locale

timedatectl set-timezone Europe/Kiev

apt install nginx -y
apt install snapd -y
snap install --classic certbot

wget -O /tmp/odoo-helper-install.bash https://gitlab.com/katyukha/odoo-helper-scripts/raw/master/install-system.bash;
bash /tmp/odoo-helper-install.bash;
odoo-helper install pre-requirements
odoo-helper install postgres
odoo-helper install postgres odoo odoo

odoo-install --install-dir /opt/odoo-17.0 --odoo-version 17.0 --odoo-branch 17.0 --download-archive on --single-branch on --build-python 3.10.13 --http-port 8069 --conf-opt-admin_passwd ${ODOPWD} --conf-opt-workers 3 --conf-opt-proxy_mode True --sys-deps --ikwid

chown -R ${TMPUSR}:odoo /opt/odoo-17.0

ln -s /opt/odoo-17.0/odoo-helper.conf /home/support

cat info.log

echo "sudo su postgres"
echo "psql"
echo "UPDATE pg_database SET datcollate='en_US.UTF-8', datctype='en_US.UTF-8' WHERE datname='template0';"
echo "quit"
echo "exit"
echo ""
echo "passwd support"
echo "reboot"
