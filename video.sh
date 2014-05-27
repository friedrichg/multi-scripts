xrandr --newmode "1680x1050_60.00"  146.25  1680 1784 1960 2240  1050 1053 1059 1089 -hsync +vsync
xrandr --addmode DP2 1680x1050_60.00
xrandr --output DP2 --mode 1680x1050_60.00

# cat /etc/X11/xorg.conf.d/40-monitor.conf
#Section "Monitor"
#  Identifier  "DP2"
#  Modeline    "1680x1050_60.00"  146.25  1680 1784 1960 2240  1050 1053 1059 1089 -hsync +vsync
#  Option      "PreferredMode" "1680x1050_60.00"
#EndSection
