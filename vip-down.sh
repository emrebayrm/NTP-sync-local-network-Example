#! /bin/sh
timestamp=$(date +%u%m%d%H%M%S)
mylog=/var/log/clock_sync.log
<<<<<<< HEAD
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
=======
echo "[$timestamp] - Going listen mode\n" >> mylog
#echo "[$timestamp] - \n" >> mylog
/sbin/ip addr del 10.224.172.252/24 dev enp0s3

echo "[$timestamp] - Config file copying \n" >> mylog
mv ntp.conf ntp.conf.bckp
cp ntp.conf.client ntp.conf
echo "[$timestamp] - Completed \n" >> mylog

echo "[$timestamp] - Service is restarting\n" >> mylog
service ntp stop
service ntp start
echo "[$timestamp] - Service restarted \n" >> mylog

echo "[$timestamp] - Host is searching ...\n" >> mylog
ntptrace >> /dev/null
echo "[$timestamp] - Done \n" >> mylog
>>>>>>> 5a7219fb926abdcbdb759c2afe43b1d8a84ba201
