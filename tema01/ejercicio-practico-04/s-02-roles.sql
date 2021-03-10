--@Autor: Vicente Romero Andrade
--@Fecha creación:  06/03/2021
--@Descripción:  Script 2 del ejercicio 4 tema 1 crear roles
SELECT ROLE_ID, ROLE FROM DBA_ROLES;
CREATE TABLE  VRA0104.t02_db_roles(
  role_id  number,
  role  varchar2(128)
);

INSERT INTO VRA0104.t02_db_roles(
    role_id,
    role
  ) SELECT 
    ROLE_ID, 
    ROLE 
  FROM CDB_ROLES;

CREATE TABLE VRA0104.t03_dba_privs(
  privilege varchar2(128)
);
INSERT INTO VRA0104.t03_dba_privs(
    privilege
  )
SELECT PRIVILEGE FROM 
  ROLE_SYS_PRIVS 
  WHERE ROLE = 'DBA';
