--@Autor: Vicente Romero Andrade
--@Fecha Creacion: 28/07/2021
--@Descripcion: Crea los tablespaces propuestos

connect sys/system2 as sysdba
Prompt connectando como sys
set serveroutput on

whenever sqlerror exit rollback;

Prompt Creando tablespace usersE2
create tablespace usersE2
	datafile '/disk_3/app/oracle/oradata/VRAPROY/usersE201.dbf' 
	size 500m autoextend on maxsize unlimited
    extent management local autoallocate
   	segment space management auto;

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
create tablespace multimediaObjTbs
   	datafile '/disk_4/app/oracle/oradata/VRAPROY/multimediaObjTbs.dbf'
   	size 200m autoextend on maxsize unlimited
   	extent management local autoallocate 
   	segment space management auto;

Prompt Creando tablespace autoextend on maxsize unlimited
create tablespace multimediaUsrTbs
   	datafile '/disk_5/app/oracle/oradata/VRAPROY/multimediaUsrTbs01.dbf'
   	size 200m autoextend on maxsize unlimited 
   	extent management local autoallocate
   	segment space management auto;
