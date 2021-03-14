--@Autor: Vicente Romero Andrade
--@Fecha creacion:  06/03/2021
--@Descripcion: Muestra info de la base
CONNECT sys/system1 as sysdba;
CREATE USER vra0201 IDENTIFIED BY vra;
GRANT CREATE TABLE, connect TO vra0201;
ALTER USER vra0201 quota 100M on users;

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
    --instance_name
    (SELECT INSTANCE_NAME 
      FROM v$instance),
    --db_domain
    (SELECT value 
      FROM v$parameter 
      WHERE name='db_domain'),
    --db_charset 
    (SELECT value 
      FROM nls_database_parameters 
      WHERE PARAMETER='NLS_CHARACTERSET'),
    --sys_timestamp 
    (SELECT SYSTIMESTAMP 
      FROM DUAL),
    --timezome_offset 
    (SELECT tz_offset((SELECT sessiontimezone FROM dual))
      FROM dual),
    --db_block_size_bytes 
    (SELECT VALUE 
    FROM v$parameter 
      WHERE name = 'db_block_size'),
    --os_block_size_bytes 
    ('4096'),
    --redo_block_size_bytes
    (SELECT BLOCKSIZE 
    FROM v$log 
      WHERE GROUP#=1),
    --total_components
    (SELECT count(*) total_components
    FROM v$sysaux_occupants),
    --total_components_mb
    (SELECT 
      round(sum(SPACE_USAGE_KBYTES)/1024,2)
    FROM v$sysaux_occupants),
    --max_component_name
    (SELECT OCCUPANT_NAME 
    FROM (SELECT * 
        FROM v$sysaux_occupants 
        ORDER BY SPACE_USAGE_KBYTES DESC) 
        WHERE ROWNUM = 1),
    --max_component_desc 
    (SELECT OCCUPANT_DESC 
      FROM (SELECT * 
        FROM v$sysaux_occupants 
        ORDER BY SPACE_USAGE_KBYTES DESC) 
        WHERE ROWNUM = 1),
    --max_component_mb
    (SELECT 
      round(SPACE_USAGE_KBYTES / 1024,2)
    FROM (SELECT * 
      FROM v$sysaux_occupants 
      ORDER BY SPACE_USAGE_KBYTES DESC) 
      WHERE ROWNUM = 1)
  );

Prompt mostrando datos parte 1;
set linesize window
SELECT instance_name,db_domain,db_charset,sys_timestamp,timezome_offset 
FROM vra0201.database_info;

Prompt mostrando datos parte 2;
SELECT db_block_size_bytes,os_block_size_bytes,redo_block_size_bytes,
 total_components,total_components_mb
FROM vra0201.database_info;

Prompt mostrando datos parte 3;
SELECT max_component_name,max_component_desc,max_component_mb
FROM vra0201.database_info;

