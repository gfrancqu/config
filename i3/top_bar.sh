#!/bin/bash

 # Color directory
CD="$HOME/.Xresources"

# Fetch the Colors
BG=$(cat ${CD} | grep -i background | tail -c 8)
COLOR1=$(cat ${CD} | grep -i color0| tail -c 8)
COLOR2=$(cat ${CD} | grep -i color1| tail -c 8)
COLOR3=$(cat ${CD} | grep -i color2| tail -c 8)
COLOR4=$(cat ${CD} | grep -i color3| tail -c 8)

FG=$COLOR2

# my colors
reset="%{F-}"
bg_reset="%{B-}"

# Fonts
FONT1="Font Awesome:size=11"
FONT2="Roboto Medium:size=11"


# Panel 
PW=1366
PH=24
PX=0
PY=0

#functions
ram(){
    echo -n " ";
    ram=$(free | grep Mem | awk '{print $3/$2 * 100.0}'|cut -d . -f 1)
    for i in $(seq 25); do
	if [ $i -gt $((ram/4)) ];then
	    echo  -n "%{F$COLOR1}";
	fi
	echo -n "";
	
    done;     
    echo -n "${reset}"
}

proco(){
    cpu=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}'|cut -d . -f1)
    echo -n " "
    for i in $(seq 25); do
	if [ $i -gt $((cpu/4)) ];then
	    echo  -n "%{F$COLOR1}";
	fi
	echo -n "";
	
    done;     
    echo -n "${reset}"
    
}

onoff(){
    echo -n "%{B$COLOR4}%{F$COLOR3}"
    echo -n "%{A:$POW:}"
    echo -n "    "
    echo -n "%{A}"
    echo -n "${reset}${bg_reset}"
    }

thedate(){
    echo -n " ${reset}"
    echo -n "$(date '+%a %d %B')   "
    echo -n "%{B$COLOR1} %{F$COLOR2} $(date '+ %H:%M')  "
    echo -n "${reset}${bg_reset}"
    }

mainip(){
    SSID=$(iwgetid |cut -d '"' -f 2)
    ETHER=$(ifconfig eno1| grep inet|cut -d ' ' -f 10|head -n 1)
    
    if [ "$SSID" == "" ]; then
	echo -n "  %{F$COLOR1}  ${reset}  "
    else
	ADDR=$(ifconfig wlo1| grep inet|cut -d ' ' -f 10|head -n 1)
	echo -n " ${SSID} - ${ADDR}  "
    fi;

    if [ "$ETHER" == "" ]; then
	echo -n "  %{F$COLOR1}  ${reset}  "
    else
	echo -n "  - ${ETHER}  "
    fi
	     
}
volume(){
    volume=$(amixer get Master |grep % |awk '{print $5}'|sed -e 's/\[//' -e 's/\]//'|head -n 1)
    muted=$(amixer get Master |grep '\[' |awk '{print $6}'|head -n 1)

    if [ $muted = "[on]" ]; then
	echo -ne "%{B$COLOR1}   ${volume}  ${bg_reset}"
    else
	echo -ne "%{B$COLOR1}%{F$BG}     ${volume}  ${reset}${bg_reset}"
    fi
}

battery(){
    chrg=$(upower -i $(upower -e | grep BAT) | grep --color=never -E percentage|xargs|cut -d' ' -f2|sed s/%//)
    isPlugged=$(acpi -a | cut -d' ' -f3 | cut -d- -f1)

    echo -ne "%{B$COLOR1}"
    full="%{F$COLOR2}  %{F$COLOR3} ${chrg}%  $bg_reset"
    half="%{F$COLOR2}  %{F$COLOR3} ${chrg}%  $bg_reset"
    quarter="%{F$COLOR2}  %{F$COLOR3} ${chrg}%  $bg_reset"
    threequarter="%{F$COLOR2}  %{F$COLOR3} ${chrg}%  $bg_reset"
    empty="${red} ${chrg}%${reset}  $bg_reset"
    plugged="%{F$COLOR2}  %{F$COLOR3} ${chrg}%  $bg_reset"

    if [ "$isPlugged" == "on" ]; then
	echo -ne $plugged
    elif [ $chrg -gt 95 ];then
	echo -ne $full
    elif [ $chrg -gt 75 ];then
	echo -ne $threequarter
    elif [ $chrg -gt 50 ]; then
	echo -ne $half
    elif [ $chrg -gt 25 ]; then
	echo -ne $quarter
    else
	echo -ne $empty
    fi;
    echo -ne "${bg_reset}"
}

#Actions
VOLT="amixer set Master toggle"
VOLU="amixer set Master 2%+"
VOLD="amixer set Master 2%-"
TMUS="mpc toggle"
NMUS="mpc next"
POW="~/.config/i3/pop_shutdown.sh"

# Functions
while :; do
    echo "$(onoff)$(battery)$(volume)  $(ram) $(proco) %{r}$(mainip) $(thedate)"
    sleep .1
done | lemonbar -g ${PW}x${PH}+${PX}+${PY}  -B "$BG" -F "$FG" -f "$FONT1" -f "$FONT2" -p  | \
    while :; do read line; eval $line; done &
