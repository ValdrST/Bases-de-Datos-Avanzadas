--@Autor: Vicente Romero Andrade
--@Fecha creación:  16/06/2021
--@Descripción:  Script 1 del ejercicio 1 tema 4

create table vra0401.t01_sga_components(
  memory_target_param number,
  fixed_size number,
  variable_size number, 
  database_buffers number, 
  redo_buffers number,
  total_sga number
);

insert into ale0401.t01_sga_components(
  memory_target_param,
  fixed_size, 
  variable_size, 
  database_buffers, 
  redo_buffers, 
  total_sga
  ) 
  values (
    (select trunc(value/1048576,2) from v$parameter where name='memory_target'),
    (select trunc(value/1048576,2) from v$sga where name = 'Fixed Size'),
    (select trunc(value/1048576,2) from v$sga where name = 'Variable Size'),
    (select trunc(value/1048576,2) from v$sga where name = 'Database Buffers'),
    (select trunc(value/1048576,2) from v$sga where name = 'Redo Buffers'),
    (select SUM(trunc(value/1048576,2)) from v$sga)
  );

create table vra0401.t02_sga_dynamic_components(
  component_name varchar2(64),
  current_size_mb number(10,2),
  operation_count number(10,0),
  last_operation_type varchar2(13),
  last_operation_time date
);
insert into vra0401.t02_sga_dynamic_components(
    component_name,
    current_size_mb,
    operation_count,
    last_operation_type,
    last_operation_time 
) select component,trunc(current_size/1048576,2), oper_count, last_oper_type, last_oper_time
    from 
    v$sga_dynamic_components;

create table vra0401.t03_sga_max_dynamic_component(
component_name varchar2(64),
current_size_mb number(10,2)
);
insert into vra0401.t03_sga_max_dynamic_component(
    component_name,
    current_size_mb)
    select component, trunc(current_size/1048576,2)
    from 
    v$sga_dynamic_components where current_size = (select max(current_size) from v$sga_dynamic_components);

create table vra0401.t04_sga_min_dynamic_component(
component_name varchar2(64),
current_size_mb number(10,2)
);
insert into vra0401.t04_sga_min_dynamic_component(
    component_name,
    current_size_mb)
  values (
    select component, trunc(current_size/1048576,2)
    from 
    v$sga_dynamic_components where current_size = (
    select min(current_size) from v$sga_dynamic_components where current_size > 0)
  );

create table vra0401.t05_sga_memory_info(
name varchar2(64),
current_size_mb number(10,2)
);
insert into vra0401.t05_sga_memory_info(
    name,
    current_size_mb
    ) 
  values (
    select name, trunc(bytes/1048576,2)  
    from v$sgainfo where name = 'Maximum SGA Size'
  );
insert into vra0401.t05_sga_memory_info(
    name,
    current_size_mb
  ) 
  values
  (
    select name, trunc(bytes/1048576,2)  
    from v$sgainfo where name = 'Free SGA Memory Available'
  );
    

create table vra0401.t06_sga_resizeable_components(
name varchar2(64)
);

insert into vra0401.t06_sga_resizeable_components(name)
  values(
    select name from v$sgainfo
        where resizeable = 'Yes'
);
