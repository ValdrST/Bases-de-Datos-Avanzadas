--@Autor: Vicente Romero Andrade
--@Fecha creacion: 28/03/2021
--@Descripcion: Otros parametros
connect sys/system2 as sysdba
execute DROP_IF_CREATE('vra0204','t02_other_parameters');
CREATE TABLE vra0204.t02_other_parameters(
  num number(10),
  name varchar2(100),
  value varchar2(200),
  display_value varchar2(200),
  default_value varchar2(50),
  is_session_modifiable varchar2(10),
  is_system_modifiable varchar2(10)
);
INSERT INTO vra0204.t02_other_parameters(
  num,
  name,
  value,
  display_value,
  default_value,
  is_session_modifiable,
  is_system_modifiable
)
(SELECT 
    NUM,
    NAME, 
    VALUE, 
    DISPLAY_VALUE, 
    DEFAULT_VALUE,
    ISSES_MODIFIABLE,
    ISSYS_MODIFIABLE
  FROM v$system_parameter);
