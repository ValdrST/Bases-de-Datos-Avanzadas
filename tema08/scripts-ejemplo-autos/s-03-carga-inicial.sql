--@Autor:           Jorge Rodriguez
--@Fecha creación:  dd/mm/yyyy
--@Descripción:     Archivo principal

--si ocurre un error, se hace rollback de los datos y
--se sale de SQL *Plus
whenever  sqlerror exit rollback

Prompt creando usuario jrc_autos_bda
connect jrc_autos_bda/jorge

set define off

Prompt realizando la carga de datos
@s-04-agencia.sql
@s-04-cliente.sql
@s-04-tarjeta-cliente.sql
@s-04-status-auto.sql
@s-04-auto.sql
@s-04-auto-carga.sql
@s-04-auto-particular.sql
@s-04-historico-status-auto.sql
@s-04-pago-auto.sql

set define on

Prompt confirmando cambios
commit;

--Si se encuentra un error, no se sale de SQL *Plus
--no se hace commit ni rollback, es decir, se
--regresa al estado original.
whenever sqlerror continue none

Prompt Listo!
