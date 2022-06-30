#!/bin/bash
arq=""
a=""
user=""
ip=""
maquina=""
DATE=$(date '+%d-%m-%Y-%H-%M-%S')
dir=""

echo "======================================================= BACKUP REMOTO =================================================================================="
echo $DATE
echo "========================================================= SHELL SCRIPT ================================================================================="
echo ""
echo "1 para listar os backups"
echo ""
echo "2 para fazer o backup"
echo ""
echo "3 para sair"
echo ""
echo "4 para deletar arquivos indesejaveis ou descompactados"
echo ""
echo "5 para restaurar backup"
echo ""
while [ "$a" != "3" ] ; do
        read -p "Escolha uma opção: " a
        if [ $a == "1" ] ; then
                read -p "Escolha a maquina para listar os backups: " maquina
                ls /home/marcelo/projeto_script/rsbackups/$maquina
        elif [ $a == "2" ] ; then
                read -p "Digite o user que realiza o backup remoto: " user
                read -p "Digite o ip desse user: " ip
                read -p "Qual maquina está realizando backup: " maquina
                read -p "Qual o diretorio a se fazer o backup" dir
                cd /home/marcelo/projeto_script/rsbackups/$maquina/
                rsync -avzhe ssh --progress --remove-source-files $user@$ip:/home/$user/$dir /home/marcelo/projeto_script/rsbackups/$maquina
                tar -czf $DATE.tar.gz /home/marcelo/projeto_script/rsbackups && mv /home/marcelo/projeto_script/rsbackups/$maquina
        elif [ $a == "4" ] ; then
                read -p "Digite os arquivos: "
                rm /home/marcelo/projeto_script/rsbackups/$maquina/$arq
        elif [ $a == "5" ] ; then
                 rsync -avzh /home/marcelo/projeto_script/rsbackups/$maquina/ $user@$ip:/home/$user/
        fi
done

echo "============================================== Projeto de Programação de Script feito por Marcelo Lucas Lima Lira da Silva =============================="
echo $DATE
echo "===================================================== IFPB ==============================================================================================="
