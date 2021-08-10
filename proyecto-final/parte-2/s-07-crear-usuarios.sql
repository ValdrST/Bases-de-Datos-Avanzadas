--@Autor: Vicente Romero Andrade
--@Fecha Creacion: 30/07/2021
--@Descripcion: Creacion de usuarios

whenever sqlerror exit rollback
set serveroutput on 
connect sys/system2 as sysdba

drop user admin_multimedia;
create user admin_multimedia identified by "Hola1234#"
quota unlimited on multimediaTbs
default tablespace multimediaTbs;

alter user admin_multimedia
quota unlimited on indexesTbs
quota unlimited on multimediaObjTbs;

drop user admin_usuario;
create user admin_usuario identified by "Hola1234#"
quota unlimited on usersTbs
default tablespace usersTbs;

alter user admin_usuario
quota unlimited on usersPayTbs
quota unlimited on indexesTbs;

grant
 create session, 
 create sequence, 
 create table, 
 create procedure 
to admin_usuario;

grant 
 create session, 
 create sequence, 
 create table, 
 create procedure 
to admin_multimedia;

grant select on usersTbs to admin_multimedia;

whenever sqlerror continue
