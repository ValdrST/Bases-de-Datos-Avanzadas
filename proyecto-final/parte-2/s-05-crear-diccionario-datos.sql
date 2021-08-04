--@Autor: Vicente Romero Andrade
--@Fecha creacion: 28/07/2021
--@Descripcion: Creación del diccionario de datos

connect sys/system2 as sysdba
Prompt Conectando como sys
set serveroutput on

whenever sqlerror exit rollback;
 
Prompt Ejecucion de scripts como usuario sys
@?/rdbms/admin/catalog.sql
@?/rdbms/admin/catproc.sql
@?/rdbms/admin/utlrp.sql

connect system/system2 
Prompt Conectando como system 
@?/sqlplus/admin/pupbld.sql
