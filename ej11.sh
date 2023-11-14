#!/bin/bash
echo "Buscar archivo específico entre los logs"
if [ $# -ne 1 ]
  then
    echo "Uso: $0 <nombre del archivo (path completo)>"
    exit 1
  fi

  archivo="$1"
  carpeta_log="/etc/log/logcopiadia"
  logs=$(ls -t "$carpeta_log")
  ultimo_log=""
for log in $logs; do
	if grep -q "$archivo" "$carpeta_log/$log"; then
		ultimo_log="$log"
		break
	fi
done

if [ "$ultimo_log" != "" ]; then
    #Se modificó el script de backup para mostrar en la primera linea del log la direccion de la cinta"
    cinta=$(head -n 1 "$carpeta_log/$ultimo_log")

    echo "Archivo encontrado en el log: $ultimo_log"
    echo "Dirección Cinta: $cinta"

    echo "¿Desea restituir el archivo desde el dispositivo? [S/N]"
    read respuesta
    case "$respuesta" in
      S|s) 
        if test -f "$archivo"
        then
          mv "$archivo" "${archivo}.bkp$(date +%Y%m%d)"
	fi
          echo "PROCESANDO... ESPERE O CTRL+C PARA ABORTAR"
	  cpio -idm "$archivo" < "$cinta"
          echo "SE RESTAURÓ EL ARCHIVO $archivo"
        ;;
      *)
        exit 0
        ;;
    esac
else
    echo "No se encontro el archivo en los últimos logs."
fi
