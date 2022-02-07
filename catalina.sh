    #!/bin/bash

    dir="/Users/Shared"
    dir2="/Applications/"
    senha="senha" 

    cat ips.txt | while read host
    do
    rsync -avzh --timeout=2 /Applications/Install\ macOS\ Catalina.app Hostname@$host:/Applications/
    #scp -rqC4 -o ConnectTimeout=2  "$dir/Catalogo-App/Install macOS Catalina.app" "Hostname@$host:$dir2"
    #ssh -n -o ConnectTimeout=2 Hostname@$host "echo $senha | sudo -S /Applications/Install\ macOS\ Catalina.app/Contents/Resources/startosinstall --agreetolicense > /dev/null 2>&1"
    #ssh -n -o ConnectTimeout=2 Hostname@$host "echo $senha | sudo -S /Applications/Install\ macOS\ Catalina.app/Contents/Resources/startosinstall"

    done
