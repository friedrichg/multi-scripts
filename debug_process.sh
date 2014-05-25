#Slow down IO heavy process
slow () { [ -n $1 ] && while kill -STOP $1; do sleep 1; kill -CONT $1; sleep 1; done }

#intercept stdout/stderr of another process
strace -ff -e trace=write -e write=1,2 -p SOME_PID
