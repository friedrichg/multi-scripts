#!/bin/bash

# create base64 encoded script
base64script() {
        base64opts=-di
        [[ "$(uname)" == "Darwin" ]] && base64opts=-D
	a="$(tail -n+1 $1|base64)" && echo $'#!/bin/bash\na="$(echo "'"$a"'"|base64 '"$base64opts"$')";eval "$a"' > encoded_$1.sh
}

[[ $1 && $2 ]] && $1 $2

# Example ./encoding base64script shadow.sh
