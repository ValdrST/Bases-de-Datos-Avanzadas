--@Autor: Vicente Romero Andrade
--@Fecha creación:  20/07/2021
--@Descripción:  Script 1 del ejercicio 5 tema 6
whenever sqlerror exit rollback
set serveroutput on
--A
create tablespace store_tbs1 
  datafile '/u01/app/oracle/oradata/VRABDA2/store_tbs01.dbf' 
  size 20M
  autoextent off
  extent management local autoallocate
  segment space management auto;
--B
create tablespace store_tbs_multiple
  datafile '/u01/app/oracle/oradata/VRABDA2/store_tbs_multiple_01.dbf' size 10M,
  '/u01/app/oracle/oradata/VRABDA2/store_tbs_multiple_02.dbf' size 10M,
  '/u01/app/oracle/oradata/VRABDA2/store_tbs_multiple_03.dbf' size 10M;
--C
create tablespace store_tbs_custom
  datafile '/u01/app/oracle/oradata/VRABDA2/store_tbs_custom_01.dbf' size 10M reuse
  autoextend on next 5m maxsize 30m
  blocksize 8k
  nologging
  offline
  extent management local uniform size 64k
  segment space management auto;
--D





whenever sqlerror continue
