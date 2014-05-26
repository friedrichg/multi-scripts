#Bring cpu online
echo 1 > /sys/devices/system/cpu/cpu4/online

#autodetect scsi vmware
echo - - - > /sys/class/scsi_host/host0/scan
