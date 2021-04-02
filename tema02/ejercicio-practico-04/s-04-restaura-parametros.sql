--@Autor: Vicente Romero Andrade
--@Fecha creacion: 28/03/2021
--@Descripcion: Restaura parametros
connect sys/system2 as sysdba
shutdown immediate

create spfile from 
  pfile='/unam-bda/ejercicios-practicos/t0204/e-02-spparameter-pfile.txt';

startup
