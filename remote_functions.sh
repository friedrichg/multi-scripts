# First server
#publish function in webserver
cat << END > /var/html/functions.sh
function show_log() {
 lsof -nPp $(pgrep "$1" "$2"|tr '\n' ',')| grep '[0-9]w '|grep REG|egrep -v '\.war$|\.jar$|\.tmp$|\.pid$|\.res$'|awk '{ print $9 }'|sort|uniq
}
END

# Second server
# recover function 
eval "$(curl -s http://server/functions.sh)"

# use function
show_log -u jboss
