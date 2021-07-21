--@Autor: Vicente Romero Andrade
--@Fecha creación:  20/07/2021
--@Descripción:  Script 1 del ejercicio 6 tema 6
whenever sqlerror continue
set serveroutput on
connect store_user/store_user
--A
declare
  v_count number;
  v_username varchar2(30) := 'STORE_USER';
  v_table varchar2(30) := 'TEST';
begin
  --Verificar si la table existe
  select count(*) into v_count
  from all_tables
  where table_name = v_table
  and owner = v_username;
  --Si existe la tabla, entonces se borra
  if v_count > 0 then
    execute immediate 'drop table '||v_table;
  end if;
  execute immediate 'create table '||v_table||' (
    id number,
    nombre varchar(200),
    apellido varchar(200)
  ) segment creation deferred';
end;
/

--B
declare
  v_count number := 0;
begin
  --Verificar si la table existe
  while true loop
  v_count := v_count + 1;
  insert into test(id,nombre,apellido) values(v_count,'nombre random','apellido random');
  commit;
  end loop;
end;
/
select
  count(SEGMENT_NAME) NUMERO_EXTENSIONES,
  trunc(SUM(BYTES)/(1024*1024),2) ALLOCATED_MB
from USER_EXTENTS;
--C
connect sys/system2 as sysdba
alter tablespace store_tbs1
add datafile '/u01/app/oracle/oradata/VRABDA2/store_tbs02.dbf' size 5M;
--D
connect store_user/store_user
declare
  v_count number := 0;
begin
  --Verificar si la table existe
  while true loop
    v_count := v_count + 1;
    insert into test(id,nombre,apellido) values(v_count,'nombre random','apellido random');
    commit;
  end loop;
end;
/
select 
  count(SEGMENT_NAME) NUMERO_EXTENSIONES,
  trunc(SUM(BYTES)/(1024*1024),2) ALLOCATED_MB
from USER_EXTENTS;
--E
SELECT distinct t.TABLESPACE_NAME nombre, count(s.TABLESPACE_NAME) numero_segmentos FROM DBA_TABLESPACES t
  left JOIN DBA_SEGMENTS s on t.TABLESPACE_NAME=s.TABLESPACE_NAME
  group by t.TABLESPACE_NAME order by numero_segmentos desc;
whenever sqlerror continue
