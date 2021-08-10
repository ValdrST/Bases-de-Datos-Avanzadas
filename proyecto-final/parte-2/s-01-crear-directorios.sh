#!/bin/bash
#Autor: Vicente Romero Andrade
#Fecha Creacion: 28/07/2021
#Descripcion: Crea estructura carpetas para el proyecto

echo "Creando directorios para la simulacion de discos"
mkdir -p /disk_2
mkdir -p /disk_3
mkdir -p /disk_4
mkdir -p /disk_5
mkdir -p /disk_6
mkdir -p /disk 7

echo "Creando directorios para la instruccion create database"
mkdir -p /u01/app/oracle/oradata/VRAPROY
mkdir -p /disk_2/app/oracle/oradata/VRAPROY
mkdir -p /disk_3/app/oracle/oradata/VRAPROY
mkdir -p /disk_4/app/oracle/oradata/VRAPROY
mkdir -p /disk_5/app/oracle/oradata/VRAPROY
mkdir -p /disk_6/app/oracle/oradata/VRAPROY
mkdir -p /disk_7/app/oracle/oradata/VRAPROY

echo "Cambiando de dueño y grupo a disks"
chown root:oinstall /disk_2
chown root:oinstall /disk_3
chown root:oinstall /disk_4
chown root:oinstall /disk_5
chown root:oinstall /disk_6
chown root:oinstall /disk_7

echo "Cambiando de dueño y usuario a oracle"
chown -R oracle:oinstall /disk_2/app
chown -R oracle:oinstall /disk_3/app
chown -R oracle:oinstall /disk_4/app
chown -R oracle:oinstall /disk_5/app
chown -R oracle:oinstall /disk_6/app
chown -R oracle:oinstall /disk_7/app

echo "Cambiando permisos a los directorios"
chmod -R 754 /u01/app/oracle/oradata/VRAPROY
chmod -R 754 /disk_2
chmod -R 754 /disk_3
chmod -R 754 /disk_4
chmod -R 754 /disk_5
chmod -R 754 /disk_6
chmod -R 754 /disk_7

echo "crear directorio para el wallet"

mkdir -p $ORACLE_HOME/wallets
chmod -R 700 $ORACLE_HOME/wallets
# Contraseña del wallet sera Hola1234!
mkstore -wrl $ORACLE_HOME/wallets/oracle -create
mkstore -wrl $ORACLE_HOME/wallets/oracle -createCredential pc-vra.fi.unam:1521 sys system2




