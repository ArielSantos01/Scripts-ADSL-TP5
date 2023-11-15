#! /bin/bash
echo "Contar cantidad de archivos de una cinta."
echo "Ingresar la dirección del archivo de cinta"
read cinta
if ! test -f $cinta; then
	echo "No es válido el archivo de cinta."
	exit 1
fi
cantidad=`cpio -t < "$cinta" | wc -l`
echo "La cantidad de archivos es $cantidad"
