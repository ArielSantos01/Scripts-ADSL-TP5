#!/bin/bash

# Buscar el último archivo .log que contiene la línea "menu.sh"
latest_log=$(grep -l "menu.sh" /etc/log/logcopiadia/*.log | sort -r | head -1)

if [ -z "$latest_log" ]; then
    echo "No se encontraron archivos .log que contengan 'menu.sh'."
    exit 1
else
    echo "El último archivo .log que contiene 'menu.sh' es: $latest_log"
fi

