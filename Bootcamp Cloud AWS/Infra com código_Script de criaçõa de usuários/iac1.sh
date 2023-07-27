# Bootcamp Cloud AWS
# Desafio 1 "Script de Criação de Estrutura de Usuários, Diretórios e Permissões"
# Autor: [Luis Pontes]
# Perfil DIO: [https://web.dio.me/users/MAILTOLUISCARLOS]
# GitHub: [https://github.com/CientistaPY]

#!/bin/bash

echo "Criando diretórios..."

mkdir /publico
mkdir /adm
mkdir /ven
mkdir /sec

echo "Criando grupos de usuários..."

groupadd GRP_ADM
groupadd GRP_VEN
groupadd GRP_SEC

echo "Criando usuários..."

useradd carol -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_ADM
useradd marta -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_ADM
useradd joao -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_ADM

useradd denis -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_VEN
useradd sebastiana -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_VEN
useradd robert -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_VEN

useradd jose -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_SEC
useradd nanda -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_SEC
useradd roger -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_SEC

echo "Especificando as permissões dos diretórios...."

chown root:GRP_ADM /adm
chown root:GRP_VEN /ven
chown root:GRP_SEC /sec

chmod 770 /adm
chmod 770 /ven
chmod 770 /sec
chmod 777 /publico

echo "Fim....."

