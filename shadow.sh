#!/bin/bash

# Creates a password string for /etc/shadow. (tested on RHEL6.2 SHA512)
python -c "import crypt; password=raw_input('Password:'); salt=raw_input('Salt:'); print crypt.crypt(password,'\$6\$'+salt+'\$')"

