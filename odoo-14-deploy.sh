git clone https://www.github.com/odoo/odoo --depth 1 --branch 14.0 /opt/odoo/odoo14.0
cd /opt/odoo/odoo14.0
python3 -m venv odoo-venv
source odoo-venv/bin/activate
pip3 install wheel
pip3 install -r odoo/requirements.txt
deactivate
mkdir /opt/odoo/odoo14.0/conf
mkdir /opt/odoo/odoo14.0/log

