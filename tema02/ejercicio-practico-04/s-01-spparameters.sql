--@Autor: Vicente Romero Andrade
--@Fecha creacion: 28/03/2021
--@Descripcion: Crea bd
connect sys/system2 as sysdba
create pfile='/unam-bda/ejercicios-practicos/t0204/e-02-spparameter-pfile.txt' from spfile;
create user vra0204 IDENTIFIED by vra0204 quota unlimited on users;
GRANT create session, connect, create procedure, create table to vra0204;
create or replace procedure DROP_IF_CREATE(nombreUsuario in varchar2, nombreTabla IN varchar2)
IS
  c number;
begin
  select count(*) into c
    from all_tables
  where table_name = upper(nombreTabla);
  if c > 0 then
    execute immediate 'drop table '||nombreUsuario||'.'||nombreTabla;
  end if;
end DROP_IF_CREATE;
/
execute DROP_IF_CREATE('vra0204','t01_spparameters');

CREATE TABLE vra0204.t01_spparameters as 
  select name,value FROM v$spparameter
      where VALUE is not null;
/**
Sección de preguntas y respuestas:
1. Observar que los parámetros mostrados en el archivo e-02-spparameter-pfile.txt 
tienen 2 formatos: algunos inician con <oracle_sid>.__ y otro grupo inicia con *.
¿Qué diferencia existe entre estos 2 grupos?
Respuesta: 
Los que inician con <oracle_sid>.__ son parametros que existen solo en la sesion,
por lo que son dinámicos y no es recomedable persistirlos en el pfile. Los que 
inician con *. son los parametros que se definen a nivel sistema y siempre aplicaran
en todas las sesiones existentes.
==========
2. Comparar los 2 archivos e-01-spparameter-alert-log.txt y e-02-spparameter-pfile.txt 
así como el contenido de la tabla t01_spparameters. Confirmar que en los 3 casos, 
existen los mismos parámetros con los mismos valores. 
 De encontrar diferencias mencionarlas.
Respuesta:
En el archivo alert log se muestran los parametros tal cual estan durante la creación de la 
base de datos. El archivo de e-02-spparameter-pfile.txt es la representación textual del archivo
sppfile ya durante una sesion creada por lo que este contendra tanto parametros de sistema como 
de sesión. El contenido de la tabla es mas similar al archivo de alert-log ya que este solo 
almacena los parametros de sistema que tiene el spfile.
==========
*/
