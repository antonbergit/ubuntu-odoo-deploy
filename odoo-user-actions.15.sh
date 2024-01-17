cd /opt/odoo/odoo-15.0
python3.8 -m venv /opt/odoo/odoo-15.0/odoo-venv
source /opt/odoo/odoo-15.0/odoo-venv/bin/activate
pip3 install wheel
pip3 install -r /opt/odoo/odoo-15.0/requirements.txt
deactivate
mkdir /opt/odoo/odoo-15.0/conf
mkdir /opt/odoo/odoo-15.0/log
