--@Autor: Vicente Romero Andrade
--@Fecha creación:  20/07/2021
--@Descripción:  Script 1 del ejercicio 2 tema 7
whenever sqlerror exit rollback
set serveroutput on
connect sys/system2 as sysdba
--A
alter database datafile '/u01/app/oracle/oradata/VRABDA2/store_tbs_multiple_01.dbf' offline;
alter database datafile '/u01/app/oracle/oradata/VRABDA2/store_tbs_multiple_02.dbf' offline;
alter database datafile '/u01/app/oracle/oradata/VRABDA2/store_tbs_multiple_03.dbf' offline;
--B
alter tablespace store_tbs_multiple offline normal;
--C
connect VRA_TBS_MULTIPLE/VRA_TBS_MULTIPLE
SELECT count(*) FROM VRA_TBS_MULTIPLE;
--D
connect sys/system2 as sysdba
SELECT
  FILE_NAME,
  FILE_ID,
  STATUS
FROM DBA_DATA_FILES WHERE TABLESPACE_NAME ='STORE_TBS_MULTIPLE';
--E
alter tablespace STORE_TBS_MULTIPLE 
rename
  '/u01/app/oracle/oradata/VRABDA2/store_tbs_multiple_01.dbf',
  '/u02/app/oracle/oradata/VRABDA2/store_tbs_multiple_02.dbf',
  '/u03/app/oracle/oradata/VRABDA2/store_tbs_multiple_03.dbf'
to 
  '/u03/app/oracle/oradata/VRABDA2/store_tbs_multiple_013.dbf',
  '/u02/app/oracle/oradata/VRABDA2/store_tbs_multiple_023.dbf',
  '/u01/app/oracle/oradata/VRABDA2/store_tbs_multiple_031.dbf';
alter tablespace store_tbs_multiple online;
--F
alter database move
datafile '/u03/app/oracle/oradata/VRABDA2/store_tbs_multiple_013.dbf'
to '/u01/app/oracle/oradata/VRABDA2/store_tbs_multiple_01.dbf' reuse;
alter database move
datafile '/u02/app/oracle/oradata/VRABDA2/store_tbs_multiple_023.dbf'
to '/u02/app/oracle/oradata/VRABDA2/store_tbs_multiple_02.dbf' reuse;
alter database move
datafile '/u01/app/oracle/oradata/VRABDA2/store_tbs_multiple_031.dbf'
to '/u03/app/oracle/oradata/VRABDA2/store_tbs_multiple_03.dbf' reuse;
--G
!mv /u01/app/oracle/oradata/VRABDA2/store_tbs01.dbf /u01/app/oracle/oradata/VRABDA2/store_tbs01.dbfcopy
-- Solo falla si se usa algo de ese datafile -1
-- No se puede 2
-- Se pone offline de manera exitosa
-- Si se detiene la instancia
-- Si se inicia sin problemas
-- pasos para recuperar
SHUTDOWN IMMEDIATE;
STARTUP MOUNT;
alter database datafile '/u01/app/oracle/oradata/VRABDA2/store_tbs01.dbf' offline for drop;
ALTER DATABASE OPEN; -- A partir de aqui recuperar con archivos SQL



whenever sqlerror continue
