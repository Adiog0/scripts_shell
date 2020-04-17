cat ips.txt | while read -r host 
do
    ssh -o ConnectTimeout=1 -n hostname@$host 'echo senha | sudo -S /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -on -users hostname -privs -all -restart -agent -menu'
    ssh -o ConnectTimeout=1 -n hostname@$host 'echo senha | sudo -S /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -allowAccessFor -allUsers -privs -all'
    #ssh -o ConnectTimeout=1 -n hostname@$host 'echo senha | sudo -S mdfind PhraseExpress.app'

    
done 


