#!/bin/bash


dir="/Users/Shared"
dir2="/tmp/"
senha="senha" 

echo "Informe o Host do Equipamento"
read juno

scp -rqC4 "$dir/Office.pkg" "hostname@host.local:$dir2"
ssh hostname@host.local "echo $senha | sudo -S chmod -R 777 /tmp/Office.pkg > /dev/null 2>&1"
ssh hostname@host.local "echo $senha | sudo -S installer -pkg /tmp/Office.pkg -target / > /dev/null 2>&1"
# ssh hostname@host.local "echo $senha | sudo -S rm -rf /Applications/Microsoft\ Word.app/"
# ssh hostname@host.local "echo $senha | sudo -S rm -rf /Applications/Microsoft\ OneNote.app/"
# ssh hostname@host.local "echo $senha | sudo -S rm -rf /Applications/Microsoft\ Outlook.app/"
# ssh hostname@host.local "echo $senha | sudo -S rm -rf /Applications/Microsoft\ PowerPoint.app/"
# ssh hostname@host.local "echo $senha | sudo -S rm -rf /Applications/OneDrive.app/"
echo "Instalação Concluída."
