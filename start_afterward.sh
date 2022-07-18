##config forta
hostname=forta$(curl http://93.179.127.18:36124/latestid)
echo $hostname >/etc/hostname
sed -i '1d' /etc/hosts
sed -i "1i\127.0.0.1    localhost $hostname" /etc/hosts

sudo rm -rf .forta
wall=$(forta init --passphrase 5XkngQR8geRTobBj)
echo ${wall:18:42} >>/root/.forta/.walletaddress

cd noderun
node=/root/.nvm/versions/node/v14.20.0/bin/node
pm2=/root/.nvm/versions/node/v14.20.0/bin/pm2
node /root/noderun/register.js
pm2 -n maintance start /root/noderun/maintance.js
pm2 save
pm2 startup
