    #ssh admin@10.20.0.254 ':foreach i in=[/ip dhcp-server lease find where (host-name~"Mini" or host-name~"Air" or host-name~"JUNO") and server="server-corporativa"] do={:put ([/ip dhcp-server lease get $i address].":".[/ip dhcp-server lease get $i host-name])}' > tmp.txt
    ssh adriano@10.20.0.254 ':foreach i in=[/ip dhcp-server lease find where (host-name~"Mini" or host-name~"Air" or host-name~"JUNO") and server="server-corporativa"] do={:put ([/ip dhcp-server lease get $i address])}' > tmp.txt

    tr -d "\r" < tmp.txt > ips.txt
    # rm -f tmp.txt
