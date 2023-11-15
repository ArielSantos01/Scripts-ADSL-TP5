#! /bin/bash

echo "Mostrar contenido de un archivo tar.gz"
if [ $# -ne 1 ]
then
	echo "Uso: $0 <archivo_comprimido>"
	exit 1
fi

archivo=$1

if ! test -f "$archivo"
then
  echo "No existe el archivo"
  sleep 3
  exit 1
fi  
tar -tvf <(zcat "$archivo") | less
