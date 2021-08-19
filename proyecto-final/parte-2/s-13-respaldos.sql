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

backup as backupset incremental level 0 database;
backup as backupset incremental level 1 cumulative database;

--backup database plus archivelog tag backup_total;

--VISTAS

run {
allocate channel disk1 device type disk format '/u01/copies/%u';
allocate channel disk2 device type disk format '/u02/copies/%u';
allocate channel disk3 device type disk format '/u03/copies/%u';
backup as copy database;
}
backup as copy device type disk database;

--select * from v$backup_files;
--select * from v$backup_set;
--select * from v$backup_piece;
--select * from v$rman_configuration;
