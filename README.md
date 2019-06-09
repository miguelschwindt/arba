# arba
Descargar Padrón completo ARBA, Provincia de Buenos Aires


# PROCESO PARA MANTENER ACTUALIZADO EL PADRÓN DE ARBA PROV. BSAS

#### Fecha: 07/06/2019 11h25
#### Autor: Miguel Schwindt - miguel@mstechnology.com.ar
#### Fuente: https://www.arba.gov.ar/Informacion/IBrutos/LinksIIBB/RegimenSujeto.asp

1) Mantener la estructura de 
	/home/user/script/
	/home/user/script/archivos
   
   En cada uno de ellos incluir los archivos que se ven en las carpetas, son 4 .sh y
   un .xml dentro de la carpeta archivos

2) Editar cada archivo segun el nombre de usuario de tu sistema

3) Para ejecutar dentro del crontab -> Setear el archivo ~/.pgpass con los datos de 
   usuario y pass para postgres y darle al archivo permiso chmod 0600

4) Agregar siempre las rutas absolutas a los archivos

5) Configurar el crontab -e y setear la salida en log.txt
   Ej. se ejecuta a las 00:05 del primer día de cada mes:

   5  0  1  *  *  /home/user/script/proceso_arba.sh 1> /home/user/script/log.txt

6) Requiere las siguientes 2 tablas en la base de datos, en mi caso la cree con PostgreSQL:
	
  ```
  CREATE TABLE arba_percepciones
  (
    cuit bigint NOT NULL,
    regimen text,
    fecha_publicacion integer,
    fecha_vigencia_desde integer,
    fecha_vigencia_hasta integer,
    tipo_contribuyente text,
    abm text,
    cambio_alicuota text,
    alicuota numeric(6,2),
    nro_grupo text,
    fecha timestamp with time zone DEFAULT now(),
    CONSTRAINT pk_arba_percepciones PRIMARY KEY (cuit)
  );
  ```

  ```
  CREATE TABLE arba_retenciones
  (
    cuit bigint NOT NULL,
    regimen text,
    fecha_publicacion integer,
    fecha_vigencia_desde integer,
    fecha_vigencia_hasta integer,
    tipo_contribuyente text,
    abm text,
    cambio_alicuota text,
    alicuota numeric(6,2),
    nro_grupo text,
    fecha timestamp with time zone DEFAULT now(),
    CONSTRAINT pk_arba_retenciones PRIMARY KEY (cuit)
  );
  ```


