--@Autor: Vicente Romero Andrade
--@Fecha creación:  06/03/2021
--@Descripción:  Script 2 del ejercicio 4 tema 1
set serveroutput on
connect sys/system2 as sysdba
shutdown immediate
startup
declare
v_count number;
v_username varchar2(30) := 'VRA0401';
begin
select count(*) into v_count
from all_tables
where table_name='T07_SGA_RESIZE_OPS'
and owner = v_username;
if v_count > 0 then
  execute immediate 'drop table '|| v_username ||'.'||'t07_sga_resize_ops';
end if;
execute immediate 'create table '|| v_username ||'.'||'t07_sga_resize_ops(
  component varchar(100),
  oper_type varchar(100),
  parameter varchar(100), 
  initial_size_mb number, 
  target_size_mb number,
  final_size_mb number,
  increment_mb number,
  status varchar(100), 
  start_time date,
  end_time date
)';

select count(*) into v_count
from all_tables
where table_name='T08_RANDOM_DATA'
and owner = v_username;
if v_count > 0 then
  execute immediate 'drop table '|| v_username ||'.'||'t08_random_data';  
end if;
execute immediate 'create table '|| v_username ||'.'||'t08_random_data(
  random_string varchar(1024)
)';

select count(*) into v_count
from all_tables
where table_name='T09_SGA_RESIZE_OPS'
and owner = v_username;
if v_count > 0 then
  execute immediate 'drop table '|| v_username ||'.'||'t09_sga_resize_ops';
end if;
execute immediate 'create table '|| v_username ||'.'||'t09_sga_resize_ops(
  component varchar(100),
  oper_type varchar(100),
  parameter varchar(100), 
  initial_size_mb number, 
  target_size_mb number,
  final_size_mb number,
  increment_mb number,
  status varchar(100), 
  start_time date,
  end_time date
)';
end;
/

insert into vra0401.t07_sga_resize_ops(
  component,
  oper_type,
  parameter, 
  initial_size_mb, 
  target_size_mb,
  final_size_mb,
  increment_mb,
  status, 
  start_time,
  end_time
) select
    component,
    oper_type,
    parameter,
    trunc(initial_size/1048576,2),
    trunc(target_size/1048576,2),
    trunc(final_size/1048576,2),
   trunc(final_size/1048576,2) - trunc(initial_size/1048576,2),
    status,
    start_time,
    end_time
  from
    v$sga_resize_ops order by component asc;

declare
v_rows number;
begin
v_rows := 1000*300;
for v_index in 1 .. v_rows loop
insert into vra0401.t08_random_data(random_string)
values(dbms_random.string('P',1024));
end loop;
end;
/
commit;
Prompt realizar una consulta para provocar carga de datos en BD Buffer cache
set timing on
select count(*) from vra0401.t08_random_data;
set timing off

insert into vra0401.t09_sga_resize_ops(
  component,
  oper_type,
  parameter, 
  initial_size_mb, 
  target_size_mb,
  final_size_mb,
  increment_mb,
  status, 
  start_time,
  end_time
) select
    component,
    oper_type,
    parameter,
    trunc(initial_size/1048576,2),
    trunc(target_size/1048576,2),
    trunc(final_size/1048576,2),
   trunc(final_size/1048576,2) - trunc(initial_size/1048576,2),
    status,
    start_time,
    end_time
  from
    v$sga_resize_ops order by component asc;
