sudo systemctl daemon-reload
sudo systemctl enable forta

mkdir -p /etc/systemd/system/forta.service.d/
FILE=/etc/systemd/system/forta.service.d/env.conf
if [ ! -f "$FILE" ]; then
    echo "file is not exist"
    cat >/etc/systemd/system/forta.service.d/env.conf <<EOF
[Service]
Environment="FORTA_DIR=/root/.forta"
Environment="FORTA_PASSPHRASE=5XkngQR8geRTobBj"
EOF
    sudo systemctl daemon-reload
fi

sudo systemctl start forta
