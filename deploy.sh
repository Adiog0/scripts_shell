  #!/bin/bash

  echo "Configurando Hostname. "
  echo "O nome atual é `hostname`"
  echo "Informe o Nome da Máquina. "
  read nomeHost

  if [ "$nomeHost" != "" ]; then
    sudo scutil --set HostName ${nomeHost}
    sudo scutil --set LocalHostName ${nomeHost}
    sudo scutil --set ComputerName ${nomeHost}
    dscacheutil -flushcache
  fi

  echo " "
  echo -n "Conectado à rede "
  rede=`/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | egrep "\ SSID" | cut -d :  -f 2 | cut -d " " -f 2`
  echo $rede

  if [ "$rede" != "Corporativa" ]; then
    echo ""
    echo "Alterando rede para Corporativa. "
    sudo networksetup -setairportnetwork en0 "Corporativa" senha
    sudo networksetup -setairportnetwork en1 "Corporativa" senha
    echo ""
    echo -n "Agora conectado à rede "
    rede=`/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | egrep "\ SSID" | cut -d :  -f 2 | cut -d " " -f 2`
    echo $rede
  fi

  echo ""
  echo "Removendo redes desnecessárias"
  sudo networksetup -removepreferredwirelessnetwork en0 JUNO > /dev/null
  sudo networksetup -removepreferredwirelessnetwork en1 JUNO > /dev/null
  sudo networksetup -removepreferredwirelessnetwork en2 JUNO > /dev/null
  sudo networksetup -removepreferredwirelessnetwork en0 "RedePublica" > /dev/null
  sudo networksetup -removepreferredwirelessnetwork en1 "RedePublica" > /dev/null
  sudo networksetup -removepreferredwirelessnetwork en2 "RedePublica" > /dev/null

  # Habilita acesso remoto
  echo ""
  echo "Habilitando acesso remoto. "
  sudo systemsetup -setremotelogin on

  echo ""
  echo "Habilitando gerenciamento remoto. "
  sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -on -users HostName -privs -all -restart -agent -menu
  sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -allowAccessFor -allUsers -privs -all

  echo ""
  echo "Removendo admins indevidos. "
  admins=$(dscl . -read /Groups/admin GroupMembership | tr " " "\n" | grep -v "HostName" | grep -v GroupMembership | grep -v root)
  for admin in $admins
  do
    sudo dscl . -delete /Groups/admin GroupMembership $admin
  done

  # Habilita o filevault
  echo " "
  echo "Ativando o FileVault"
  echo " "
  sudo fdesetup enable
  CONT=`fdesetup status | grep -c Percent`
  while [ "$CONT" -ne "0" ]; do
      perc=`fdesetup status | grep Percent | cut -d = -f 2 | cut -d " " -f 2`
      echo -en "\r$perc% concluido"
      sleep 5s
      CONT=`fdesetup status | grep -c Percent`
  done

  echo "FileVault ativado"

  # "Ingressa" no domínio
  echo ""
  echo "Configurando servidor de autenticacao"
  sudo dsconfigldap -N -a server.ard

  echo " "
  echo -e "\x1b[0;32mFeito! \x1b[0m"
  echo -e "Agora acesse \x1b[0;33mhttps://server.ard\x1b[0m, autentique com o login do usuario desta máquina em \"My Devices\" e clique em \x1b[0;33m\"Enroll\"\x1b[0m."
