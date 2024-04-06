#STEP 1 - INSTALLATIONS
apt update -y && apt upgrade -y
apt install -y mc git curl wget build-essential node-less openssl python3-pip python3-dev python3-venv python3-wheel libfreetype6-dev libxml2-dev libzip-dev libldap2-dev libsasl2-dev python3-setuptools libjpeg-dev zlib1g-dev libpq-dev libxslt1-dev libldap2-dev libtiff5-dev libjpeg8-dev libopenjp2-7-dev liblcms2-dev libwebp-dev libharfbuzz-dev libfribidi-dev libxcb1-dev libssl-dev libxrender-dev git-core libx11-dev libxext-dev libfontconfig1-dev libfreetype6-dev fontconfig
apt install -y software-properties-common
add-apt-repository ppa:deadsnakes/ppa
apt install -y python3.8
apt install -y python3.8 python3.8-dev python3.8-venv
wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
tar xvf wkhtmltox*.tar.xz
mv wkhtmltox/bin/wkhtmlto* /usr/bin
useradd -m -d /opt/odoo -U -r -s /bin/bash odoo
apt install -y postgresql
su - postgres -c "createuser -s odoo"
