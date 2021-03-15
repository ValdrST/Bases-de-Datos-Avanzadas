--@Autor: Vicente Romero Andrade
--@Fecha creacion: 14/03/2021
--@Descripcion: Crea bd
whenever sqlerror exit rollback;

connect sys/hola1234* as sysdba
--startup nomount
create database vrabda2
  user sys identified by system2
  user system identified BY system2
  logfile group 1 (
    '/u01/app/oracle/oradata/VRABDA2/redo01a.log',
    '/u02/app/oracle/oradata/VRABDA2/redo01b.log',
    '/u03/app/oracle/oradata/VRABDA2/redo01c.log') size 50m blocksize 512,
    group 2 (
    '/u01/app/oracle/oradata/VRABDA2/redo02a.log',
    '/u02/app/oracle/oradata/VRABDA2/redo02b.log',
    '/u03/app/oracle/oradata/VRABDA2/redo02c.log') size 50m blocksize 512,
    group 3 (
    '/u01/app/oracle/oradata/VRABDA2/redo03a.log',
    '/u02/app/oracle/oradata/VRABDA2/redo03b.log',
    '/u03/app/oracle/oradata/VRABDA2/redo03c.log') size 50m blocksize 512
  maxloghistory 1
  maxlogfiles 16
  maxlogmembers 3
  maxdatafiles 1024
  character set AL32UTF8
  national character set AL16UTF16
  extent management local
  datafile '/u01/app/oracle/oradata/VRABDA2/system01.dbf'
    size 700m reuse autoextend on next 10240k maxsize unlimited
  sysaux datafile '/u01/app/oracle/oradata/VRABDA2/sysaux01.dbf'
    size 550m reuse autoextend on next 10240k maxsize unlimited
  default tablespace users
    datafile '/u01/app/oracle/oradata/VRABDA2/users01.dbf'
    size 500m reuse autoextend on maxsize unlimited
  default temporary tablespace tempts1
    tempfile '/u01/app/oracle/oradata/VRABDA2/temp01.dbf'
    size 20m reuse autoextend on next 640k maxsize unlimited
  undo tablespace undotbs1
    datafile '/u01/app/oracle/oradata/VRABDA2/undotbs01.dbf'
    size 200m reuse autoextend on next 5120k maxsize unlimited;


alter user sys identified by system2;
alter user system identified by system2;

whenever sqlerror continue none
disconnect
