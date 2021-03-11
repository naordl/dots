# Display settings
#xrandr --output eDP1 --mode 1366x768 --pos 0x312 --output DP1 --primary --mode 1920x1080 --pos 1366x0

# DWM loop
while true; do
	dwm >/dev/null 2>&1
done

# Start dwm
exec dwm
