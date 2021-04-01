--@Autor: Vicente Romero Andrade
--@Fecha creacion: 28/03/2021
--@Descripcion: Modifica parametros
connect sys/system2 as sysdba
set serveroutput on
create or replace procedure DROP_IF_CREATE(nombreUsuario in varchar2, nombreTabla IN varchar2)
IS
  c number;
begin
  select count(*) into c
    from all_tables
  where table_name = upper(nombreTabla);
  if c > 0 then
    execute immediate 'drop table '||nombreUsuario||'.'||nombreTabla;
  end if;
end DROP_IF_CREATE;
/

alter session set nls_date_format = 'dd/mm/yyyy hh24:mi:ss';
alter system set db_writer_processes = 2 scope=spfile;
alter system set log_buffer = 10485760 scope=spfile;
alter system set db_files = 250 scope=spfile;
alter system set dml_locks = 2500 scope=spfile;
alter system set transactions = 600 scope=spfile;
alter session set hash_area_size = 2097152;
alter system set hash_area_size = 2097152 scope=spfile;
alter session set sort_area_size = 1048576;
alter system set sql_trace = true scope=memory;
alter system set optimizer_mode = FIRST_ROWS_100 scope=both;
alter session set cursor_invalidation = deferred;



execute DROP_IF_CREATE('vra0204','t03_update_param_session');
execute DROP_IF_CREATE('vra0204','t04_update_param_instance');
execute DROP_IF_CREATE('vra0204','t05_update_param_spfile');

create table vra0204.t03_update_param_session as
select name,value
from v$parameter
where name in (
'cursor_invalidation','optimizer_mode',
'sql_trace','sort_area_size','hash_area_size','nls_date_format',
'db_writer_processes','db_files','dml_locks','log_buffer','transactions'
)
and value is not null;

create table vra0204.t04_update_param_instance as
select name,value
from v$system_parameter
where name in (
'cursor_invalidation','optimizer_mode',
'sql_trace','sort_area_size','hash_area_size','nls_date_format',
'db_writer_processes','db_files','dml_locks','log_buffer','transactions'
)
and value is not null;

create table vra0204.t05_update_param_spfile as
select name,value
from v$spparameter
where name in (
'cursor_invalidation','optimizer_mode',
'sql_trace','sort_area_size','hash_area_size','nls_date_format',
'db_writer_processes','db_files','dml_locks','log_buffer','transactions'
)
and value is not null;

create pfile='/unam-bda/ejercicios-practicos/t0204/e-03-spparameter-pfile.txt' from spfile;
