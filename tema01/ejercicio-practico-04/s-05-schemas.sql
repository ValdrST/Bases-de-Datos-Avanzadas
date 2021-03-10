--@Autor: Vicente Romero Andrade
--@Fecha creación:  06/03/2021
--@Descripción:  Script 5 del ejercicio 4 tema 1 ESQUEMAS DE LOS PRIVILEGIOS DE ADMINISTRACIÓN.
CONNECT VRA0104/VRA0104
create table t04_my_schema (
  username varchar2(128),
  schema_name varchar2(128)
);

GRANT INSERT ON VRA0104.t04_my_schema to sys;
GRANT INSERT ON VRA0104.t04_my_schema to public;
GRANT INSERT ON VRA0104.t04_my_schema to sysbackup;
  

CONNECT VRA0104/VRA0104 as sysdba;
INSERT INTO VRA0104.t04_my_schema(
  username,
  schema_name
) select 
  sys_context('USERENV', 'SESSION_USER') usuario, 
  sys_context('USERENV', 'CURRENT_SCHEMA') esquema 
  from dual;

CONNECT VRA0105/VRA as sysoper;
INSERT INTO VRA0104.t04_my_schema(
  username,
  schema_name
) select 
  sys_context('USERENV', 'SESSION_USER') usuario, 
  sys_context('USERENV', 'CURRENT_SCHEMA') esquema 
  from dual;

CONNECT VRA0106/VRA as sysbackup;
INSERT INTO VRA0104.t04_my_schema(
  username,
  schema_name
) select 
  sys_context('USERENV', 'SESSION_USER') usuario, 
  sys_context('USERENV', 'CURRENT_SCHEMA') esquema 
  from dual;
commit;
connect sys/hola1234# as sysdba

select username, sysdba, sysoper, sysbackup, last_login
from v$pwfile_users;
alter user sys identified by system1;
