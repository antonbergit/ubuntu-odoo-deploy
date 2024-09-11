#!/bin/bash

apt update -y && apt upgrade -y
apt install apg nginx snapd -y
snap install --classic certbot

TMPUSR=support
TMPPWD=$(apg -a 1 -M ncl -E 1lO0 -n 1 -m 20 -x 20 -d -q)
ODOPWD=$(apg -a 1 -M ncl -E 1lO0 -n 1 -m 20 -x 20 -d -q)
ADMPWD=$(apg -a 1 -M ncl -E 1lO0 -n 1 -m 20 -x 20 -d -q)
echo ${TMPUSR}:${TMPPWD} > env_info.log
echo 'ODOPWD':${ODOPWD} >> env_info.log
echo 'ADMPWD':${ADMPWD} >> env_info.log

addgroup ssh
addgroup odoo
useradd -d /home/support -s /bin/bash -G sudo,ssh,odoo -m -p $(openssl passwd -1 ${TMPPWD}) ${TMPUSR}

/usr/bin/sed -i '/^'"AllowGroups "'/d' /etc/ssh/sshd_config
/usr/bin/sed -i '/^'"PasswordAuthentication "'/d' /etc/ssh/sshd_config
/usr/bin/sed -i '/^'"PermitEmptyPasswords "'/d' /etc/ssh/sshd_config

/usr/bin/echo "AllowGroups ssh root" >> /etc/ssh/sshd_config
/usr/bin/echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
/usr/bin/echo "PermitEmptyPasswords no" >> /etc/ssh/sshd_config

locale-gen uk_UA && locale-gen uk_UA.UTF-8 && locale-gen en_US && locale-gen en_US.UTF-8 && update-locale

timedatectl set-timezone Europe/Kiev

systemctl restart sshd

cat env_info.log
