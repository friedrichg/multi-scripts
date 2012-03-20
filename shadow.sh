#!/bin/bash

# Blowfish ($2a$) or Extended DES (9 char salt) don't seem work (on RHEL 6.2)
# password strings taken from here http://php.net/manual/es/function.crypt.php
# or "man crypt"

# Creates a password string for /etc/shadow. (tested on RHEL6.2 SHA512)
python -c "import crypt,getpass; password=getpass.getpass(); salt=getpass.getpass('Salt:'); print crypt.crypt(password,'\$6\$'+salt+'\$')"

# Creates a password string for /etc/shadow. (tested on RHEL6.2 SHA256)
python -c "import crypt,getpass; password=getpass.getpass(); salt=getpass.getpass('Salt:'); print crypt.crypt(password,'\$5\$'+salt+'\$')"

# Creates a password string for /etc/shadow. (tested on RHEL6.2 md5)
python -c "import crypt,getpass; password=getpass.getpass(); salt=getpass.getpass('Salt:'); print crypt.crypt(password,'\$1\$'+salt+'\$')"

# Creates a password string for /etc/shadow (md5)
openssl passwd -1 -salt 'somesalt'

# Creates a password string for /etc/shadow. (tested on RHEL6.2 STD DES)
python -c "import crypt,getpass; password=getpass.getpass(); salt=getpass.getpass('2 char Salt:'); print crypt.crypt(password,salt[:2])"


