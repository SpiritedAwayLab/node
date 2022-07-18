cat >/root/start.sh <<EOF
#!/bin/bash
FILE=/root/deploy.sh
[ ! -f "$FILE" ] && curl -o- https://raw.githubusercontent.com/SpiritedAwayLab/node/main/install.sh | bash
EOF
chmod a+x /root/start.sh

cat >>/etc/rc.local <<EOF
/root/start.sh > /root/start.log
EOF
