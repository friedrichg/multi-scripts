function tty_attach() {
  pid=$(ps -ef| grep $1|grep bash|awk {print\$2})
  gdb -p $pid << HEREDOC
p dup2(open("$(tty)", 1), 1)
detach
quit
HEREDOC
}

function tty_deattach() {
  tty=$(tty)
  pid=$(ps -ef| grep $1|grep bash|awk {print\$2})
  oldfds=$(lsof -nPp $pid|grep $tty|awk {print\$4}|grep -o '[0-9]*' 2>/dev/null)
  gdb -p $pid << HEREDOC
$(echo -n "$oldfds"|sed 's|^.*$|p close(\0)|g' )
p open("/dev/$1", 1)
detach
quit
HEREDOC
}
#Show stdin and stdout
strace -e write=1,2 -e trace=write -p 22201

function move_log() {
  pid="$1"
  old="$1"
  new="$2"
  oldfd=$(lsof -nPp $pid|grep "$old"|awk {print\$4}|grep -o '[0-9]*' 2>/dev/null)
  gdb -p $pid << HEREDOC
  open('$new',1)
  $(lsof -nPp $pid|grep "$new"|awk {print\$4}|grep -o '[0-9]*' 2>/dev/null|sed 's|^.*$|p dup2($oldfd,\0)}')
  close($oldfd)
detach
HEREDOC
}

