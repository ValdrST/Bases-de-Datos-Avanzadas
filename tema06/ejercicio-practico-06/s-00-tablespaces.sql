--@Autor: Vicente Romero Andrade
--@Fecha creación:  20/07/2021
--@Descripción:  Script 1 del ejercicio 6 tema 6
whenever sqlerror exit rollback
set serveroutput on
connect store_user/store_user
--A
create table test(
  id number
)
segment creation deferred;
--B
declare
  v_count number:=0;
begin
  --Verificar si la table existe
  v_count := v_count + 1;
  while true loop
  insert into test(id) values(v_count);
  end loop
end;
/

whenever sqlerror continue
