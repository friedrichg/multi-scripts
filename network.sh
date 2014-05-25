#check if you need fragmentation
pktsize=1516;for i in $( seq $pktsize -8 1450 ) ; do ping -M do -s $i -c 1 slashdot.org; done
