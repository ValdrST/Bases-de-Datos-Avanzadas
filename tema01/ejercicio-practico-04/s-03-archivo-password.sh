#!/bin/bash
# @Autor     Vicente Romero Andrade
# @Fecha     06/03/2021
# @Descripcion  Script 2 del ejercicio 4 tema 1 Crea archivo de passwords


BACKUP_DIR="/home/${USER}/backups"
PWDFILE="$ORACLE_HOME/dbs/orapwvrabda1"
if [ "$USER" = "oracle" ]; then
  if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
  fi
  cp "$PWDFILE" "$BACKUP_DIR"

  rm -f "$PWDFILE"

  orapwd file="$PWDFILE" \
    sys=password \
    sysbackup=password \
    force=Y FORMAT=12.2

else
  echo "No esta logeado como usario oracle"
fi
