
# Get process io
PID=$(pgrep java)
cat /proc/$PID/io

# Get top process using io
grep '^rchar:' /proc/{1,2,3,4,5,6,7,8,9}*/io 2>/dev/null|\
sort -k2 -rn|\
head|\
cut -d/ -f3|\
xargs -t -L1 -I{} cat -v /proc/{}/cmdline 2>&1|\
sed 's|cat -v /proc/\([0-9]*\)/cmdline |\n\1|g; s|\^@| |g; s|   *| |g; $a\'|\
sed /^$/d


#intercept stdout/stderr of another process
strace -ff -e trace=write -e write=1,2 -p SOME_PID
