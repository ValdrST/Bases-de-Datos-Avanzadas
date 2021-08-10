--@Autor: Vicente Romero Andrade
--@Fecha Creacion: 09/08/2021
--@Descripcion: Poner base en modo archivelog
whenever sqlerror exit rollback
set serveroutput on 
connect sys as sysdba
shutdown
--respaldar el spfile
create pfile from spfile;
startup mount
alter system set log_archive_max_processes = 4 scope=both;
alter system set log_archive_trace=12 scope=both;
alter system set log_archive_dest='LOCATION=/disk_6/app/oracle/oradata/VRAPROY/arch' scope=both;
alter system set log_archive_dest_2='LOCATION=USE_DB_RECOVERY_FILE_DEST' scope=both;
alter system set log_archive_format = 'arch_vraproy_%t_%s_%r.arc' scope=spfile;
alter system set log_archive_min_succeed_dest=1 scope=both;

shutdown
startup mount
alter database archivelog;
alter database open;

archive log list
--select * from v$database;
--select * from v$archived_log;
--select * from v$archive_dest;

whenever sqlerror continue

