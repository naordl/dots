#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bars
polybar top -r &

external_monitor=$(xrandr --query | grep -w 'DP1')
if [[ $external_monitor = *connected* ]]; then
	polybar top_external -r &
fi
