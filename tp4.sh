#!/bin/bash
# menu002.sh
# Copiar Directorio a Cinta
# Grupo 4 ASL
# 04/10/2023
#

#Realizar la copia con los parámetros ingresados
copiar(){
    #$1 - Directorio Origen
    #$2 - Archivo Cinta
      LOGFILE="/etc/log/logcopiadia/$(date +%Y%m%d%H%M).log"
      #Se escribe la dirección de cinta al inicio del LOGFILE, para facilitar su identificación en el tp5
      echo "$2" > "$LOGFILE"
      find $1 | cpio -ovcO "$2" 1>> "$LOGFILE" 2>> "$LOGFILE"
      
      if [ $? -eq 0 ]
      then
        echo "Se realizó la copia exitosamente. Presione ENTER para continuar."
      else
        echo "La operación ha fallado. Presione ENTER para continuar."
      fi
      echo "Logfile: $LOGFILE"
      read enter
}

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
   echo "                      1) Respaldar un Directorio"
   echo "                      2) Menu Anterior"
   echo " "
   echo -n "                                    Ingrese su opcion: "
   read opcion
   case $opcion in
     1)

       if ! test -d /etc/log/logcopiadia
       then
	 mkdir /etc/log/logcopiadia
       fi

       echo "Ingrese el nombre del directorio a respaldar (Path Completo)"
       read directorio
       if test -d "$directorio"
         then
	   echo "Ingrese el nombre del archivo de cinta al que se copiara (Path Completo)"
           read -r cinta
	   if test -f "$cinta"
	   then
	     echo "¿Desea sobreescribir el archivo? (S/N)"
	     read respuesta
	     case "$respuesta" in
	       S|s) 
		   copiar "$directorio" "$cinta";;
	         *) exit 1;;
	     esac
           else  
	     copiar "$directorio" "$cinta"
	   fi
          else 
	     echo -n "No existe el directorio especificado. Presione ENTER para continuar"
             read enter
       fi;;
     2)
       exit;;
     *)
       echo "Opción Inválida..."
       sleep 2
   esac
 done
