#!/bin/bash

run(){
    mylog=/var/log/clock_sync.log
    cp ./ntp.conf.client /etc/
    cp ./ntp.conf.server /etc/

    cp ./vip-down.sh /etc/
    cp ./vip-up.sh /etc/

    ucarp --vhid=42 --pass=love --addr=10.224.172.252 --srcip=$(hostname -I) --upscript=/etc/vip-up.sh --downscript=/etc/vip-down.sh -P -B>> $mylog 2>&1

    echo $! >/var/run/clock_sync.pid
}

if [ "$1" == "" ]; then
    echo "Missing operation run|stop "
fi

if [ "$1" == "run" ]; then
    echo "starting ... "
    run
    exit 0
fi

if [ "$1" == "stop" ]; then
    echo "stopping ..."
    kill -9 $(cat /var/run/clock_sync.pid)
    exit 0;
fi
