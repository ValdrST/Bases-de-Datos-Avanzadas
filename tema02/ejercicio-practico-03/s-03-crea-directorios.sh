#!/bin/bash
#@Autor: Vicente Romero Andrade
#@Fecha creacion: 14/03/2021
#@Descripcion: Crea directorios

rm -r /u01/app/oracle/oradata/VRABDA2/*
rm -r /u02/app/oracle/oradata/VRABDA2/*
rm -r /u03/app/oracle/oradata/VRABDA2/*

mkdir -p /u01/app/oracle/oradata/VRABDA2
mkdir -p /u02/app/oracle/oradata/VRABDA2
mkdir -p /u03/app/oracle/oradata/VRABDA2

chown oracle:oinstall /u01/app/oracle/oradata/VRABDA2
chown -R oracle:oinstall /u02
chown -R oracle:oinstall /u03

chmod 755 /u01/app/oracle/oradata/VRABDA2
chmod -R 754 /u02
chmod -R 754 /u03
