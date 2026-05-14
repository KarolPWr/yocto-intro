cat << 'EOF' > blink_green.sh
#!/bin/sh

echo "Starting Green LED blinker on PH5..."
echo "Press [CTRL+C] to stop."

gpioset -t 500ms PH5=1
EOF