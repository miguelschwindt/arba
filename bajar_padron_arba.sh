#!/bin/bash

# Este script genera el archivo XML requerido por ARBA y realiza la descarga del .zip, descomprime dicho zip en los .txt que luego 
# utilizaremos para actualizar las tablas de percepciones y retenciones de arba.

# Fuente: https://www.arba.gov.ar/Informacion/IBrutos/LinksIIBB/RegimenSujeto.asp

PRIMER_DIA=$(date -d "+$(date +%d) days" +"%Y%m01")
ULTIMO_DIA=$(date -d "-$(date +%d) days +1 month" +"%Y%m%d")

FORMATO_NOMBRE=DFEServicioDescargaPadron_
FORMATO_EXT=.xml

BASE_DIR_PATH=/home/user/script/archivos
BASE_ARBA=padron_arba.zip

ARCHIVO_PER=$BASE_DIR_PATH/PadronRGSPer$(date -d "+$(date +%d) days" +"%m%Y").txt
ARCHIVO_RET=$BASE_DIR_PATH/PadronRGSRet$(date -d "+$(date +%d) days" +"%m%Y").txt

cp $BASE_DIR_PATH/archivo_base.xml $BASE_DIR_PATH/nuevo.xml
sed -i -e "s/_desde_/$PRIMER_DIA/g" -e "s/_hasta_/$ULTIMO_DIA/g" $BASE_DIR_PATH/nuevo.xml
MD5="$(cat $BASE_DIR_PATH/nuevo.xml | md5sum | awk '{print $1}' )"

ARCHIVO=$FORMATO_NOMBRE$MD5$FORMATO_EXT

cp $BASE_DIR_PATH/nuevo.xml $BASE_DIR_PATH/$ARCHIVO

echo "Eliminando archivo $ARCHIVO_PER y $ARCHIVO_RET"
rm -rf $ARCHIVO_RET
rm -rf $ARCHIVO_PER

curl -X POST http://dfe.arba.gov.ar/DomicilioElectronico/SeguridadCliente/dfeServicioDescargaPadron.do -H 'Cache-Control: no-cache' \
     -F user=TU_CUIT_EN_ARBA -F password=TU_PASSWORD_EN_ARBA -F file=@$BASE_DIR_PATH/$ARCHIVO -o $BASE_DIR_PATH/$BASE_ARBA && \
    unzip $BASE_DIR_PATH/$BASE_ARBA -d $BASE_DIR_PATH/

chmod +wx $ARCHIVO_RET
chmod +wx $ARCHIVO_PER
