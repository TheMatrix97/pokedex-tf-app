#!/bin/bash

sudo apt-get update
sudo apt-get -y upgrade

# Download dist file PokeDex release
wget https://github.com/TheMatrix97/pokedex-angular-app/releases/download/refs%2Fheads%2Fmaster/dist.tar.gz

tar -xvf dist.tar.gz

sudo mkdir -p /var/www/pokedex

sudo cp -r ./dist/pokedex/* /var/www/pokedex

# Install nginx
sudo apt-get -y install nginx

# Config nginx 
cat << EOF > /etc/nginx/sites-available/default
server {
        listen 80;
        listen [::]:80;
        root /var/www/pokedex;
        index index.html index.htm index.nginx-debian.html;
        server_name _;
        location / {
                try_files \$uri \$uri/ /index.html;
        }
        location /digimon {
            return 500;
        }
}
EOF

sudo service nginx restart
