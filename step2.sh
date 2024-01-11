git clone https://www.github.com/odoo/odoo --depth 1 --branch 16.0 /opt/odoo/odoo-16.0
cd /opt/odoo/odoo-16.0
python3 -m venv /opt/odoo/odoo-16.0/odoo-venv
source /opt/odoo/odoo-16.0/odoo-venv/bin/activate
pip3 install wheel
pip3 install -r /opt/odoo/odoo-16.0/requirements.txt
deactivate
mkdir /opt/odoo/odoo-16.0/conf
mkdir /opt/odoo/odoo-16.0/log

