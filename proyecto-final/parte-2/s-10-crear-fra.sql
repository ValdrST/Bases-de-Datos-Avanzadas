--@Autor: Vicente Romero Andrade
--@Fecha Creacion: 30/07/2021
--@Descripcion: Creacion de la FRA
whenever sqlerror exit rollback
set serveroutput on 
connect sys/system2 as sysdba

--crear un pfile a partir de un spfile
create pfile from spfile;


/*
alter system set db_create_file_dest='/disk_7/work_recovery_area' scope=both;
 creo que esto va en RMAN
--archivelog
alter system set log_archive_dest_2='LOCATION=USE_DB_RECOVERY_FILE_DEST' scope=both;
--Online redo log
alter system set db_create_online_log_dest_1='/disk_6/flash_recovery_area' scope=both;
--control files
alter system set control_files='/disk_1/app/oracle/oradata/vraproy/control01.ctl',
    '/disk_2/app/oracle/oradata/vraproy/control02.ctl',
    '/disk_6/flash_recovery_area/control03.ctl' scope=both;
*/
alter system set db_recovery_file_dest_size=2G scope=both;
--calculando el tamaño seria: 
--1800M (tablespacecomunes) + 
--2000M(tablespacesmodulos) + 
--100M(Control) + 
--150M(Redo) + 
--200M(archive) + 
--250M(flashback)= 4500M
alter system set db_recovery_file_dest='/disk_6/app/oracle/oradata/VRAPROY/flash_recovery_area' scope=both;
alter system set db_flashback_retention_target=2880 scope=both;
--archivelog
alter system set log_archive_dest_2='LOCATION=USE_DB_RECOVERY_FILE_DEST' scope=both;
--controlfile
alter database backup controlfile to 'LOCATION=USE_DB_RECOVERY_FILE_DEST';
--Online redo log
alter system set db_create_online_log_dest_3='/disk_6/app/oracle/oradata/VRAPROY/flash_recovery_area/VRAPROY' scope=both;
alter database flashback on;

--vista
--SELECT * FROM V$RECOVERY_FILE_DEST
--SELECT * FROM V$FLASH_RECOVERY_AREA_USAGE;
--SELECT NAME FROM V$CONTROLFILE;
--SELECT * FROM V$LOGFILE;


--vista para ver el redo log
--select * from v$log;

whenever sqlerror continue