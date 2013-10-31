#remove all kernels
#taken from here http://markmcb.com/2013/02/04/cleanup-unused-linux-kernels-in-ubuntu/
# tested with ubuntu 12.10
dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge
