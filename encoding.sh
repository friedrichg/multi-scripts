#!/bin/bash

# create base64 encoded script
base64script() {
        [[ ! -f "$1" ]] && return
        base64opts=-di;[[ "$(uname)" == "Darwin" ]] && base64opts=-D; new_name="$(dirname $1)/encoded_$(basename $1)";
        a="$(tail -n+1 $1|base64)" 
        echo $'#!/bin/bash\na="$(echo "'"$a"'"|base64 '"$base64opts"$')";eval "$a"' > $new_name
        chmod +x $new_name
}

# ciphers and encodes script
bfscript() {
        [[ ! -f "$1" ]] && return
        base64opts=-di;[[ "$(uname)" == "Darwin" ]] && base64opts=-D; new_name="$(dirname $1)/bf_$(basename $1)";
        a="$(tail -n+1 $1|openssl bf|base64)" 
        echo $'#!/bin/bash\na="$(echo "'"$a"'"|base64 '"$base64opts"$'|openssl bf -d)";eval "$a"' > $new_name
        chmod +x $new_name
}

alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'


if [[ "$1" && "$2" ]]; then 
   "$1" "$2"
else
   echo "Example $0 base64script shadow.sh"
   echo "Example $0 bfscript shadow.sh"
fi
