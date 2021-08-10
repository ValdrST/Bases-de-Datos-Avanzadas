--@Autor: Vicente Romero Andrade
--@Fecha Creacion: 09/08/2021
--@Descripcion: Ejecución de respaldos

rman target sys @offline_full_whole.rman

--politica de retencion

configure retention policy to recovery window of 7 days;  --1
--Configura los archive logs
configure archivelog deletion policy
to backed up 2 times to disk;
--backup type to compressed backupset;
configure backup optimization on;
configure channel device type disk format '/disk_7/app/oracle/oradata/VRAPROY/backups/ora_df%t_s%s_s%p';

backup database format "/disk_7/app/oracle/oradata/VRAPROY/backups/arch-D_%d-id-%I_S-%e_T-%h_A-%a_%u";
backup database format "/disk_7/app/oracle/oradata/VRAPROY/backups/cf-D_%d-id-%I_%u";

backup as backupset incremental level 0 database;
backup as backupset incremental level 1 cumulative database;

--backup database plus archivelog tag backup_total;

--VISTAS

--select * from v$backup_files;
--select * from v$backup_set;
--select * from v$backup_piece;
--select * from v$rman_configuration;
