#!/bin/bash

# Para que este script funcione seguir los pasos
# 1) Setear el archivo ~/.pgpass con los datos de usuario y pass para postgres y darle al archivo permiso chmod 0600
# 2) Agergar siempre las rutas absolutas a los archivos
# 3) Setear la salida a un archivo de log para ver la rta
# 4) Configurar el crontab -e

BASE_DIR=/home/user/script
ARCHIVO_RET=archivos/PadronRGSRet$(date -d "+$(date +%d) days" +"%m%Y").txt
ARCHIVO_PER=archivos/PadronRGSPer$(date -d "+$(date +%d) days" +"%m%Y").txt

sh $BASE_DIR/bajar_padron_arba.sh
sh $BASE_DIR/arba_retencion.sh nombre_base_de_datos localhost 5432 $BASE_DIR/$ARCHIVO_RET
sh $BASE_DIR/arba_percepciones.sh nombre_base_de_datos localhost 5432 $BASE_DIR/$ARCHIVO_PER
