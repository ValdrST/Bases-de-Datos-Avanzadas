--@Autor: Vicente Romero Andrade
--@Fecha creación:  08/07/2021
--@Descripción:  Script 2 del ejercicio 1 tema 5
whenever sqlerror exit rollback
set serveroutput on
connect sys@vrabda2_dedicated/system2 as sysdba

declare
  v_count number;
  v_username varchar2(30) := 'VRA0501';
  v_table varchar2(30) := 'T01_SESSION_DATA';
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
    sid number,
    logon_time date,
    username varchar2(20),
    status varchar2(8),
    server varchar2(20),
    osuser varchar2(30),
    process varchar2(12),
    port number
)';
end;
/
-- A
insert into vra0501.t01_session_data(
id,sid,logon_time,username,status,server,
osuser,process,port)
select 1,sid,logon_time,username,status,server,
    osuser,process,port from v$session where username = 'SYS';
commit;
--B
connect sys@vrabda2_shared/system2 as sysdba

insert into vra0501.t01_session_data(
id,sid,logon_time,username,status,server,
osuser, process,port) 
select 2,sid,logon_time,username,status,server,
    osuser, process,port from v$session where username = 'SYS';
commit;

--C
connect VRA0501@vrabda2_dedicated/VRA0501

insert into vra0501.t01_session_data(
id,sid,logon_time,username,status,server,
osuser, process,port) 
select 3,sid,logon_time,username,status,server,
    osuser, process,port from v$session where username = 'VRA0501';
commit;

--D
connect VRA0501@vrabda2_shared/VRA0501

insert into vra0501.t01_session_data(
id,sid,logon_time,username,status,server,
osuser, process,port) 
select 4,sid,logon_time,username,status,server,
    osuser, process,port from v$session where username = 'VRA0501';
commit;

whenever sqlerror continue
