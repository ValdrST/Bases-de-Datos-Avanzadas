--@Autor: Vicente Romero Andrade
--@Fecha Creacion: 10/08/2021
--@Descripcion: Ejecución de carga de datos
whenever sqlerror continue

connect sys/system2 as sysdba
-- Desactiva redo
--shutdown immediate
--startup mount
--Alter database noarchivelog;
--alter database open;

--carga plan suscripción
declare
  v_rows number;
  v_stmt varchar2(200);
  v_username varchar2(30) := 'ADMIN_USUARIO';
  v_table varchar2(30) := 'PLAN_SUSCRIPCION';
begin
v_rows := 2000;
v_stmt := 'insert into '||v_username||'.'||v_table||'(
  plan_suscripcion_id, clave, nombre, descripcion, costo
  ) values (:1, :2, :3, :4, :5)';
for v_index in 1 .. v_rows loop
  execute immediate v_stmt using v_index,
  dbms_random.string('P',10), 
  dbms_random.string('P',60),
  dbms_random.string('P',200),
  dbms_random.value(1,100000)
  ;
end loop;
end;
/

--carga costo vigente historico
declare
  v_rows number;
  v_stmt varchar2(200);
  v_username varchar2(30) := 'ADMIN_USUARIO';
  v_table varchar2(30) := 'COSTO_VIGENTE_HISTORICO';
begin
v_rows := 2000;
v_stmt := 'insert into '||v_username||'.'||v_table||'(
  COSTO_VIGENTE_HISTORICO_id, costo, fecha_inicio, fecha_fin, plan_suscripcion_id
  ) values (:1, :2, :3, :4, :5)';
for v_index in 1 .. v_rows loop
  execute immediate v_stmt using v_index,
  dbms_random.value(1,100000),
  TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2021-05-01','J'),TO_CHAR(DATE '2021-05-31','J'))),'J'),
  TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2021-06-01','J'),TO_CHAR(DATE '2021-06-30','J'))),'J'),
  v_index
  ;
end loop;
end;
/
--select count(*) from ADMIN_USUARIO.COSTO_VIGENTE_HISTORICO;


--carga usuario
declare
  v_rows number;
  v_stmt varchar2(200);
  v_username varchar2(30) := 'ADMIN_USUARIO';
  v_table varchar2(30) := 'USUARIO';
begin
v_rows := 2000;
v_stmt := 'insert into '||v_username||'.'||v_table||'(
  usuario_id, username, password, email, nombre, apellidos, rfc, plan_suscripcion_id
  ) values (:1, :2, :3, :4, :5, :6, :7, :8)';
for v_index in 1 .. v_rows loop
  execute immediate v_stmt using v_index,
  dbms_random.string('P',40),
  dbms_random.string('P',40),
  dbms_random.string('P',120),
  dbms_random.string('P',100),
  dbms_random.string('P',100),
  dbms_random.string('P',12),
  trunc(DBMS_RANDOM.VALUE(1,2000))
  ;
end loop;
end;
/

--carga cuenta usuario
declare
  v_rows number;
  v_stmt varchar2(200);
  v_username varchar2(30) := 'ADMIN_USUARIO';
  v_table varchar2(30) := 'CUENTA_USUARIO';
begin
v_rows := 2000;
v_stmt := 'insert into '||v_username||'.'||v_table||'(
  cuenta_usuario_id, usuario_propietario_id, usuario_id
  ) values (:1, :2, :3)';
for v_index in 1 .. v_rows loop
  execute immediate v_stmt using v_index,
  trunc(DBMS_RANDOM.VALUE(1,1000)),
  trunc(DBMS_RANDOM.VALUE(1000,2000));
end loop;
end;
/

--carga dispositivo
declare
  v_rows number;
  v_stmt varchar2(200);
  v_username varchar2(30) := 'ADMIN_USUARIO';
  v_table varchar2(30) := 'DISPOSITIVO';
begin
v_rows := 2000;
v_stmt := 'insert into '||v_username||'.'||v_table||'(
  dispositivo_id, tipo, ip, sistema_operativo, nombre, marca, usuario_id
  ) values (:1, :2, :3, :4, :5, :6, :7)';
for v_index in 1 .. v_rows loop
  execute immediate v_stmt using v_index,
  dbms_random.string('P',40),
  dbms_random.string('P',16),
  dbms_random.string('P',40),
  dbms_random.string('P',40),
  dbms_random.string('P',40),
  trunc(DBMS_RANDOM.VALUE(1,1000));
end loop;
end;
/

-- carga playlist
declare
  v_rows number;
  v_stmt varchar2(200);
  v_username varchar2(30) := 'ADMIN_USUARIO';
  v_table varchar2(30) := 'PLAYLIST';
begin
v_rows := 2000;
v_stmt := 'insert into '||v_username||'.'||v_table||'(
  playlist_id, nombre, usuario_creador_id
  ) values (:1, :2, :3)';
for v_index in 1 .. v_rows loop
  execute immediate v_stmt using v_index,
  dbms_random.string('P',40),
  trunc(DBMS_RANDOM.VALUE(1,1000));
end loop;
end;
/

-- carga playlist usuario
declare
  v_rows number;
  v_stmt varchar2(200);
  v_username varchar2(30) := 'ADMIN_USUARIO';
  v_table varchar2(30) := 'PLAYLIST_USUARIO';
begin
v_rows := 2000;
v_stmt := 'insert into '||v_username||'.'||v_table||'(
  playlist_usuario_id, playlist_id, usuario_id
  ) values (:1, :2, :3)';
for v_index in 1 .. v_rows loop
  execute immediate v_stmt using to_char(v_index),
  trunc(DBMS_RANDOM.VALUE(1,2000)),
  trunc(DBMS_RANDOM.VALUE(1,2000));
end loop;
end;
/

administer key management set keystore OPEN identified by "Hola1234!";
-- carga tarjeta
declare
  v_rows number;
  v_stmt varchar2(200);
  v_username varchar2(30) := 'ADMIN_USUARIO';
  v_table varchar2(30) := 'TARJETA';
begin
v_rows := 2000;
v_stmt := 'insert into '||v_username||'.'||v_table||'(
  tarjeta_id, numero, tipo, numero_seguridad, fecha_vigencia, usuario_id
  ) values (:1, :2, :3, :4, :5, :6)';
for v_index in 1 .. v_rows loop
  execute immediate v_stmt using v_index,
  to_char(trunc(DBMS_RANDOM.VALUE(1000000000000000,9999999999999999))),
  dbms_random.string('P',40),
  to_char(trunc(DBMS_RANDOM.VALUE(100,999))),
  TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2023-01-01','J'),TO_CHAR(DATE '2024-01-01','J'))),'J'),
  trunc(DBMS_RANDOM.VALUE(1,2000));
end loop;
end;
/

-- cargo tarjeta
declare
  v_rows number;
  v_stmt varchar2(200);
  v_username varchar2(30) := 'ADMIN_USUARIO';
  v_table varchar2(30) := 'CARGO_TARJETA';
begin
v_rows := 2000;
v_stmt := 'insert into '||v_username||'.'||v_table||'(
  cargo_tarjeta_id, tarjeta_id, fecha_cargo, folio, importe
  ) values (:1, :2, :3, :4, :5)';
for v_index in 1 .. v_rows loop
  execute immediate v_stmt using v_index,
  trunc(DBMS_RANDOM.VALUE(1,2000)),
  TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2020-01-01','J'),TO_CHAR(DATE '2021-09-01','J'))),'J'),
  dbms_random.string('P',12),
  trunc(DBMS_RANDOM.VALUE(1,2000),2);
end loop;
end;
/
administer key management set keystore CLOSE identified by "Hola1234!";

-- carga de generos
declare
  v_rows number;
  v_stmt varchar2(200);
  v_username varchar2(30) := 'ADMIN_MULTIMEDIA';
  v_table varchar2(30) := 'GENERO';
begin
v_rows := 2000;
v_stmt := 'insert into '||v_username||'.'||v_table||'(
  genero_id, nombre
  ) values (:1, :2)';
for v_index in 1 .. v_rows loop
  execute immediate v_stmt using v_index,
  dbms_random.string('P',100);
end loop;
end;
/

--carga de contenido multimedia
declare
  v_rows number;
  v_stmt varchar2(200);
  v_username varchar2(30) := 'ADMIN_MULTIMEDIA';
  v_table varchar2(30) := 'CONTENIDO_MULTIMEDIA';
begin
v_rows := 2000;
v_stmt := 'insert into '||v_username||'.'||v_table||'(
  contenido_multimedia_id, clave, nombre, tipo, total_reproducciones, duracion, reproducciones, calificacion, genero_id
  ) values (:1, :2, :3, :4, :5, :6, :7, :8, :9)';
for v_index in 1 .. v_rows loop
  execute immediate v_stmt using v_index,
  dbms_random.string('P',100);
end loop;
end;
/
rollback;

whenever sqlerror continue
