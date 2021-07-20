--@Autor: Vicente Romero Andrade
--@Fecha creación:  08/07/2021
--@Descripción:  Script 4 del ejercicio 1 tema 5
whenever sqlerror exit rollback
set serveroutput on
connect sys/system2 as sysdba

declare
  v_count number;
  v_username varchar2(30) := 'VRA0501';
  v_table1 varchar2(30) := 'T07_SESSION_INFO_CONTEXT';
  v_table2 varchar2(30) := 'T08_SESSION_INFO_VIEW';
  v_table3 varchar2(30) := 'T09_PROCESS_INFO';
  v_table4 varchar2(30) := 'T10_BACKGROUND_PROCESS';
  v_table5 varchar2(30) := 'T11_FOREGROUND_PROCESS';
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
create table vra0501.t07_session_info_context(
    host varchar2(20),
    os_user varchar2(30),
    user_id number,
    session_id number
);

insert into vra0501.t07_session_info_context(host, os_user, user_id,session_id)
    select sys_context('USERENV','HOST') as host,
    sys_context('USERENV','OS_USER') as os_user,
    sys_context('USERENV', 'SESSION_USERID') as user_id,
    sys_context('USERENV','SID') as session_id
    from dual;

create table vra0501.t08_session_info_view as(
  select s.sid as session_id,s.paddr as process_address,
  s.username bd_username,s.status as session_status,
  s.port as client_port,s.process as os_client_process_id, 
  s.program as client_program from v$process p 
  join gv$session s on p.addr=s.paddr 
  join (select sys_context('USERENV','SID') as session_id
  from dual) c on c.session_id=s.sid where s.username = 'SYS'
);

create table vra0501.t09_process_info as(
    select sosid,pname,background, tracefile from v$process
	join gv$session s on addr=s.paddr join ( 
    select sys_context('USERENV','SID') as session_id
    from dual) c on s.sid = c.session_id 
);

create table vra0501.t10_background_process as(
    select addr, sosid, pname,username as os_username, background 
    from v$process where background='1'
);

create table vra0501.t11_foreground_process as(
    select p.addr, p.sosid, p.pname, p.username as bd_username, s.osuser as os_username, p.background 
    from v$process p left outer join v$session s 
    on(p.addr=s.paddr) where p.background is null
);

whenever sqlerror continue
