#! /bin/bash

echo "Extraer archivos de un usuario específico"
if [ $# -ne 1 ]
  then
    echo "Uso: $0 <nombre de usuario>"
    exit 1
fi

echo "Ingresar la dirección del archivo de cinta"
read cinta

usuario="$1"
directorio_usuario="/tmp/copia$usuario"

if ! test -d "$directorio_usuario" ; then
	mkdir -p "$directorio_usuario"
fi

if grep -q "$usuario" "/etc/passwd"
then
  #-tv muestra los archivos en formato ls -l
  #awk muestra solo las lineas con el propietario "usuario"
  #cpio usa directorios relativos, para copiar directamente sobre el directorio activo (directorio_usuario) 
  #lo mismo se hace con el cpio -t, para que los liste como archivos relativos
  cpio -idumF "$cinta" -D "$directorio_usuario" --no-absolute-filenames --quiet $(cpio -tv < "$cinta" --no-absolute-filenames --quiet | awk '{ if($3 == "'$usuario'") print $0}')
  echo "Los archivos se han copiado exitosamente"
else
  echo "No se ha encontrado el usuario $usuario"
  sleep 3
  exit 1
fi
