--@Autor: Vicente Romero Andrade
--@Fecha creación:  20/07/2021
--@Descripción:  Script 1 del ejercicio 10 tema 7
whenever sqlerror exit rollback
set serveroutput on
connect sys/system2 as sysdba
--A
SELECT value FROM v$parameter WHERE name='undo_tablespace';
whenever sqlerror continue
--B
create undo tablespace undotbs2
  datafile '/u01/app/oracle/oradata/VRABDA2/undotbs_2.dbf' size 30M
  autoextend off
  extent management local autoallocate;
--C
alter system set undo_tablespace='UNDOTBS2' scope=memory;
--D
connect sys/system2 as sysdba
SELECT value FROM v$parameter WHERE name='undo_tablespace';
--E
SELECT BEGIN_TIME,
       END_TIME,
       UNDOTSN,
       UNDOBLKS as TOTAL_BLOQUES_UNDO_USADOS,
       TXNCOUNT as NUM_TRANSACCIONES,
       MAXQUERYID,
       MAXQUERYLEN,
       ACTIVEBLKS,
       UNEXPIREDBLKS,
       EXPIREDBLKS,
       TUNED_UNDORETENTION
FROM V$UNDOSTAT WHERE ROWNUM<=20 ORDER BY BEGIN_TIME DESC;
--F
--Los que son EXPIRED pueden ser sobrescritos por lo tanto es 0, los que no son los activos y los no expirados.
--G
SELECT BEGIN_TIME,
       END_TIME,
       UNDOTSN,
       T.NAME
FROM V$UNDOSTAT U JOIN V$TABLESPACE T ON U.UNDOTSN=T.TS# WHERE ROWNUM<=20 ORDER BY BEGIN_TIME DESC;

--H
SELECT T.TABLESPACE_NAME,
       DF.BLOCKS TOTAL_BLOQUES,
       (DF.BLOCKS-SUM(E.BLOCKS)) BLOQUES_LIBRES,
       TRUNC(((DF.BLOCKS-SUM(E.BLOCKS))/DF.BLOCKS *100),2) PORCENTAJE_LIBRE FROM DBA_TABLESPACES T
    JOIN DBA_DATA_FILES DF
        ON T.TABLESPACE_NAME=DF.TABLESPACE_NAME
    JOIN DBA_UNDO_EXTENTS E
        ON T.TABLESPACE_NAME=E.TABLESPACE_NAME
WHERE T.TABLESPACE_NAME='UNDOTBS2'
GROUP BY T.TABLESPACE_NAME,DF.BYTES,DF.BLOCKS;
-- I
CONNECT VRA_TBS_MULTIPLE/VRA_TBS_MULTIPLE
DECLARE
  v_count number;
  v_username varchar2(30) := 'VRA_TBS_MULTIPLE';
  v_table varchar2(30) := 'VRA_CADENA_2';
  v_secuencia varchar2(30) :='SEC_VRA_CADENA_2';
BEGIN
  --Verificar si la table existe
  select count(*) into v_count
  from all_tables
  where table_name = v_table
  and owner = v_username;
  --Si existe la tabla, entonces se borra
  if v_count > 0 then
    execute immediate 'drop table '||v_table;
    execute immediate 'drop sequence '||v_secuencia;
  end if;
  execute immediate 'create table '||v_table||' (
    id number constraint vra_cadena_2_pk primary key,
    cadena varchar2(1024)
  ) nologging';
  execute immediate 'create sequence sec_vra_cadena_2';
end;
/
