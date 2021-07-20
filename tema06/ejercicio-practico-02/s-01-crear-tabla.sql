--@Autor: Vicente Romero Andrade
--@Fecha creación:  20/07/2021
--@Descripción:  Script 2 del ejercicio 2 tema 6
whenever sqlerror exit rollback
set serveroutput on
connect VRA0602/VRA0602
-- B
declare
  v_count number;
  v_username varchar2(30) := 'VRA0602';
  v_table varchar2(30) := 'EMPLEADO';
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
    nombre_completo varchar2(80) not null,
    num_cuenta varchar2(9),
    expediente clob,
    constraint pk_empleado primary key(id),
    constraint empleado_num_cuenta_uk unique(num_cuenta)
  )';
end;
/
insert into empleado(id,nombre_completo,num_cuenta,expediente) values (1,'Vicente Romero Andrade','312097792',null);
commit;
-- C
select 
       SEGMENT_NAME, 
       SEGMENT_TYPE, 
       TABLESPACE_NAME,
       BYTES,
       BLOCKS,
       EXTENTS 
    from USER_SEGMENTS 
        where SEGMENT_NAME like '%EMPLEADO%';
-- D
select
       SEGMENT_NAME,
       SEGMENT_TYPE,
       TABLESPACE_NAME,
       BYTES,
       BLOCKS,
       EXTENTS
    from USER_SEGMENTS
        where SEGMENT_NAME like '%EMPLEADO%'
          or SEGMENT_NAME in (select SEGMENT_NAME from USER_LOBS ul where ul.TABLE_NAME = 'EMPLEADO')
          or SEGMENT_NAME in (select INDEX_NAME from USER_LOBS ul where ul.TABLE_NAME = 'EMPLEADO');
whenever sqlerror continue
