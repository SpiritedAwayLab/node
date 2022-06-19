hostname=$(cat /etc/hostname)
sed -i '1d' /etc/hosts
sed -i "1i\127.0.0.1    localhost $hostname" /etc/hosts
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

##config forta
rm -rf .forta
wall=$(forta init --passphrase 5XkngQR8geRTobBj)
echo ${wall:18:42} >>/root/.forta/.walletaddress

