#!/bin/bash
#@Autor: Vicente Romero Andrade
#@Fecha creacion:  13/03/2021
#@Descripcion: Crea archivo de passwords y parametros
PWDFILE=$ORACLE_HOME/dbs/orapwvrabda2
echo "Haciendo export de ORACLE_SID"
export ORACLE_SID=vrabda2
echo "Creando archivo de passwords"
orapwd FILE=${PWDFILE} FORMAT=12.2 \
    FORCE=Y \
    SYS=password 
echo "Creando archivo PFILE"
touch $ORACLE_HOME/dbs/initvrabda2.ora
echo """
  db_name=vrabda2
  control_files=(/u01/app/oracle/oradata/VRABDA2/control01.ctl,
      /u02/app/oracle/oradata/VRABDA2/control02.ctl,
      /u03/app/oracle/oradata/VRABDA2/control03.ctl)
  memory_target=768M" > $ORACLE_HOME/dbs/initvrabda2.ora
