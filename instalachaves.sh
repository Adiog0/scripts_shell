#!/usr/bin/env bash
​
#./crialistaips.sh
​
senha="senha"
​
#=================
for host in $(cat ips.txt); do
    if [ -f "foi/$host.txt" ]; then
        echo "$host já foi"
    else
        echo "Adicionando chave em $host"
        /usr/bin/expect << EOL
        spawn ssh-copy-id -o ConnectTimeout=3 hostname@host
        expect {
            "continue"   {
                send "yes\n"
                exp_continue
            }
            "assword" {
                send "$senha\n"
                exp_continue
            }
            "they already exist" {
                exec touch "foi/$host.txt"
                exp_continue
            }
            "Now try logging into the" {
                exec touch "foi/$host.txt"
                exp_continue
            }
        }
EOL
        
    fi
done
