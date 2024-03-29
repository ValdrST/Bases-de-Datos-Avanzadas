#!/bin/bash
#Autor: Vicente Romero Andrade
#Fecha Creacion: 28/07/2021
#Descripcion: Crea PFILE y el archivo de password

archivoPwd="${ORACLE_HOME}"/dbs/orapwvraproy
echo "${ORACLE_HOME}"/dbs/orapwvraproy
export ORACLE_SID=vraproy
echo "Inicio creacion archivo passwords"
orapwd FILE=${archivoPwd} FORMAT=12.2 \
    FORCE=Y \
    SYS=Hola1234! \
    SYSBACKUP=Hola1234!
echo "Inicio creacion archivo PFILE"
touch $ORACLE_HOME/dbs/initvraproy.ora
echo """
  db_name=vraproy
  db_domain=fi.unam
  control_files=(/u01/app/oracle/oradata/VRAPROY/control01.ctl,
    /disk_2/app/oracle/oradata/VRAPROY/control02.ctl,
    /disk_6/app/oracle/oradata/VRAPROY/flash_recovery_area/control03.ctl)
  memory_target=768M
""" >> $ORACLE_HOME/dbs/initvraproy.ora
