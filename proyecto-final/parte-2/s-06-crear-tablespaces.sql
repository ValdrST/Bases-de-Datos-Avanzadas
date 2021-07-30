--@Autor: Vicente Romero Andrade
--@Fecha Creacion: 28/07/2021
--@Descripcion: Crea los tablespaces propuestos

connect sys/system2 as sysdba
Prompt connectando como sys
set serveroutput on

whenever sqlerror exit rollback;

Prompt Creando tablespace usersPayTbs
create tablespace usersPayTbs
	datafile '/disk_3/app/oracle/oradata/VRAPROY/usersPay01.dbf' 
	size 500m autoextend on maxsize unlimited
    extent management local autoallocate
   	segment space management auto
	encryption using 'AES256'
	default storage(encrypt);
Prompt Creando tablespace undoUsersPayTbs
create undo tablespace undoUsersPayTbs
  datafile '/disk_3/app/oracle/oradata/VRAPROY/undoUsersPayTbs01.dbf'  size 50M
	autoextend on maxsize unlimited
  extent management local autoallocate
  segment space management auto
	encryption using 'AES256'
	default storage(encrypt);
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
   	size 1g blocksize 8k autoextend on next 256m maxsize unlimited
   	extent management local autoallocate 
   	segment space management auto;
