#mysql bin log events per minute
mysqlbinlog <logfiles> | grep exec | grep end_log_pos | cut -d' ' -f2- | cut -d: -f-2 | uniq -c

#mysqlbinlog headers sorted by event time
mysqlbinlog <logfiles> | grep exec | grep end_log_pos | grep -v exec_time=0 | sed 's/^\(.*exec_time=\([0-9]\+\).*\)/\2 - \1 /' | sort -n


