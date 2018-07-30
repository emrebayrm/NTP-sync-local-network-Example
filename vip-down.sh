#! /bin/bash
timestamp=$(date +%u%m%d%H%M%S)
mylog=/var/log/clock_sync.log

echo "[$timestamp] - Going listen mode" >> $mylog
#echo "[$timestamp] - \n" >> mylog
/sbin/ip addr del 10.224.172.252/24 dev enp0s3

echo "[$timestamp] - Config file copying" >> $mylog
mv /etc/ntp.conf /etc/ntp.conf.bckp
cp /etc/ntp.conf.client /etc/ntp.conf
echo "[$timestamp] - Completed" >> $mylog

echo "[$timestamp] - Service is restarting" >> $mylog
service ntp stop
service ntp start
echo "[$timestamp] - Service restarted" >> $mylog

echo "[$timestamp] - Host is searching ..." >> $mylog
ntptrace >> /dev/null
echo "[$timestamp] - Done" >> $mylog

