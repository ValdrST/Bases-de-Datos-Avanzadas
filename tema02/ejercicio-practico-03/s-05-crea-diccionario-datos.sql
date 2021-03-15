--@Autor: Vicente Romero Andrade
--@Fecha creacion: 14/03/2021
--@Descripcion: Crea diccionario de datos
whenever sqlerror exit rollback;
set serveroutput on

connect sys/system2 as sysdba

@?/rdbms/admin/catalog.sql
@?/rdbms/admin/catproc.sql
@?/rdbms/admin/utlrp.sql


connect system/system2 

@?/sqlplus/admin/pupbld.sql


whenever sqlerror continue none
disconnect
