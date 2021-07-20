--@Autor: Vicente Romero Andrade
--@Fecha creación:  08/07/2021
--@Descripción:  Script 3 del ejercicio 1 tema 5
whenever sqlerror exit rollback
set serveroutput on
connect sys/system2 as sysdba

declare
  v_count number;
  v_username varchar2(30) := 'VRA0501';
  v_table1 varchar2(30) := 'T02_DISPATCHER_CONFIG';
  v_table2 varchar2(30) := 'T03_DISPATCHER';
  v_table3 varchar2(30) := 'T04_SHARED_SERVER';
  v_table4 varchar2(30) := 'T05_QUEUE';
  v_table5 varchar2(30) := 'T06_VIRTUAL_CIRCUIT';
begin
  --Verificar si la table existe
  select count(*) into v_count
  from all_tables
  where table_name = v_table1
  and owner = v_username;
  --Si existe la tabla, entonces se borra
  if v_count > 0 then
    execute immediate 'drop table '|| v_username ||'.'||v_table1;
  end if;

  --Verificar si la table existe
  select count(*) into v_count
  from all_tables
  where table_name = v_table2
  and owner = v_username;
  --Si existe la tabla, entonces se borra
  if v_count > 0 then
    execute immediate 'drop table '|| v_username ||'.'||v_table2;
  end if;

  --Verificar si la table existe
  select count(*) into v_count
  from all_tables
  where table_name = v_table3
  and owner = v_username;
  --Si existe la tabla, entonces se borra
  if v_count > 0 then
    execute immediate 'drop table '|| v_username ||'.'||v_table3;
  end if;

  --Verificar si la table existe
  select count(*) into v_count
  from all_tables
  where table_name = v_table4
  and owner = v_username;
  --Si existe la tabla, entonces se borra
  if v_count > 0 then
    execute immediate 'drop table '|| v_username ||'.'||v_table4;
  end if;

  --Verificar si la table existe
  select count(*) into v_count
  from all_tables
  where table_name = v_table5
  and owner = v_username;
  --Si existe la tabla, entonces se borra
  if v_count > 0 then
    execute immediate 'drop table '|| v_username ||'.'||v_table5;
  end if;
end;
/
create table vra0501.t02_dispatcher_config as(
  select 1 as id,dispatchers,connections,sessions,
  service from v$dispatcher_config
);

create table vra0501.t03_dispatcher as(
  select 1 as id,name,network,status,messages,
  trunc(bytes/(1024*1024),2) messages_mb,
  (select count(*) from v$circuit) circuits_created, 
  trunc(idle/(60*60),2) idle_min
  from v$dispatcher
);


create table vra0501.t04_shared_server as(
  select 1 as id,name,status,messages,
  trunc(bytes/(1024*1024),2) messages_mb, 
  requests,trunc(idle/(60*60),2) idle_min,
  trunc(busy/(60*60),2) busy_min
  from v$shared_server
);

create table vra0501.t05_queue as(
  select 1 as id,queued,wait,totalq from v$queue
);

create table vra0501.t06_virtual_circuit as(
  select 1 as id,c.circuit,dp.name,c.server,c.status,c.queue
  from v$dispatcher dp join v$circuit c on( 
    dp.paddr=c.dispatcher)
);

whenever sqlerror continue
