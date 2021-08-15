--@Autor: Vicente Romero Andrade
--@Fecha Creacion: 09/08/2021
--@Descripcion: Ejecución de respaldos

rman target sysbackup/system2

--politica de retencion

configure retention policy to recovery window of 7 days;
--Configura los archive logs
configure archivelog deletion policy
to backed up 2 times to disk;
--backup type to compressed backupset;
configure backup optimization on;
configure channel device type disk format '/disk_7/app/oracle/oradata/VRAPROY/backups/ora_df_%U';

backup database plus archivelog format "/disk_7/app/oracle/oradata/VRAPROY/backups/arch_%U";

backup as backupset incremental level 0 database plus archivelog;
backup as backupset incremental level 1 cumulative database plus archivelog;

--backup database plus archivelog tag backup_total;

--VISTAS

--select * from v$backup_files;
--select * from v$backup_set;
--select * from v$backup_piece;
--select * from v$rman_configuration;
