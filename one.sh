#!/bin/bash
python -c "import crypt; password=raw_input('Password:'); salt=raw_input('Salt:'); print crypt.crypt(password,'\$6\$'+salt+'\$')"

