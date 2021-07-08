--@Autor: Vicente Romero Andrade
--@Fecha creación:  06/03/2021
--@Descripción:  Script 2 del ejercicio 4 tema 1
set serveroutput on
connect sys/system2 as sysdba
shutdown
startup
declare
v_count number;
v_username varchar2(30) := 'VRA0401';
begin
select count(*) into v_count
from all_tables
where table_name='T07_SGA_RESIZE_OPS'
and owner = v_username;
if v_count = 0 then
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
end if;
select count(*) into v_count
from all_tables
where table_name='T08_RANDOM_DATA'
and owner = v_username;
if v_count = 0 then
  execute immediate 'create table '|| v_username ||'.'||'t08_random_data(
    random_string varchar(1024)
  )';
end if;
end;
/
insert into vra0401.t08_random_data(
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
  ) 
  values (
    (select trunc(value/1048576,2) from v$parameter where name='memory_target'),
    (select trunc(value/1048576,2) from v$sga where name = 'Fixed Size'),
    (select trunc(value/1048576,2) from v$sga where name = 'Variable Size'),
    (select trunc(value/1048576,2) from v$sga where name = 'Database Buffers'),
    (select trunc(value/1048576,2) from v$sga where name = 'Redo Buffers'),
    (select SUM(trunc(value/1048576,2)) from v$sga)
  );