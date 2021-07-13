--@Autor: Vicente Romero Andrade
--@Fecha creación:  08/07/2021
--@Descripción:  Script 2 del ejercicio 1 tema 5
whenever sqlerror exit rollback
set serveroutput on
connect sys/system2 as sysdba
-- A
alter system set dispatchers='(dispatchers=2)(PROTOCOL=tcp)' scope=memory;
alter system set shared_servers=4 scope=memory;
show parameter;
--B
alter system register;
--C
select program,pid,pname 
  from v$process 
    where pname like'S0%' or pname like 'D0%' 
    order by program;
    
whenever sqlerror continue