#! /bin/bash

if [ $# -ne 1 ]
  then
    echo "Uso: $0 <nombre de usuario>"
    exit 1
fi

usuario="$1"
directorio_usuario="/tmp/copia$usuario"
cinta="/dev/cinta/cinta.cpio"

if cat /etc/passwd | grep "$usuario"
then
  cpio -t < "$cinta" | grep "$usuario" | cpio -D "$directorio_usuario" -idum < "$cinta" 
  echo "Los archivos se han copiado exitosamente"
else
  echo "No se ha encontrado el usuario $usuario"
  sleep 3
  exit 1
fi
