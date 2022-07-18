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
chmod a+x runnode.sh

wget -O register.sh https://raw.githubusercontent.com/SpiritedAwayLab/node/main/register.sh
chmod a+x register.sh

sudo systemctl enable systemd-timesyncd
sudo systemctl start systemd-timesyncd
timedatectl status

##install docker

sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y

sudo mkdir -p /etc/apt/keyrings
rm /etc/apt/keyrings/docker.gpg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

cat >/etc/docker/daemon.json <<EOF
{
   "default-address-pools": [
        {
            "base":"172.17.0.0/12",
            "size":16
        },
        {
            "base":"192.168.0.0/16",
            "size":20
        },
        {
            "base":"10.99.0.0/16",
            "size":24
        }
    ]
}
EOF

##install forta
sudo curl https://dist.forta.network/pgp.public -o /usr/share/keyrings/forta-keyring.asc -s
echo 'deb [signed-by=/usr/share/keyrings/forta-keyring.asc] https://dist.forta.network/repositories/apt stable main' | sudo tee -a /etc/apt/sources.list.d/forta.list
sudo apt-get update
sudo apt-get install forta
