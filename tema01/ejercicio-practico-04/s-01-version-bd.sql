--@Autor: Vicente Romero Andrade
--@Fecha creación:  06/03/2021
--@Descripción:  Script 1 del ejercicio 4 tema 1
CREATE USER VRA0104 IDENTIFIED BY VRA0104 quota unlimited on users;
GRANT CONNECT TO VRA0104;
GRANT CREATE TABLE TO VRA0104;
CREATE TABLE VRA0104.t01_db_version(
  product varchar2(100),
  version varchar2(50),
  version_full varchar2(50)
);
insert into VRA0104.t01_db_version(
    product,
    version,
    version_full
  ) SELECT 
    product,
    version,
    version_full 
  FROM PRODUCT_COMPONENT_VERSION;
