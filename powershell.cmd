#curl equivalent
(New-Object System.Net.WebClient).DownloadString("http://blog.commandlinekungfu.com")

#wget equivalent
(New-Object System.Net.WebClient).DownloadFile(
"http://blog.commandlinekungfu.com","c:\downloadedfile.html")

#(Windows Vista or Windows 7)
#Install telnet client or Server
start /w pkgmgr /iu:"TelnetClient"
start /w pkgmgr /iu:"TelnetServer"

#Remove telnet client or Server
start /w pkgmgr /uu:"TelnetClient"
start /w pkgmgr /uu:"TelnetServer"
