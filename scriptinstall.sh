#!/bin/bash
# Install-Apps.sh
# Script responsável por fazer a verificação de Apps na pasta /Users/Shared/Catalogo-App/
# E realizar a instalação automática de 1 ou mais apps, criando um atalho na /Applications do computador destino.
# versão 1.0.1
# autor(es): Adriano Diogo, Raphael, Dieferson (Juno)

#Diretórios Padrões de Apps e Senha de Admin
dir="/Users/Shared"
dir2="/Users/Shared/.apps/"
senha="senha"
HostName=""
t="\$2"
# Funcão responsável por fazer a instalação de apps
function Instalar()
{
	var1=`ssh HostName@$HostName "if [ -d '/Users/Shared/.apps/$nomeapp' ] ; then echo 1; else echo 0;fi;"`
	if [ $var1 -eq 1 ]
	then
		echo
		echo -e "\033[03;37m===============================================\033[00m"
		echo -e "     \033[00;01;32m$nomeapp\033[00m \033[01;36mJá instalado em\033[00m \033[00;01;32m$HostName\033[00m"
		echo -e "\033[03;37m===============================================\033[00m"
		echo -e "\033[01;36mO que desejar fazer com\033[00m \033[00;01;32m$nomeapp\033[00m \033[01;36m? 1 Reinstalar, 2 Desinstalar, 3 menu, 4 ignorar.\033[00m"
		read opcdesinstalar
		case $opcdesinstalar in
			1)
					ssh HostName@$HostName.local "echo $senha | sudo -S unlink '/Applications/$nomeapp' > /dev/null 2>&1"
					sleep 1
					ssh HostName@$HostName.local "echo $senha | sudo -S rm -rf '/Users/Shared/.apps/$nomeapp' > /dev/null 2>&1"
					#ssh HostName@$HostName.local "echo $senha | sudo -S rm -rf '/Applications/$nomeapp' > /dev/null 2>&1"

					echo -e "\033[03;37m===============================================\033[00m"
					echo -e "     \033[01;36mReinstalando\033[00m \033[00;01;32m$nomeapp\033[00m \033[01;36mem\033[00m \033[00;01;32m$HostName\033[00m"
					echo -e "\033[03;37m===============================================\033[00m"
					ssh HostName@$HostName.local "echo $senha | sudo -S mkdir /Users/Shared/.apps > /dev/null 2>&1"
					ssh HostName@$HostName.local "echo $senha | sudo -S chmod -R 777 /Users/Shared/.apps/ > /dev/null 2>&1"
					scp -rqC4 "$dir/Catalogo-App/$nomeapp" "HostName@$HostName.local:$dir2"
					ssh HostName@$HostName.local "echo $senha | sudo -S chmod -R 777 /Users/Shared/.apps/ > /dev/null 2>&1"
					ssh HostName@$HostName.local "echo $senha | sudo -S rm -rf '/Applications/$nomeapp' > /dev/null 2>&1"
					ssh HostName@$HostName.local "echo $senha | sudo -S ln -s '/Users/Shared/.apps/$nomeapp' '/Applications/$nomeapp' > /dev/null 2>&1"
					ssh HostName@$HostName.local "echo $senha | sudo -S chmod -R 777 /Users/Shared/.apps/ > /dev/null 2>&1"
					var2=`ssh HostName@$HostName.local "echo $senha | sudo -S ps aux | grep -i '$nomeapp' | grep -v grep | awk -F' ' '{print $t}' | wc -l"`
					echo
					echo -e "\033[03;37m==================================================\033[00m"
					echo -e "    \033[00;01;32m$nomeapp\033[00m \033[01;36mReinstalado\033[00m"
					echo -e "\033[03;37m==================================================\033[00m"

			;;
			2)

					ssh HostName@$HostName.local "echo $senha | sudo -S unlink '/Applications/$nomeapp' > /dev/null 2>&1"
					sleep 1
					ssh HostName@$HostName.local "echo $senha | sudo -S rm -rf '/Users/Shared/.apps/$nomeapp' > /dev/null 2>&1"

					echo -e "\033[03;37m==================================================\033[00m"
					echo -e "     \033[00;01;32m$nomeapp\033[00m \033[01;36mDesinstalado em\033[00m \033[00;01;32m$HostName\033[00m"
					echo -e "\033[03;37m==================================================\033[00m"

			;;
			3) menu
			;;
			4) echo "$nomeapp ignorado"
			;;
			*) echo "Opcao Inválida"
			;;
		esac

		ssh HostName@$HostName.local "echo $senha | sudo -S chmod -R 777 /Users/Shared/.apps/ > /dev/null 2>&1"
		#ssh HostName@$HostName.local "echo $senha | sudo -S ln -s '/Users/Shared/.apps/$nomeapp' '/Applications/$nomeapp' > /dev/null 2>&1"
		sleep 1

	else
		echo
		echo -e "\033[03;37m===============================================\033[00m"
		echo -e "     \033[01;36mInstalando\033[00m \033[00;01;32m$nomeapp\033[00m \033[01;36mem\033[00m \033[00;01;32m$HostName\033[00m"
		echo -e "\033[03;37m===============================================\033[00m"
		ssh HostName@$HostName "echo $senha | sudo -S mkdir /Users/Shared/.apps > /dev/null 2>&1"
		ssh HostName@$HostName "echo $senha | sudo -S chmod -R 777 /Users/Shared/.apps/ > /dev/null 2>&1"
		scp -rqC4 "$dir/Catalogo-App/$nomeapp" "HostName@$HostName:$dir2"
		ssh HostName@$HostName "echo $senha | sudo -S chmod -R 777 /Users/Shared/.apps/ > /dev/null 2>&1"
		ssh HostName@$HostName "echo $senha | sudo -S rm -rf '/Applications/$nomeapp' > /dev/null 2>&1"
		ssh HostName@$HostName "echo $senha | sudo -S ln -s '/Users/Shared/.apps/$nomeapp' '/Applications/$nomeapp' > /dev/null 2>&1"
		ssh HostName@$HostName "echo $senha | sudo -S chmod -R 777 /Users/Shared/.apps/ > /dev/null 2>&1"
		var2=`ssh HostName@$HostName "echo $senha | sudo -S ps aux | grep -i '$nomeapp' | grep -v grep | awk -F' ' '{print $t}' | wc -l"`
		sleep 1

		#ssh HostName@$HostName.local "echo $senha | sudo -S ps aux | grep -i '$nomeapp' | grep -v grep | awk -F' ' '{print $t}' | sudo xargs kill -9 > /dev/null 2>&1"

		if [ $var2 -ge 1 ]
		then
			ssh HostName@$HostName "echo $senha | sudo -S ps aux | grep -i '$nomeapp' | grep -v grep | awk -F' ' '{print $t}' | sudo xargs kill -9 > /dev/null 2>&1"
			sleep 1
			# ssh HostName@$HostName.local " open -F '/Users/Shared/.apps/$nomeapp'"

		fi


		echo ""
		echo -e "\033[03;37m===============================================\033[00m"
		echo -e "     \033[01;36mInstalação Concluída!\033[00m"
		echo -e "\033[03;37m===============================================\033[00m"
	fi
}

#Array responsável por validar novos apps e armazenar.
# VARIAVEL=`ls -l /Users/Shared/Catalogo-App/ | grep app | awk '{print $9" "$10" "$11" "$12" "$13" "$14}'`
# echo $VARIAVEL
cd /Users/Shared/Catalogo-App/
declare -a lista; count=1;
for f in *.app; do
	lista[$count]=$f
	count=$((count+1))
done
# for i in $VARIAVEL; do lista[$count]=$i; count=$((count+1)); done

# Menu de Opções
opcao="validador"

menu ()
{
	while true $x != "validador"
	do
		# Cria a lista de Menu
		echo
		echo -e "\033[03;37m===============================================\033[00m"
		echo -e "     \033[01;36mCatálogo de Aplicativos HostName\033[00m"
		echo -e "\033[03;37m===============================================\033[00m"
		echo
		for i in $(seq 1 ${#lista[@]});
				do
				echo -e "\033[01;36m$i\033[00m - \033[03;37m${lista[$i]} \033[00m"
				number=$i
			done

			todos=$((number + 1))
			base=$(($todos + 1))
			dev=$(($base + 1))
			fin=$(($dev + 1))
			sair=$(($fin + 1))

			#novohost=$((number + 3))
			echo -e "\033[01;36m$todos\033[00m - \033[00;01;32mINSTALAR TODOS\033[00m\033[01;31m(CUIDADO!!!)\033[00m "
			echo -e "\033[01;36m$base\033[00m - \033[01;36mPERFIL PADRÃO\033[00m"
			echo -e "\033[01;36m$dev\033[00m - \033[01;35mPERFIL DESENVOLVEDOR\033[00m"
			echo -e "\033[01;36m$fin\033[00m - \033[01;1;33mPERFIL FINANCEIRO\033[00m"
			echo -e "\033[01;36m$sair\033[00m - \033[01;34mSAIR\033[00m"



			echo
			echo -e "\033[03;37m==================================================\033[00m"
			echo -e "     \033[01;36mSelecione uma opção de 1 a $sair\033[00m"
			echo -e "\033[03;37m==================================================\033[00m"
			read opc


			if [ "$opc" = "" ] || [ "$opc" -gt "$sair" ]
			then

				vali=$((i - i + 1 ))

				echo
				echo -e "\033[03;37m===============================================\033[00m"
				echo -e "     \033[01;36mOpcão Inválida\033[00m, Escolha um número entre $vali e $sair!"
				echo -e "\033[03;37m===============================================\033[00m"
				echo
				else

			if [ "$opc" == "$sair" ]
			then
				exit

			else
				if [ 1 -eq 1 ]
				then

				sairhost=0
				 while [ $sairhost -eq 0 ]
				 do
					HostNameant=$HostName
					echo -e "\033[03;37m===============================================\033[00m"
					#echo -e "\033[01;33Informe o Host do PC:\033[00m (Host Atual: $HostName)  "
					echo -e "     \033[01;36mInforme o Host do PC:\033[00m \033[01;36m(Host Atual:\033[00m \033[00;01;32m$HostName\033[00m \033[01;36m)\033[00m"
					echo -e "\033[03;37m===============================================\033[00m"
					read HostName
					if [ "$HostName" = "" ]
					then
						HostName=$HostNameant

					fi
					if [[ $HostName = *"HostName"* ]]
					then
						HostName="$HostName.local"
					fi

					ping -c 1 $HostName > /dev/null 2>&1

					if [ $? -eq 0 ]
					then

						sairhost=1

					else

					echo
					echo -e "\033[03;37m===============================================\033[00m"
					echo -e "     \033[01;31mHOST\033[00m $HostName \033[01;31mInválido!!\033[00m"
					echo -e "\033[03;37m===============================================\033[00m"
					fi
				 done
				fi

				# Instalar apenas 1 App
				if [ $opc -le $number ]
				then
					nomeapp=${lista[$opc]}
					Instalar $nomeapp $HostName

				else
					# Instalar todos os Apps Listados
					if [ "$opc" == "$todos" ]
					then
						for i in "${lista[@]}"
						do
							nomeapp=${lista[$i]}
							Instalar $nomeapp $HostName
						done

					elif [ "$opc" == "$dev" ]
					then
						deves=("Google Chrome.app" "Postman.app" "Sequel Pro.app" "Slack.app" "Spotify.app" "Visual Studio Code.app" "WhatsApp.app" "IntelliJ IDEA CE.app" "Numbers.app" "Keynote.app" "Pages.app")
						#deves=("Google Chrome.app")

						echo ${deves[@]}

						for i in "${deves[@]}"
						do
							nomeapp=${deves[$i]}
							Instalar $nomeapp $HostName
						done

					elif [ "$opc" == "$base" ]
					then
						basic_array=("Slack.app" "Spotify.app" "WhatsApp.app" "Google Chrome.app" "VLC.app" "Keynote.app" "Numbers.app" "Pages.app")
						echo ${basic_array[@]}

						for i in "${basic_array[@]}"
						do
							nomeapp=$i
							Instalar $nomeapp $HostName
						done

					elif [ "$opc" == "$fin" ]
					then
						basic_array=("Google Chrome.app" "Linphone.app" "Slack.app" "Spotify.app" "WhatsApp.app" "Bradesco.app" "Itau.app")
						echo ${basic_array[@]}

						for i in "${basic_array[@]}"
						do
							nomeapp=${basic_array[$i]}
							Instalar $nomeapp $HostName
						done
					else
						echo "Opção Inválida!"
					fi
				fi
			fi

		fi
	done
}

menu
