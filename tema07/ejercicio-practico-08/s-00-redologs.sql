--@Autor: Vicente Romero Andrade
--@Fecha creación:  20/07/2021
--@Descripción:  Script 1 del ejercicio 2 tema 7
whenever sqlerror exit rollback
set serveroutput on
connect sys/system2 as sysdba
--A
!find /u0* -name redo*.log
--B
SELECT
       lf.GROUP#,
       l.SEQUENCE#,
       (BYTES/(1024*1024)) size_mb,
       BLOCKSIZE,
       MEMBERS,
       l.STATUS,
       min(FIRST_CHANGE#) MINIMO_SCN,
       min(FIRST_CHANGE#) FECHA_MINIMO_SCN,
       min(NEXT_CHANGE#) MAXIMO_SCN
FROM v$logfile lf
    join v$log l on lf.GROUP#=l.GROUP#
group by lf.GROUP#, l.SEQUENCE#, (BYTES/(1024*1024)), BLOCKSIZE, MEMBERS, l.STATUS;
--C
-- SE USA EL GRUPO 3
--D
SELECT
       lf.GROUP#,lf.STATUS,lf.TYPE,MEMBER
FROM v$logfile lf
    join v$log l on lf.GROUP#=l.GROUP#;
-- NULO SIGNIFICA QUE AUN SIGUE EN USO EL ARCHIVO, LOS OTROS ESTADOS SOLO HABLAN DE INDISPONIBILIDAD
-- INVALID, STALE, DELETED
-- E
ALTER DATABASE 
  ADD LOGFILE GROUP 4(
    '/u01/app/oracle/oradata/VRABDA2/redo01_A.log',
    '/u01/app/oracle/oradata/VRABDA2/redo01_B.log')
    SIZE 50M BLOCKSIZE 512;

ALTER DATABASE 
  ADD LOGFILE GROUP 5(
    '/u01/app/oracle/oradata/VRABDA2/redo02_A.log',
    '/u01/app/oracle/oradata/VRABDA2/redo02_B.log')
    SIZE 50M BLOCKSIZE 512;
ALTER DATABASE 
  ADD LOGFILE GROUP 6(
    '/u01/app/oracle/oradata/VRABDA2/redo03_A.log',
    '/u01/app/oracle/oradata/VRABDA2/redo03_B.log')
    SIZE 50M BLOCKSIZE 512;
-- F
ALTER DATABASE
  ADD LOGFILE MEMBER '/u01/app/oracle/oradata/VRABDA2/redo01_C.log' TO GROUP 4;
ALTER DATABASE
  ADD LOGFILE MEMBER '/u01/app/oracle/oradata/VRABDA2/redo02_C.log' TO GROUP 5;
ALTER DATABASE
  ADD LOGFILE MEMBER '/u01/app/oracle/oradata/VRABDA2/redo03_C.log' TO GROUP 6;
-- G 
SELECT
       lf.GROUP#,
       l.SEQUENCE#,
       (BYTES/(1024*1024)) size_mb,
       BLOCKSIZE,
       MEMBERS,
       l.STATUS,
       min(FIRST_CHANGE#) MINIMO_SCN,
       min(FIRST_CHANGE#) FECHA_MINIMO_SCN,
       min(NEXT_CHANGE#) MAXIMO_SCN
FROM v$logfile lf
    join v$log l on lf.GROUP#=l.GROUP#
group by lf.GROUP#, l.SEQUENCE#, (BYTES/(1024*1024)), BLOCKSIZE, MEMBERS, l.STATUS;
-- H
-- Los archivos son inaccesibles ya que no han sido creados
-- I
-- J
alter database clear logfile group 3;
-- K
alter database drop logfile group 1;
alter database drop logfile group 2;
alter database drop logfile group 3;
--L
! find /u0* -name redo*0[1-3][a-c].log -exec rm {} \;
--M
!find /u0* -name redo*.log
whenever sqlerror continue
