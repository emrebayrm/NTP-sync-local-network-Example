#! /bin/bash
timestamp=$(date +"%Y-%m-%d %H:%M:%S")
mylog=/var/log/clock_sync.log

echo "[$timestamp] - Going broadcast mode" >> $mylog
#echo "[$timestamp] - \n" >> mylog
ntpdate -u 10.224.172.252 >> $mylog
if [ $3 -eq "slave" ] && [ $? -eq 0 ]; then
	echo "[$timestamp] - Look like master still awake" >> $mylog
	exit 0
fi
/sbin/ip addr add 10.224.172.252/24 dev enp0s3

echo "[$timestamp] - Config file copying" >> $mylog
mv /etc/ntp.conf /etc/ntp.conf.bckp
cp /etc/ntp.conf.server /etc/ntp.conf
echo "[$timestamp] - Completed" >> $mylog

echo "[$timestamp] - Service is restarting" >> $mylog
service ntp stop
service ntp start
echo "[$timestamp] - Service restarted" >> $mylog
