--@Autor: Vicente Romero Andrade
--@Fecha Creacion: 30/07/2021
--@Descripcion: Modos de conexion

whenever sqlerror exit rollback
set serveroutput on 
connect sys/system2 as sysdba

alter system set dispatchers='(dispatchers=2)(protocol=tcp)' scope=both;
alter system set shared_servers=4 scope=both;
alter system register;

!lsnrctl services

whenever sqlerror continue
-- select * from v$session;