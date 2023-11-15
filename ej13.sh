#! /bin/bash

echo "Extraer archivos de un usuario específico"
if [ $# -ne 1 ]
  then
    echo "Uso: $0 <nombre de usuario>"
    exit 1
fi

usuario="$1"
directorio_usuario="/tmp/copia$usuario"

if ! grep -q "$usuario" "/etc/passwd"; then
  echo "No se ha encontrado el usuario $usuario"
  sleep 3
  exit 1
fi

echo "Ingresar la dirección del archivo de cinta"
read cinta

if ! test -f $cinta; then
        echo "No es válido el archivo de cinta."
        exit 1
fi

if ! test -d "$directorio_usuario" ; then
	mkdir -p "$directorio_usuario"
fi

#-tv muestra los archivos en formato ls -l
#awk muestra solo las lineas con el propietario "usuario"
#cpio usa directorios relativos, para copiar directamente sobre el directorio activo (directorio_usuario) 
#lo mismo se hace con el cpio -t, para que los liste como archivos relativos
cpio -idumF "$cinta" -D "$directorio_usuario" --no-absolute-filenames --quiet $(cpio -tv < "$cinta" --no-absolute-filenames --quiet | awk '{ if($3 == "'$usuario'") print $9}')
echo "Los archivos se han copiado exitosamente"
