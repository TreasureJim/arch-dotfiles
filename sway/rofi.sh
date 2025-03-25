monitor=$(swaymsg -t get\_outputs | jq -c '.[] | select(.focused) | select(.id)' | jq -c '.name')
rofi -show drun -monitor $monitor
