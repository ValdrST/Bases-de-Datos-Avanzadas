--@Autor: Vicente Romero Andrade
--@Fecha creacion: 14/03/2021
--@Descripcion: Crea spfile
connect sys/hola1234* as sysdba
startup
create spfile from pfile;
!ls $ORACLE_HOME/dbs/spfilevrabda2.ora