--@Autor: Vicente Romero Andrade
--@Fecha Creacion: 28/07/2021
--@Descripcion: Creacion de usuarios

whenever sqlerror exit rollback
set serveroutput on 
connect sys as sysdba

create user admin_multimedia identified by Hola1234! quota unlimited on users
quota unlimited on indexesTbs quota unlimited on multimediaTbs ;

create user admin_usuario identified by Hola1234# quota unlimited on usersE2
quota unlimited on indexesTbs quota unlimited on usersTbs;

grant create session, create sequence, create table, create procedure to admin_usuario;
grant create session, create sequence, create table, create procedure to admin_multimedia;

whenever sqlerror continue