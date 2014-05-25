#Slow down IO heavy process
slow () { [ -n $1 ] && while kill -STOP $1; do sleep 1; kill -CONT $1; sleep 1; done }
