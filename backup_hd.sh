# makebackup
dd if=/dev/sda of=sda.mbr bs=446 count=1 
sfdisk -d /dev/sda
for x in 1 2 3 4; do
dd if=/dev/sda$x|gzip > sda$x.bin.gz
done

# restorebackup
cat dump|sfdisk /dev/sda
dd if=sda.mbr of=/dev/sda bs=446 count=1
for x in 1 2 3 4; do
gunzip -c sda$x.bin.gz|dd of=/dev/sda$1
done

