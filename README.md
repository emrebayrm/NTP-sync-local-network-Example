# NTP-sync-local-network

Tools 

- UCARP ( sharing IP address )


### RUN 
- Run in every Nodes with just changing "this Node IP" 
		( ID )	  ( Pass )	  ( common IP )		  ( this Node IP )	    ( startup script ) 		( down script )
 sudo ucarp --vhid=42 --pass=love --addr=10.224.172.252 --srcip=10.224.172.105 --upscript=/etc/vip-up.sh --downscript=/etc/vip-down.sh -P


