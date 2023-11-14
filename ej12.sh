#! /bin/bash
echo "Contar cantidad de archivos de una cinta."
echo "Ingresar la dirección del archivo de cinta"
read cinta
cantidad=`cpio -t < "$cinta" | wc -l`
echo "La cantidad de archivos es $cantidad"
