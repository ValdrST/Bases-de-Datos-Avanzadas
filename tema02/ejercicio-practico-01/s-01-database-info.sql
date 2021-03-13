--@Autor: Vicente Romero Andrade
--@Fecha creación:  06/03/2021
--@Descripción:  Script 1 del ejercicio 1 tema 2.
CONNECT sys/system1 as sysdba;
CREATE USER vra0201 IDENTIFIED BY VRA;

create table vra0201.database_info(
  instance_name varchar2(16),
  db_domain varchar2(20),
  db_charset varchar2(15),
  sys_timestamp varchar2(40),
  timezome_offset varchar2(10),
  db_block_size_bytes number(5,0),
  os_block_size_bytes number(5,0),
  redo_block_size_bytes number(5,0),
  total_components number(5,0),
  total_components_mb number(10,2),
  max_component_name varchar2(30),
  max_component_desc varchar2(64),
  max_component_mb number(10,0)
);
INSERT INTO vra0201.database_info(
  instance_name,
  db_domain,
  db_charset,
  sys_timestamp,
  timezome_offset,
  db_block_size_bytes,
  os_block_size_bytes,
  redo_block_size_bytes,
  total_components,
  total_components_mb,
  max_component_name,
  max_component_desc,
  max_component_mb
) VALUES
  (
    (SELECT INSTANCE_NAME 
      FROM v$instance),
    (SELECT value 
      FROM v$parameter 
      WHERE name='db_domain'),
    (SELECT value 
      FROM nls_database_parameters 
      WHERE PARAMETER='NLS_CHARACTERSET'),
    (SELECT SYSTIMESTAMP 
      FROM DUAL),
    (SELECT tz_offset((SELECT sessiontimezone FROM dual)) 
      FROM dual),
    (SELECT VALUE 
      FROM v$parameter 
      WHERE name = 'db_block_size'),
    (4096),
    (SELECT BLOCKSIZE 
      FROM v$log 
      WHERE GROUP#=1),
    (SELECT count(*) total_components
      FROM v$sysaux_occupants),
    (SELECT round(sum(SPACE_USAGE_KBYTES),2) total_components_mb 
      FROM v$sysaux_occupants),
    ()
  )