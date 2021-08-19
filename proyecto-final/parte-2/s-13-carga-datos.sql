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
  v_tipo varchar2(200);
  v_stmt varchar2(300);
  v_stmt_video varchar2(300);
  v_stmt_audio varchar2(300);
  v_username varchar2(30) := 'ADMIN_MULTIMEDIA';
  v_table varchar2(30) := 'CONTENIDO_MULTIMEDIA';
  v_table_video varchar2(30) := 'VIDEO';
  v_table_audio varchar2(30) := 'AUDIO';
begin
v_rows := 2000;
v_stmt := 'insert into '||v_username||'.'||v_table||'(
  contenido_multimedia_id, clave, nombre, tipo, total_reproducciones, duracion, reproducciones, calificacion, genero_id
  ) values (:1, :2, :3, :4, :5, :6, :7, :8, :9)';
v_stmt_video := 'insert into '||v_username||'.'||v_table_video||'(
  contenido_multimedia_id, tipo_video, clasificacion, codificacion, tipo_transporte
  ) values (:1, :2, :3, :4, :5)';
v_stmt_audio := 'insert into '||v_username||'.'||v_table_audio||'(
  contenido_multimedia_id, LETRA, FORMATO, BITRATE
  ) values (:1, :2, :3, :4)';
for v_index in 1 .. v_rows loop
  SELECT
    (CASE trunc(dbms_random.value(1,3))
      WHEN 1 THEN 'V'
      WHEN 2 THEN 'A'
    END) as tipo
  INTO v_tipo
  FROM dual;
  execute immediate v_stmt using v_index,
  dbms_random.string('P',16),
  dbms_random.string('P',100),
  v_tipo,
  trunc(DBMS_RANDOM.VALUE(1,1000000)),
  NUMTODSINTERVAL(trunc(DBMS_RANDOM.VALUE(1,180)),'MINUTE'),
  trunc(DBMS_RANDOM.VALUE(1,1000000)),
  trunc(DBMS_RANDOM.VALUE(1,5)),
  trunc(DBMS_RANDOM.VALUE(1,2000));
  --dbms_random.string('P',trunc(DBMS_RANDOM.VALUE(1000,3000)))
  IF v_tipo = 'V' THEN
    execute immediate v_stmt_video using v_index,
    dbms_random.string('P',40),
    dbms_random.string('P',1),
    dbms_random.string('P',40),
    dbms_random.string('P',40);
  ELSE
    execute immediate v_stmt_audio using v_index,
    dbms_random.string('P',trunc(DBMS_RANDOM.VALUE(1000,3000))),
    dbms_random.string('P',40),
    DBMS_RANDOM.VALUE(1000,36000);
	END IF;
end loop;
end;
/

-- carga de contenido seccion
declare
  v_rows number;
  v_stmt varchar2(200);
  v_blob blob;
  v_clob        clob;
  v_dest_offset integer := 1;
  v_src_offset  integer := 1;
  v_warn        integer;
  v_ctx         integer := dbms_lob.default_lang_ctx;
  v_username varchar2(30) := 'ADMIN_MULTIMEDIA';
  v_table varchar2(30) := 'CONTENIDO_SECCION';
begin
v_rows := 200;
v_stmt := 'insert into '||v_username||'.'||v_table||'(
  contenido_seccion_id, id_secuencia, contenido, contenido_multimedia_id
  ) values (:1, :2, :3, :4)';
for v_index in 1 .. v_rows loop
  for idx in 1..5 loop
    v_clob := v_clob || dbms_random.string('x', 2000);
  end loop;
  dbms_lob.createtemporary( v_blob, false);
  dbms_lob.converttoblob(v_blob,
    v_clob,
    dbms_lob.lobmaxsize,
    v_dest_offset,
    v_src_offset,
    dbms_lob.default_csid,
    v_ctx,
    v_warn);
  execute immediate v_stmt using v_index,
  dbms_random.string('P',16),
  v_blob,
  trunc(DBMS_RANDOM.VALUE(1,2000));
end loop;
end;
/
prompt carga de datos blob completa

prompt inicio carga reproduccion
-- carga reproduccion
declare
  v_rows number;
  v_stmt varchar2(400);
  v_username varchar2(30) := 'ADMIN_MULTIMEDIA';
  v_table varchar2(30) := 'REPRODUCCION';
begin
v_rows := 2000;
v_stmt := 'insert into '||v_username||'.'||v_table||'(
  reproduccion_id, 
  hora_inicio, 
  hora_fin, 
  fecha_reproduccion, 
  dispositivo, 
  velocidad_descarga, 
  velocidad_carga, 
  latitud,
  longitud,
  contenido_multimedia_id,
  dispositivo_id
  ) values (
    :1, 
    :2,
    :3,
    :4,
    :5,
    :6,
    :7,
    :8,
    :9,
    :10,
    :11
    )';
for v_index in 1 .. v_rows loop
  execute immediate v_stmt using v_index,
  NUMTODSINTERVAL(trunc(DBMS_RANDOM.VALUE(1,180)),'MINUTE'),
  NUMTODSINTERVAL(trunc(DBMS_RANDOM.VALUE(1,180)),'MINUTE'),
  TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2020-01-01','J'),TO_CHAR(DATE '2021-09-01','J'))),'J'),
  dbms_random.string('P',40),
  trunc(DBMS_RANDOM.VALUE(1,2000),2),
  trunc(DBMS_RANDOM.VALUE(1,2000),2),
  trunc(DBMS_RANDOM.VALUE(1,1000),5),
  trunc(DBMS_RANDOM.VALUE(1,1000),5),
  trunc(DBMS_RANDOM.VALUE(1,2000)),
  trunc(DBMS_RANDOM.VALUE(1,2000));
end loop;
end;
/
prompt fin carga reproduccion

prompt inicio carga comentarios
-- carga Comentario
declare
  v_rows number;
  v_stmt varchar2(200);
  v_username varchar2(30) := 'ADMIN_MULTIMEDIA';
  v_table varchar2(30) := 'COMENTARIO';
begin
v_rows := 2000;
v_stmt := 'insert into '||v_username||'.'||v_table||'(
  comentario_id, 
  comentario, 
  comentario_respuesta_id, 
  contenido_multimedia_id, 
  usuario_id
  ) values (
    :1, 
    :2,
    :3,
    :4,
    :5
  )';
for v_index in 1 .. v_rows loop
  execute immediate v_stmt using v_index,
  dbms_random.string('P',150),
  trunc(DBMS_RANDOM.VALUE(1,v_index)),
  trunc(DBMS_RANDOM.VALUE(1,2000)),
  trunc(DBMS_RANDOM.VALUE(1,2000));
end loop;
end;
/
prompt fin carga comentarios
prompt carga Autor
-- carga autor
declare
  v_rows number;
  v_stmt varchar2(200);
  v_username varchar2(30) := 'ADMIN_MULTIMEDIA';
  v_table varchar2(30) := 'AUTOR';
begin
v_rows := 2000;
v_stmt := 'insert into '||v_username||'.'||v_table||'(
  autor_id,
  nombre,
  apellidos,
  email,
  nombre_artistico
  ) values (
    :1, 
    :2,
    :3,
    :4,
    :5
  )';
for v_index in 1 .. v_rows loop
  execute immediate v_stmt using v_index,
  dbms_random.string('P',100),
  dbms_random.string('P',100),
  dbms_random.string('P',100),
  dbms_random.string('P',100);
end loop;
end;
/

-- carga contenido multimedia autor
declare
  v_rows number;
  v_stmt varchar2(300);
  v_username varchar2(30) := 'ADMIN_MULTIMEDIA';
  v_table varchar2(30) := 'CONTENIDO_MULTIMEDIA_AUTOR';
begin
v_rows := 2000;
v_stmt := 'insert into '||v_username||'.'||v_table||'(
  contenido_multimedia_autor_id,
  porcentaje_participacion,
  autor_id,
  contenido_multimedia_id
  ) values (
    :1, 
    :2,
    :3,
    :4
  )';
for v_index in 1 .. v_rows loop
  execute immediate v_stmt using v_index,
  trunc(DBMS_RANDOM.VALUE(1,99),2),
  trunc(DBMS_RANDOM.VALUE(1,2000)),
  trunc(DBMS_RANDOM.VALUE(1,2000));
end loop;
end;
/

-- carga playlist contenido
declare
  v_rows number;
  v_stmt varchar2(300);
  v_username varchar2(30) := 'ADMIN_MULTIMEDIA';
  v_table varchar2(30) := 'PLAYLIST_CONTENIDO';
begin
v_rows := 2000;
v_stmt := 'insert into '||v_username||'.'||v_table||'(
  playlist_contenido_id,
  playlist_id,
  contenido_multimedia_id
  ) values (
    :1, 
    :2,
    :3
  )';
for v_index in 1 .. v_rows loop
  execute immediate v_stmt using v_index,
  trunc(DBMS_RANDOM.VALUE(1,2000)),
  trunc(DBMS_RANDOM.VALUE(1,2000));
end loop;
end;
/
commit;

whenever sqlerror continue
