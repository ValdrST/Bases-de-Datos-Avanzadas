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
DECLARE
  v_count number;
  v_count_s number;
  v_username varchar2(30) := 'VRA_TBS_MULTIPLE';
  v_table varchar2(30) := 'VRA_CADENA_2';
  v_secuencia varchar2(30) :='SEC_VRA_CADENA_2';
BEGIN
  --Verificar si la table existe
  select count(*) into v_count
  from all_tables
  where table_name = v_table
  and owner = v_username;

  --Verificar si la secuencia existe
  select count(*) into v_count_s
    from all_sequences
  where sequence_name = v_secuencia
    and sequence_owner = v_username;
  --Si existe la tabla, entonces se borra
  if v_count > 0 then
    execute immediate 'drop table '||v_username||'.'||v_table;
  end if;
  if v_count_s > 0 then
    execute immediate 'drop sequence '||v_username||'.'||v_secuencia;
  end if;
  execute immediate 'create table '||v_username||'.'||v_table||' (
    id number constraint vra_cadena_2_pk primary key,
    cadena varchar2(1024)
  ) nologging';
  execute immediate 'create sequence '||v_username||'.'||v_secuencia;
end;
/
-- Inserts
declare
  v_rows number;
  v_stmt varchar2(200);
  v_username varchar2(30) := 'VRA_TBS_MULTIPLE';
  v_table varchar2(30) := 'VRA_CADENA_2';
  v_secuencia varchar2(30) :='SEC_VRA_CADENA_2';
begin
v_rows := 50000;
v_stmt := 'insert into '||v_username||'.'||v_table||'(
  id, cadena
  ) values (:1, :2)';
for v_index in 1 .. v_rows loop
  execute immediate v_stmt using SEC_VRA_CADENA_2.nextval, dbms_random.string('P',1024);
end loop;
end;
/
commit;
-- I
declare
  v_stmt varchar2(200);
  v_username varchar2(30) := 'VRA_TBS_MULTIPLE';
  v_table varchar2(30) := 'VRA_CADENA_2';
begin
  v_stmt := 'delete from '||v_username||'.'||v_table||'
    where id in (SELECT id from '||v_username||'.'||v_table||' WHERE ROWNUM<=5000)';
  execute immediate v_stmt;
end;
/
commit;

-- 1 - 5000 | 835 | 138 | 160 | 9835
-- 5001 - 10000 | 1669 | 144 | 160 | 1896
-- 10001 - 15000 | 835 | 12 | 160 | 1741
-- 15001 - 20000 | Error
--L
-- 11 para la primera
--M
connect VRA_TBS_MULTIPLE/VRA_TBS_MULTIPLE
set transaction isolation level serializable name 'T1-RC';
declare
  v_rows number;
  v_stmt varchar2(200);
  v_username varchar2(30) := 'VRA_TBS_MULTIPLE';
  v_table varchar2(30) := 'VRA_CADENA_2';
begin
  v_rows := 10;
  v_stmt := 'delete from '||v_username||'.'||v_table||'
    where id in (SELECT id from '||v_username||'.'||v_table||' WHERE ROWNUM<=5000)';
  execute immediate v_stmt;  
end;
/
commit;
