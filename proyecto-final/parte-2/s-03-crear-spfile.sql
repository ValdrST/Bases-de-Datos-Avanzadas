--@Autor : Vicente Romero Andrade
--@Fecha creacion : 28/07/2021
--@Descripcion : Creación del archivo spfile

connect sys/system2 as sysdba
Prompt Conectando como sys
whenever sqlerror exit rollback;
set serveroutput on

startup nomount
create spfile from pfile;
Prompt Verificando el nomount
!ls $ORACLE_HOME/dbs/spfilevraproy.ora
/
whenever sqlerror continue none