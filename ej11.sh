#!/bin/bash

if [ $# -ne 1 ]
  then
    echo "Uso: $0 <nombre del archivo (path completo)>"
    exit 1
  fi

  archivo="$1"
  ultimo_log=$(ls -1t /etc/log/logcopiadia/*.log | head -1)
  cinta="/dev/cinta/cinta.cpio"

  if grep -q "$archivo" "$ultimo_log"
  then
    less $ultimo_log
    echo "¿Desea restituir el archivo desde el dispositivo?"
    read respuesta
    case "$respuesta" in
      S|s) 
        if test -f "$archivo"
        then
          mv "$archivo" "${archivo}.bkp$(date +%Y%m%d)"
          echo "PROCESANDO... ESPERE O CTRL+C PARA ABORTAR"
          cpio -idm < "$cinta" "$archivo"
          echo "SE RESTAURÓ EL ARCHIVO $archivo"
        else
          echo "El archivo no existe"
        fi
        ;;
      *)
        exit 0
        ;;
    esac
else
    echo "No se encontro el archivo en el último log."
fi