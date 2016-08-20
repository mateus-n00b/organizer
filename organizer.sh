#!/bin/bash
# organizer.sh e um programa que organiza os arquivos presentes em um diretorio
# de acordo com sua extensao movendo-os para pastas adequadas.
#
# Mateus, Agosto 2016
# 
# Versao 1.0 
# 
# Licenca GPL
# TODO: Determinar as extensoes de forma automatica
# 
# Versao 1.1
#
# Mateus, Agosto 2016
#
# Determina as extensoes de forma automatica
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#
clear
echo -e "\n	    #++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#\n
					Welcome to the Organizer\n\
		 			by Mateus-N00B\n
	    #++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#\n"
ext=""
CONT=0

read -p "Diretorio a ser organizado: " or_dir
[ -z "$or_dir" -o ! -d "$or_dir" ] && echo "[!] Invalid path!" && exit 1

#echo ${ext[@]}
cd "$or_dir"
ls | grep -Eo '\..*' | sed 's/\.//g' > /tmp/out

while read row
do	
	if ! grep "$row" <<< "${ext[@]}" &> /dev/null
	then	
		ext[$cont]="$row"
		let cont++
	fi	
done < /tmp/out

for x in *
do
  for i in ${ext[@]}
  do
  	if grep "$i" <<< "$x" &> /dev/null
	then
		[ -d $i ] && mv *."$i" "$i" &> /dev/null|| mkdir "$i" &> /dev/null
		echo "[+] Arquivo $x movido para $(pwd)/$i" 
	else
		echo "[-] Erro ao mover $x!"
	fi
   done
done
rm /tmp/out &> /dev/null	