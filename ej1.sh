#!/bin/bash
# tp5_1
# CPIO
# Grupo 4 ASL
#
while :
do
  clear
  tput cup 1 0
  echo "Usuario: $LOGNAME"
  tput cup 1 25
  echo "Terminal: `tty`"
  tput cup 1 65
  echo "Fecha: `date +%d/%m/%y`"
  tput cup 2 0
  echo "UTN FRM                                                                         "
  echo "ASL 2023                                                     Menu de Operaciones"
  echo " "
  echo "                      1) Buscar un archivo específico en cinta"
  echo "                      2) Listar archivos de una cinta"
  echo "                      3) Extraer archivos de un usuario"
  echo "                      4) Salir"
  echo " "
  echo -n "                                    Ingrese su opcion: "
  read opcion
  case $opcion in
    1)
      if [ $# -ne 1 ]
      then
        echo "Uso: $0 <nombre del archivo>"
        exit 1
      fi

      archivo="$1"
      ultimo_log=$(ls -1t /etc/log/logcopiadia/*.log | head -1)
      #cinta="/dev/cinta"
      cinta="/home/ariel/workspaces/bash/Scripts-ADSL-TP4/cinta"
      echo $ultimo_log
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
    ;;

    2)
      #Si entro directamente a esta opcion, falta indicar la cinta
      cpio -tc < "($cinta)" | wc -l
      ;;
    3)
      if [ $# -ne 1 ]
      then
        echo "Uso: $0 <nombre de usuario>"
        exit 1
      fi

      usuario="$1"
      directorio_usuario="/tmp/copia$usuario"

      if cat /etc/passwd | grep "$1"
      then
      cpio -t <("$cinta") | grep "$1" | cpio -idum <("$cinta") -D "$directorio_usuario"
      else
        echo "No se ha encontrado el usuario $usuario"
        sleep 3
        exit 1
      fi
      ;;
    *)
    exit 0
  esac
done