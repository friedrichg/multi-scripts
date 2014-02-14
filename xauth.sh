ssh -X server #as normal user
xterm #for testing if export display as normal user works
echo $DISPLAY #write it down
xauth #enters the shell of xauth
list # find the line with the display number from step 3 for me it was “wpsvm054/unix:12 MIT-MAGIC-COOKIE-1 071df2e12cfff0ed75fd0af5869665f7″ remember the first part of it
quit #to leave the shell
xauth extract filename system/unix:12 # the line from step 4.1
sudo su – # to become root
xauth merge filename # filename from step 5
export DISPLAY=:nummer.0 #Displaynumber from step 3 resp. 4.1
xterm #for testing
# taken from http://ansi.23-5.eu/2011/10/21/how-to-export-display-via-ssh-after-sudo-su/
