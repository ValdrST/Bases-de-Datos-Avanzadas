--@Autor: Vicente Romero Andrade
--@Fecha creación:  20/07/2021
--@Descripción:  Script 2 del ejercicio 2 tema 6
whenever sqlerror exit rollback
set serveroutput on
connect sys@vrabda2_dedicated/system2 as sysdba
-- B
declare
  v_count number;
  v_username varchar2(30) := 'VRA0602';
  v_table varchar2(30) := 'empleado';
begin
  --Verificar si la table existe
  select count(*) into v_count
  from all_tables
  where table_name = v_table
  and owner = v_username;
  --Si existe la tabla, entonces se borra
  if v_count > 0 then
    execute immediate 'drop table '|| v_username ||'.'||v_table;
  end if;
  execute immediate 'create table '|| v_username ||'.'||v_table||'(
    id number,
    nombre_completo varchar2(80) not null,
    num_cuenta varchar(9),
    expediente clob,
    primary key(id),
    constraint num_cuenta emplado_num_cuenta_uk unique(num_cuenta)
)';
end;
/
-- C
select * from user_segments where SEGMENT_NAME like '%EMPLEADO%';
-- D
select * from user_segments us,user_LOBS ul where ul.SEGMENT_NAME=us.SEGMENT_NAME and table_name like '%EMPLEADO%';
whenever sqlerror continue
