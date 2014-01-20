#curl equivalent
(New-Object System.Net.WebClient).DownloadString("http://www.google.com")

#wget equivalent
(New-Object System.Net.WebClient).DownloadFile(
"http://www.google.com","c:\google.html")

#(Windows Vista or Windows 7)
#Install telnet client or Server
start /w pkgmgr /iu:"TelnetClient"
start /w pkgmgr /iu:"TelnetServer"

#Remove telnet client or Server
start /w pkgmgr /uu:"TelnetClient"
start /w pkgmgr /uu:"TelnetServer"

#Start powershell script
#start HolaMundo.ps1 --> WRONG!!!
#powershell ./Test.ps1 --> WRONG!!!
powershell "powershell $(cat Test.ps1)"
powershell "$(gc Test.ps1)"
powershell -ExecutionPolicy Bypass ./Test.ps1
