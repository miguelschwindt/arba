#!/bin/bash

# 4 Parametros de entrada
# $1 --> nombre base de datos
# $2 --> IP o localhost
# $3 --> Puerto EJ: 5432
# $4 --> nombre archivo txt a importar

ROJO='\033[0;31m'
AZUL='\033[0;34m'
NC='\033[0m' # No Color


if [ $# -eq 4 ]
  then
    echo "START RUNNING..."
    echo "Cambiando , por . y eliminando los 2 ultimos digitos de cada linea, un espaico y la ; $4"
    sed -i -e 's/,/./g ; s/..$//g' $4

    echo "ELIMINO TABLA arba_retenciones..."
    psql -U postgres -h $2 -p $3 -d $1 -c "DELETE FROM arba_retenciones"

    echo "Importo txt $4 en la tabla Retenciones arba_retenciones..."
    psql -U postgres -h $2 -p $3 -d $1 -c "\copy arba_retenciones(regimen,fecha_publicacion,fecha_vigencia_desde,fecha_vigencia_hasta,cuit,tipo_contribuyente,abm,cambio_alicuota,alicuota,nro_grupo) from '$4' delimiter ';' csv"
    echo "END RUNNING OK..."
else
    echo "${ROJO}Se requieren 1 argumento: 1) BASE DE DATOS, 2) IP o localhost, 3) Puerto (Ej:5432), 4) NOMBRE DEL ARCHIVO TXT a IMPORTAR ${NC}"
fi
