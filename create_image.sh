cat >/root/install.sh <<EOF
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
echo "install pm2"
npm install pm2 -g
echo "install git"
apt install git -y
echo "git clone"
git clone https://github.com/SpiritedAwayLab/noderun.git /root/noderun
cd /root/noderun
echo "npm install"
npm i

cd /root
echo "wget scripts"
wget -O deploy.sh https://raw.githubusercontent.com/SpiritedAwayLab/node/main/deploy.sh
chmod a+x deploy.sh

wget -O runnode.sh https://raw.githubusercontent.com/SpiritedAwayLab/node/main/runnode.sh
chmod a+x runnode.sh

wget -O register.sh https://raw.githubusercontent.com/SpiritedAwayLab/node/main/register.sh
chmod a+x register.sh

echo "run deploy script"
/root/deploy.sh >/root/deploy.log
cd /root/noderun
echo "run register"
node register.js
echo "start maintance"
pm2 -n maintance start maintance.js
pm2 save
pm2 startupm2p
echo "delete one line"
sed -i '$ d' /etc/rc.local

EOF
chmod a+x /root/install.sh
echo "su root -c \"bash /root/install.sh > /root/install.log\"" >>/etc/rc.local
cp -rf /home/ubuntu/.ssh /root/
