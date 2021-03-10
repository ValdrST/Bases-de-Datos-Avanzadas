--@Autor: Vicente Romero Andrade
--@Fecha creación:  06/03/2021
--@Descripción:  Script 4 del ejercicio 4 tema 1 crear roles
CREATE USER VRA0105 IDENTIFIED BY VRA;
CREATE USER VRA0106 IDENTIFIED BY VRA;
GRANT CONNECT TO VRA0105;
GRANT CONNECT TO VRA0106;
GRANT sysdba TO VRA0104;
GRANT sysoper TO VRA0105;
GRANT sysbackup TO VRA0106;
