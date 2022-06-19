wget -O /root/.forta/config.yml http://forta.oss-us-east-1.aliyuncs.com/$1.yml
forta register --passphrase 5XkngQR8geRTobBj --owner-address 0xa9c8dD9fA20cbdBC0C360c27a8dEBC439ffd1335

sudo systemctl daemon-reload
sudo systemctl enable forta

mkdir -p /etc/systemd/system/forta.service.d/
cat >/etc/systemd/system/forta.service.d/env.conf <<EOF
[Service]
Environment="FORTA_DIR=/root/.forta"
Environment="FORTA_PASSPHRASE=5XkngQR8geRTobBj"
EOF
sudo systemctl start forta
