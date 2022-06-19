#nginx
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
nvm install v14

echo "fs.file-max = 100000" >>/etc/sysctl.conf
sudo sysctl -p
echo "root soft     nproc          100000" >>/etc/security/limits.conf
echo "root hard     nproc          100000" >>/etc/security/limits.conf
echo "root soft     nofile         100000" >>/etc/security/limits.conf
echo "root hard     nofile         100000" >>/etc/security/limits.conf
echo "session required pam_limits.so" >>/etc/pam.d/common-session
ulimit -n

npm install pm2 -g
apt install git -y
git clone https://github.com/SpiritedAwayLab/noderun.git
cd noderun
npm i

cd /root
wget -O deploy.sh https://raw.githubusercontent.com/SpiritedAwayLab/node/main/deploy.sh
chmod a+x deploy.sh
wget -O runnode.sh https://raw.githubusercontent.com/SpiritedAwayLab/node/main/runnode.sh
chmoa a+x runnode.sh

./deploy.sh
cd noderun
node register.js
pm2 -n maintance start maintance.js
