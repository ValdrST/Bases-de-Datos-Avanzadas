--@Autor: Vicente Romero Andrade
--@Fecha creación:  08/07/2021
--@Descripción:  Script 1 del ejercicio 1 tema 5
CREATE USER VRA0501 IDENTIFIED BY VRA0501 quota unlimited on users;
GRANT CONNECT TO VRA0501;
GRANT CREATE TABLE TO VRA0501;
GRANT SELECT on vra0401.t08_random_data TO VRA0501;
grant select on v_$session to VRA0501;