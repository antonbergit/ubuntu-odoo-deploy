conf='/opt/odoo/odoo-16.0/conf/odoo16.0.conf'
touch $conf
echo '[options]' > $conf
echo 'logfile=/opt/odoo/odoo-16.0/log/odoo16.0.log' >> $conf
echo 'admin_passwd = Spoc2022' >> $conf
echo 'db_host = False' >> $conf
echo 'db_port = False' >> $conf
echo 'db_user = odoo' >> $conf
echo 'db_password = False' >> $conf
echo 'addons_path = /opt/odoo/odoo-16.0/odoo/addons,/opt/odoo/odoo-16.0/addons' >> $conf
echo 'limit_time_cpu = 6000' >> $conf
echo 'limit_time_real = 12000' >> $conf
echo 'max_cron_threads = 1' >> $conf
echo 'workers = 3' >> $conf

serv='/etc/systemd/system/odoo16.service'
touch $serv
echo '[Unit]' > $serv
echo 'Description=Odoo 16 CE' >> $serv
echo 'Requires=postgresql.service' >> $serv
echo 'After=network.target postgresql.service' >> $serv
echo '[Service]' >> $serv
echo 'Type=simple' >> $serv
echo 'SyslogIdentifier=odoo16' >> $serv
echo 'PermissionsStartOnly=true' >> $serv
echo 'User=odoo' >> $serv
echo 'Group=odoo' >> $serv
echo 'ExecStart=/opt/odoo/odoo-16.0/odoo-venv/bin/python3 /opt/odoo/odoo-16.0/odoo-bin -c /opt/odoo/odoo-16.0/conf/odoo16.0.conf' >> $serv
echo 'StandardOutput=journal+console' >> $serv
echo '[Install]' >> $serv
echo 'WantedBy=multi-user.target' >> $serv

systemctl daemon-reload
systemctl enable --now odoo16.service

