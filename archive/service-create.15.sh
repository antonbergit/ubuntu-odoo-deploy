serv='/etc/systemd/system/odoo15.service'
touch $serv
echo '[Unit]' > $serv
echo 'Description=Odoo 15 CE' >> $serv
echo 'Requires=postgresql.service' >> $serv
echo 'After=network.target postgresql.service' >> $serv
echo '[Service]' >> $serv
echo 'Type=simple' >> $serv
echo 'SyslogIdentifier=odoo15' >> $serv
echo 'PermissionsStartOnly=true' >> $serv
echo 'User=odoo' >> $serv
echo 'Group=odoo' >> $serv
echo 'ExecStart=/opt/odoo/odoo-15.0/odoo-venv/bin/python3 /opt/odoo/odoo-15.0/odoo-bin -c /opt/odoo/odoo-15.0/conf/odoo15.0.conf' >> $serv
echo 'StandardOutput=journal+console' >> $serv
echo '[Install]' >> $serv
echo 'WantedBy=multi-user.target' >> $serv

systemctl daemon-reload
systemctl enable --now odoo15.service
