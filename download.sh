id=$1
wget http://file.yios.io/${id}.tar.gz
mv -f .forta .forta2
mkdir .forta && tar -xvf ${id}.tar.gz -C .forta
