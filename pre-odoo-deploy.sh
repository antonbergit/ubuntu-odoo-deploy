apt update -y && apt upgrade -y
apt install -y mc git curl python3-pip nodejs build-essential wget python3-dev python3-venv python3-wheel libfreetype6-dev libxml2-dev libzip-dev libldap2-dev libsasl2-dev python3-setuptools node-less libjpeg-dev zlib1g-dev libpq-dev libxslt1-dev libldap2-dev libtiff5-dev libjpeg8-dev libopenjp2-7-dev liblcms2-dev libwebp-dev libharfbuzz-dev libfribidi-dev libxcb1-dev openssl build-essential libssl-dev libxrender-dev git-core libx11-dev libxext-dev libfontconfig1-dev libfreetype6-dev fontconfig
useradd -m -d /opt/odoo -U -r -s /bin/bash odoo
apt install postgresql
su - postgres -c "createuser -s odoo"
wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
tar xvf wkhtmltox*.tar.xz
mv wkhtmltox/bin/wkhtmlto* /usr/bin

su -u odoo bash -c /root/odoo-14-deploy.sh

conf='/opt/odoo/odoo-14.0/conf/odoo14.0.conf'
touch $conf
echo '[options]' >> $conf
echo 'logfile=/opt/odoo/odoo-14.0/log/odoo14.0.log' >> $conf
echo 'admin_passwd = Spoc2022' >> $conf
echo 'db_host = False' >> $conf
echo 'db_port = False' >> $conf
echo 'db_user = odoo' >> $conf
echo 'db_password = False' >> $conf
echo 'addons_path = /opt/odoo/odoo-14.0/odoo/addons,/opt/odoo/odoo-14.0/assembly_dist' >> $conf
echo 'limit_time_cpu = 6000' >> $conf
echo 'limit_time_real = 12000' >> $conf
echo 'max_cron_threads = 1'
echo 'workers = 3'

serv='/etc/systemd/system/odoo14.service'
touch $serv
echo '[Unit]' >> $serv
echo 'Description=Odoo 14 CE' >> $serv
echo 'Requires=postgresql.service' >> $serv
echo 'After=network.target postgresql.service' >> $serv
echo '[Service]' >> $serv
echo 'Type=simple' >> $serv
echo 'SyslogIdentifier=odoo14' >> $serv
echo 'PermissionsStartOnly=true' >> $serv
echo 'User=odoo' >> $serv
echo 'Group=odoo' >> $serv
echo 'ExecStart=/opt/odoo/odoo-14.0/odoo-venv/bin/python3 /opt/odoo/odoo-14.0/odoo-bin -c /opt/odoo/odoo-14.0/conf/odoo14.0.conf' >> $serv
echo 'StandardOutput=journal+console' >> $serv
echo '[Install]' >> $serv
echo 'WantedBy=multi-user.target' >> $serv

systemctl daemon-reload
systemctl enable --now odoo

