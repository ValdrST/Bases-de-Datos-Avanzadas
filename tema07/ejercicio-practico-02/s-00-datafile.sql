--@Autor: Vicente Romero Andrade
--@Fecha creación:  20/07/2021
--@Descripción:  Script 1 del ejercicio 2 tema 7
whenever sqlerror exit rollback
set serveroutput on
connect sys/system2 as sysdba
--A
SELECT
  FILE_NAME,
  FILE_ID,
  TRUNC((BYTES/(1024*1024)),2) SIZE_MB
FROM DBA_DATA_FILES WHERE TABLESPACE_NAME ='STORE_TBS_MULTIPLE';
--B
SELECT
       TRUNC((SUM(DF.BYTES)-NVL(SUM(S.BYTES),0))/(1024*1024),2) MB_LIBRES,
       (SUM(DF.BLOCKS)-NVL(SUM(S.BLOCKS),0)) BLOQUES_DISPONIBLES
FROM DBA_DATA_FILES DF
    LEFT JOIN DBA_SEGMENTS S
        ON S.TABLESPACE_NAME = DF.TABLESPACE_NAME
WHERE DF.TABLESPACE_NAME='STORE_TBS_MULTIPLE';
--C
--CREATE USER VRA_TBS_MULTIPLE IDENTIFIED BY VRA_TBS_MULTIPLE 
  --quota unlimited on store_tbs_multiple 
  --default tablespace store_tbs_multiple;
--D
declare
  v_count number;
  v_username varchar2(30) := 'VRA_TBS_MULTIPLE';
  v_table varchar2(30) := 'VRA_TBS_MULTIPLE';
begin
  --Verificar si la table existe
  select count(*) into v_count
  from all_tables
  where table_name = v_table
  and owner = v_username;

  if v_count > 0 then
    execute immediate 'drop table '||v_username||'.'||v_table;
  end if;
  execute immediate 'create table '||v_username||'.'||v_table||' (
    str char(1024 byte)
  ) segment creation immediate';
end;
/
--E
SELECT DF.FILE_NAME,
       DF.FILE_ID,
       COUNT(DE.SEGMENT_NAME) NUMERO_EXTENSIONES,
       SUM(DE.BYTES/(1024*1024)) TOTAL_MB,
       SUM(DE.BLOCKS) BLOQUES_RESERVADOS
    FROM DBA_SEGMENTS DS
JOIN DBA_DATA_FILES DF
    ON DS.HEADER_FILE = DF.FILE_ID
JOIN DBA_DATA_FILES DF
    ON DS.HEADER_FILE = DF.FILE_ID
JOIN DBA_EXTENTS DE
    ON DS.SEGMENT_NAME = DE.SEGMENT_NAME
WHERE DS.SEGMENT_NAME like '%VRA_TBS_MULTIPLE%'
GROUP BY DF.FILE_NAME, DF.FILE_ID;
--F
declare
  v_count number := 0;
begin
  while v_count < 512 loop
  insert into VRA_TBS_MULTIPLE.VRA_TBS_MULTIPLE(str) values('$');
  v_count := v_count + 1;
  end loop;
  commit;
end;
/
--G
SELECT DF.FILE_NAME,
       DF.FILE_ID,
       COUNT(DE.SEGMENT_NAME) NUMERO_EXTENSIONES,
       SUM(DE.BYTES/(1024*1024)) TOTAL_MB,
       SUM(DE.BLOCKS) BLOQUES_RESERVADOS
    FROM DBA_SEGMENTS DS
JOIN DBA_DATA_FILES DF
    ON DS.HEADER_FILE = DF.FILE_ID
JOIN DBA_DATA_FILES DF
    ON DS.HEADER_FILE = DF.FILE_ID
JOIN DBA_EXTENTS DE
    ON DS.SEGMENT_NAME = DE.SEGMENT_NAME
WHERE DS.SEGMENT_NAME like '%VRA_TBS_MULTIPLE%'
GROUP BY DF.FILE_NAME, DF.FILE_ID;
--H
declare
  v_count number := 0;
begin
  while v_count < 512*5 loop
  insert into VRA_TBS_MULTIPLE.VRA_TBS_MULTIPLE(str) values('$');
  v_count := v_count + 1;
  end loop;
  commit;
end;
/
SELECT DF.FILE_NAME,
       DF.FILE_ID,
       COUNT(DE.SEGMENT_NAME) NUMERO_EXTENSIONES,
       SUM(DE.BYTES/(1024*1024)) TOTAL_MB,
       SUM(DE.BLOCKS) BLOQUES_RESERVADOS
    FROM DBA_SEGMENTS DS
JOIN DBA_DATA_FILES DF
    ON DS.HEADER_FILE = DF.FILE_ID
JOIN DBA_DATA_FILES DF
    ON DS.HEADER_FILE = DF.FILE_ID
JOIN DBA_EXTENTS DE
    ON DS.SEGMENT_NAME = DE.SEGMENT_NAME
WHERE DS.SEGMENT_NAME like '%VRA_TBS_MULTIPLE%'
GROUP BY DF.FILE_NAME, DF.FILE_ID;
--I
SELECT
       TRUNC((SUM(DF.BYTES)-NVL(SUM(S.BYTES),0))/(1024*1024),2) MB_LIBRES,
       (SUM(DF.BLOCKS)-NVL(SUM(S.BLOCKS),0)) BLOQUES_DISPONIBLES
FROM DBA_DATA_FILES DF
    LEFT JOIN DBA_SEGMENTS S
        ON S.TABLESPACE_NAME = DF.TABLESPACE_NAME
WHERE DF.TABLESPACE_NAME='STORE_TBS_MULTIPLE';

whenever sqlerror continue
