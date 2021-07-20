--@Autor: Vicente Romero Andrade
--@Fecha creación:  20/07/2021
--@Descripción:  Script 1 del ejercicio 4 tema 6
whenever sqlerror exit rollback
set serveroutput on
connect sys/system2 as sysdba
--A
select
  TABLESPACE_NAME,
  BLOCK_SIZE,
  INITIAL_EXTENT,
  NEXT_EXTENT,
  MAX_SIZE,
  STATUS,
  CONTENTS,
  LOGGING
from DBA_TABLESPACES
--B
select
  TABLESPACE_NAME,
  EXTENT_MANAGEMENT,
  SEGMENT_SPACE_MANAGEMENT,
  BIGFILE,
  ENCRYPTED
from DBA_TABLESPACES;
--C
select
       D.USERNAME,
       D.DEFAULT_TABLESPACE,
       D.TEMPORARY_TABLESPACE,
       trunc(DT.BYTES/(1024*1024),2) as QUOTA_MB,
       DT.BLOCKS
from DBA_USERS D
    join DBA_TS_QUOTAS DT
        on DT.USERNAME = D.USERNAME;
whenever sqlerror continue
