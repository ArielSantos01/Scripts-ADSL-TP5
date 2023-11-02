#! /bin/bash

if [ $# -ne 1 ]
  then
    echo "Uso: $0 <nombre de usuario>"
    exit 1
fi

usuario="$1"
directorio_usuario="/tmp/copia$usuario"
cinta="/home/ariel/workspaces/bash/Scripts-ADSL-TP4/cinta"

if cat /etc/passwd | grep "$usuario"
then
  cpio -t < "$cinta" | grep "$usuario" | cpio -idum < "$cinta" -D "$directorio_usuario"

else
  echo "No se ha encontrado el usuario $usuario"
  sleep 3
  exit 1
fi
