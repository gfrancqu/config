#!/bin/bash
# Color directory
CD="$HOME/.Xresources"

# Fetch the Colors
BG=$(cat ${CD} | grep -i background | tail -c 8)
FG="#ffffff"

BLACK=$(cat ${CD} | grep -i color8 | tail -c 8)
RED=$(cat ${CD} | grep -i color9 | tail -c 8)
GREEN=$(cat ${CD} | grep -i color10 | tail -c 8)
YELLOW=$(cat ${CD} | grep -i color11 | tail -c 8)
BLUE=$(cat ${CD} | grep -i color12 | tail -c 8)
MAGENTA=$(cat ${CD} | grep -i color13 | tail -c 8)
CYAN=$(cat ${CD} | grep -i color14 | tail -c 8)
WHITE=$(cat ${CD} | grep -i color15 | tail -c 8)

# Fonts
FONT1="Font Awesome:size=24"
FONT2="Roboto Medium:size=10"

# Panel 
PW=300
PH=48
PX=533
PY=372

echo "%{c}  %{A:s:}%{A}  %{A:r:}%{A}  %{A:l:}%{A}  %{r}%{A:b:}%{A}  " | lemonbar -g ${PW}x${PH}+${PX}+${PY} -f "$FONT1" -f "$FONT2" -B "$BG" -F "$FG" -dp | \
    while :; do
        read line
        case $line in 
            'b')
                p=$(pgrep -n lemonbar)
                kill $p 
                exit 
                ;;
            's')
                /usr/bin/shutdown now
                exit                
                ;;
            'l')
                /usr/bin/i3lock
		p=$(pgrep -n lemonbar)
                kill $p 
                exit
                ;;
            'r')
                /usr/bin/shutdown -r now
                exit
                ;;
        esac
    done
