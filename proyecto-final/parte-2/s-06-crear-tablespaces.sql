--@Autor: Vicente Romero Andrade
--@Fecha Creacion: 28/07/2021
--@Descripcion: Crea los tablespaces propuestos

connect sys/system2 as sysdba
Prompt connectando como sys
set serveroutput on
ALTER SYSTEM SET WALLET_ROOT='/u01/app/oracle/product/19.0.0/dbhome_1/wallets/oracle' SCOPE=SPFILE;
shutdown immediate
startup

whenever sqlerror exit rollback;
Prompt Crear cartera de claves
alter system set tde_configuration="keystore_configuration=file" scope=both;
administer key management create keystore identified by "Hola1234!";
administer key management set keystore OPEN identified by "Hola1234!";
administer key management set key using tag 'master key' identified by "Hola1234!" with backup using 'masterbackup';
ADMINISTER KEY MANAGEMENT SET KEY USING TAG 'rotate_key' FORCE KEYSTORE IDENTIFIED BY "Hola1234!" WITH BACKUP USING 'backup_key';
Prompt Creando tablespace usersPayTbs
create tablespace usersPayTbs
	datafile '/disk_3/app/oracle/oradata/VRAPROY/usersPay01.dbf'
	size 500m reuse autoextend on maxsize unlimited
    extent management local autoallocate
  	segment space management auto
	encryption using 'AES256'
	default storage(encrypt);

Prompt Creando tablespace undoUsersPayTbs
create undo tablespace undoUsersPayTbs
  datafile '/disk_3/app/oracle/oradata/VRAPROY/undoUsersPayTbs01.dbf'  size 50M
	autoextend on maxsize unlimited
  extent management local autoallocate;

Prompt Creando tablespace multimediaTbs
create tablespace multimediaTbs
	datafile '/disk_3/app/oracle/oradata/VRAPROY/multimediaTbs01.dbf'
   	size 500m autoextend on maxsize unlimited
   	extent management local autoallocate 
   	segment space management auto;

Prompt Creando tablespace usersTbs
create tablespace usersTbs
   	datafile '/disk_2/app/oracle/oradata/VRAPROY/usersTbs01.dbf'
   	size 500m autoextend on maxsize unlimited 
   	extent management local autoallocate 
   	segment space management auto;

Prompt Creando tablespace indexesTbs
create tablespace indexesTbs
   	datafile '/disk_3/app/oracle/oradata/VRAPROY/indexTbs01.dbf'
   	size 200m autoextend on next 10m maxsize 300m
   	extent management local autoallocate 
   	segment space management auto;

Prompt Creando tablespace multimediaObjTbs
create bigfile tablespace multimediaObjTbs
   	datafile '/disk_4/app/oracle/oradata/VRAPROY/multimediaObjTbs.dbf'
   	size 1g autoextend on next 256m maxsize unlimited
   	extent management local autoallocate 
   	segment space management auto;
