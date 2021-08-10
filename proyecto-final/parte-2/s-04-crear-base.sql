--@Autor: Vicente Romero Andrade
--@Fecha creacion:  27/07/2021
--@Descripcion: Crea base de datos
connect sys/Hola1234! as sysdba
Prompt connectando como sys
set serveroutput on

startup nomount

whenever sqlerror exit rollback;
Prompt Iniciando la creación de la base de datos
create database vraproy
   user sys identified by system2
   user system identified by system2
   logfile group 1(
      '/u01/app/oracle/oradata/VRAPROY/redo01a.log',
      '/disk_2/app/oracle/oradata/VRAPROY/redo01b.log',
      '/disk_3/app/oracle/oradata/VRAPROY/redo01c.log') size 50m blocksize 512,
   group 2(
      '/u01/app/oracle/oradata/VRAPROY/redo02a.log',
      '/disk_2/app/oracle/oradata/VRAPROY/redo02b.log',
      '/disk_3/app/oracle/oradata/VRAPROY/redo02c.log') size 50m blocksize 512,
   group 3(
      '/u01/app/oracle/oradata/VRAPROY/redo03a.log',
      '/disk_2/app/oracle/oradata/VRAPROY/redo03b.log',
      '/disk_3/app/oracle/oradata/VRAPROY/redo03c.log') size 50m blocksize 512
   maxloghistory 1
   maxlogfiles 16
   maxlogmembers 3
   maxdatafiles 1024
   character set AL32UTF8
   national character set AL16UTF16
   extent management local  
   datafile '/u01/app/oracle/oradata/VRAPROY/system01.dbf'
      size 700m reuse autoextend on next 1M maxsize unlimited
   sysaux datafile '/u01/app/oracle/oradata/VRAPROY/sysaux01.dbf'
      size 550m reuse autoextend on next 1M maxsize unlimited
   default tablespace users
      datafile '/disk_2/app/oracle/oradata/VRAPROY/users.dbf'
      size 500m reuse autoextend on maxsize unlimited
   default temporary tablespace tempts1
      tempfile '/u01/app/oracle/oradata/VRAPROY/temp01.dbf'
      size 20m reuse autoextend on next 640k maxsize unlimited
   undo tablespace undotbs1
      datafile '/u01/app/oracle/oradata/VRAPROY/undotbs01.dbf'
      size 200m reuse autoextend on next 512k maxsize unlimited;

alter user sys identified by system2;
alter user system identified by system2;
alter user sysbackup identified by system2;

whenever sqlerror continue none
