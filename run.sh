#! bin/sh

cp ./ntp.conf.client /etc/
cp ./ntp.conf.server /etc/

cp ./vip-down.sh /etc/
cp ./vip-up.sh /etc/

ucarp --vhid=42 --pass=love --addr=10.224.172.252 --srcip=$(hostname -I) --upscript=/etc/vip-up.sh --downscript=/etc/vip-down.sh -P