#! /bin/bash

if [ $# -ne 1 ]
then
	echo "Uso: $0 <nombre_usuario>"
	exit 1
fi

usuario=$1

if ! cat /etc/passwd | grep -q "$usuario"
then
  echo "No existe el usuario $usuario"
  sleep 3
  exit 1
fi  

directorio="/home/$usuario"

if ! test -d "/etc/copia"
then
	mkdir /etc/copia
fi

tar -czf "/etc/copia/$usuario$(date +%Y%m%d).tar.gz" "$directorio/Descargas"

if [ $? -eq 0 ]
then
	echo "Se copió el directorio exitosamente"
else
	echo "La copia ha fallado."
fi
