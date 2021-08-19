--@Autor: Vicente Romero Andrade
--@Fecha Creacion: 30/07/2021
--@Descripcion: Creacion de la FRA
whenever sqlerror exit rollback
set serveroutput on 
connect sys/system2 as sysdba

--crear un pfile a partir de un spfile
create pfile from spfile;

alter system set db_recovery_file_dest_size=2G scope=both;
--calculando el tamano seria: 
--761M (datafiles)
--18M(Control) + 
--50M(archive) + 
--250M(flashback)= 879M
alter system set db_recovery_file_dest='/disk_6/app/oracle/oradata/VRAPROY/flash_recovery_area' scope=both;
alter system set db_flashback_retention_target=2880 scope=both;
--archivelog
alter system set log_archive_dest_2='LOCATION=USE_DB_RECOVERY_FILE_DEST' scope=both;
--controlfile
alter database backup controlfile to 'LOCATION=USE_DB_RECOVERY_FILE_DEST';
alter database flashback on;

whenever sqlerror continue