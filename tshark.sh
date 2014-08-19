
# show http requests
tshark -o "tcp.desegment_tcp_streams:TRUE" -i eth0 -R "http.request" -T fields -e ip.src -e http.request.method -e http.request.uri -e http.request.version -e http.user_agent

# show http response 
tshark -o "tcp.desegment_tcp_streams:TRUE" -i eth0 -R "http.response" -T fields -e ip.src -e http.response.code 

# show http requests and responses
tshark -o "tcp.desegment_tcp_streams:TRUE" -i eth0 -R "http.request or http.response" -T fields -e ip.src -e ip.dst -e http.request.method -e http.request.uri -e http.request.version -e http.user_agent -e http.response.code -e http.location

# show https
tshark -p -i1 -o "ssl.desegment_ssl_records: TRUE" -o "ssl.keys_list:$ip,443,http,$key3" -o "ssl.debug_file:lala" -n -R 'tcp.port eq 443' -T fields -e ip.host -e tcp.port -e http.request.full_uri -e http.request.method -e http.response.code -e http.response.phrase -e http.content_length -e data -e text -E separator=\; 

# remote session from windows
"c:\Program Files\PuTTY\plink.exe" -ssh root@remotehost tcpdump -npi eth0 -s0 -w - port 80 | "c:\Program Files\Wireshark\Wireshark.exe" -k -i -
