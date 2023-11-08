#! /bin/bash

cinta="/dev/cinta/cinta.cpio"
cantidad=`cpio -tc < "$cinta" | wc -l`
echo "La cantidad de archivos es $cantidad"
      