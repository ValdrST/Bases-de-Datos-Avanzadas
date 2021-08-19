--@Autor: Vicente Romero Andrade
--@Fecha Creacion: 10/08/2021
--@Descripcion: Ejecución de carga de datos
connect sys/system2 as sysdba
-- Desactiva redo
--shutdown immediate
--startup mount
--Alter database noarchivelog;
--alter database open;

administer key management set keystore OPEN identified by "Hola1234!";
declare
  v_rows number;
  v_id number;
  v_id_2 number;
  v_id_3 number;
  v_id_4 number;
  v_id_5 number;
  v_id_6 number;
  v_id_7 number;
  v_tipo varchar2(20);
  v_stmt varchar2(200);
  v_stmt_2 varchar2(300);
  v_stmt_3 varchar2(300);
  v_stmt_4 varchar2(300);
  v_stmt_5 varchar2(300);
  v_stmt_6 varchar2(300);
  v_stmt_7 varchar2(300);
  v_stmt_video varchar2(300);
  v_stmt_audio varchar2(300);
  v_username varchar2(30) := 'ADMIN_USUARIO';
  v_username_2 varchar2(30) := 'ADMIN_MULTIMEDIA';
  v_table varchar2(30) := 'USUARIO';
  v_table_2 varchar2(30) := 'CUENTA_USUARIO';
  v_table_3 varchar2(30) := 'DISPOSITIVO';
  v_table_4 varchar2(30) := 'PLAYLIST';
  v_table_5 varchar2(30) := 'TARJETA';
  v_table_6 varchar2(30) := 'GENERO';
  v_table_7 varchar2(30) := 'CONTENIDO_MULTIMEDIA';
  v_table_video varchar2(30) := 'VIDEO';
  v_table_audio varchar2(30) := 'AUDIO';
  
  cursor cur_update_1 is
    select * from ADMIN_USUARIO.USUARIO sample(10)
    where rownum <= 100;

  cursor cur_delete_1 is
    select * from ADMIN_USUARIO.USUARIO sample(5)
    where rownum <=25;
  
  cursor cur_update_2 is
    select * from ADMIN_USUARIO.TARJETA sample(10)
    where rownum <= 100;

  cursor cur_delete_2 is
    select * from ADMIN_USUARIO.TARJETA sample(5)
    where rownum <=25;

  cursor cur_update_3 is
    select * from ADMIN_MULTIMEDIA.CONTENIDO_MULTIMEDIA sample(10)
    where rownum <= 100;

  cursor cur_delete_3 is
    select * from ADMIN_MULTIMEDIA.CONTENIDO_MULTIMEDIA sample(5)
    where rownum <=25;
begin
v_rows := 200;
v_stmt := 'insert into '||v_username||'.'||v_table||'(
  usuario_id, username, password, email, nombre, apellidos, rfc, plan_suscripcion_id
  ) values (:1, :2, :3, :4, :5, :6, :7, :8)';
v_stmt_2 := 'insert into '||v_username||'.'||v_table_2||'(
  cuenta_usuario_id, usuario_propietario_id, usuario_id
  ) values (:1, :2, :3)';
v_stmt_3 := 'insert into '||v_username||'.'||v_table_3||'(
  dispositivo_id, tipo, ip, sistema_operativo, nombre, marca, usuario_id
  ) values (:1, :2, :3, :4, :5, :6, :7)';
v_stmt_4 := 'insert into '||v_username||'.'||v_table_4||'(
  playlist_id, nombre, usuario_creador_id
  ) values (:1, :2, :3)';
v_stmt_5 := 'insert into '||v_username||'.'||v_table_5||'(
  tarjeta_id, numero, tipo, numero_seguridad, fecha_vigencia, usuario_id
  ) values (:1, :2, :3, :4, :5, :6)';
v_stmt_6 := 'insert into '||v_username_2||'.'||v_table_6||'(
  genero_id, nombre
  ) values (:1, :2)';
v_stmt_7 := 'insert into '||v_username_2||'.'||v_table_7||'(
  contenido_multimedia_id, clave, nombre, tipo, total_reproducciones, duracion, reproducciones, calificacion, genero_id
  ) values (:1, :2, :3, :4, :5, :6, :7, :8, :9)';
v_stmt_video := 'insert into '||v_username_2||'.'||v_table_video||'(
  contenido_multimedia_id, tipo_video, clasificacion, codificacion, tipo_transporte
  ) values (:1, :2, :3, :4, :5)';
v_stmt_audio := 'insert into '||v_username_2||'.'||v_table_audio||'(
  contenido_multimedia_id, LETRA, FORMATO, BITRATE
  ) values (:1, :2, :3, :4)';
for v_index in 1 .. v_rows loop
  v_id := trunc(DBMS_RANDOM.VALUE(2001,4000000));
  v_id_2 := trunc(DBMS_RANDOM.VALUE(2001,4000000));
  v_id_3 := trunc(DBMS_RANDOM.VALUE(2001,4000000));
  v_id_4 := trunc(DBMS_RANDOM.VALUE(2001,4000000));
  v_id_5 := trunc(DBMS_RANDOM.VALUE(2001,4000000));
  v_id_6 := trunc(DBMS_RANDOM.VALUE(2001,4000000));
  v_id_7 := trunc(DBMS_RANDOM.VALUE(2001,4000000));
  execute immediate v_stmt using v_id,
  dbms_random.string('P',40),
  dbms_random.string('P',40),
  dbms_random.string('P',120),
  dbms_random.string('P',100),
  dbms_random.string('P',100),
  dbms_random.string('P',12),
  trunc(DBMS_RANDOM.VALUE(1,2000));

  for r in cur_update_1 loop
    UPDATE ADMIN_USUARIO.USUARIO SET
      username = dbms_random.string('P',40), 
      password = dbms_random.string('P',40)
    WHERE USUARIO_ID = r.USUARIO_ID;
  end loop;

  for r in cur_delete_1 loop
    DELETE FROM ADMIN_USUARIO.USUARIO
    WHERE USUARIO_ID = r.USUARIO_ID;
  end loop;

  execute immediate v_stmt_2 using v_id_2,
  v_id,
  trunc(DBMS_RANDOM.VALUE(1,2000));

  execute immediate v_stmt_3 using v_id_3,
  dbms_random.string('P',40),
  dbms_random.string('P',16),
  dbms_random.string('P',40),
  dbms_random.string('P',40),
  dbms_random.string('P',40),
  v_id;

  execute immediate v_stmt_4 using v_id_4,
  dbms_random.string('P',40),
  v_id;

  execute immediate v_stmt_5 using v_id_5,
  to_char(trunc(DBMS_RANDOM.VALUE(1000000000000000,9999999999999999))),
  dbms_random.string('P',40),
  to_char(trunc(DBMS_RANDOM.VALUE(100,999))),
  TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2023-01-01','J'),TO_CHAR(DATE '2024-01-01','J'))),'J'),
  v_id;

  for r in cur_update_2 loop
    UPDATE ADMIN_USUARIO.TARJETA SET
      numero = to_char(trunc(DBMS_RANDOM.VALUE(1000000000000000,9999999999999999))), 
      tipo = dbms_random.string('P',40), 
      numero_seguridad = to_char(trunc(DBMS_RANDOM.VALUE(100,999)))
    WHERE USUARIO_ID = r.USUARIO_ID;
  end loop;

  for r in cur_delete_2 loop
    DELETE FROM ADMIN_USUARIO.TARJETA
    WHERE TARJETA_ID = r.TARJETA_ID;
  end loop;

  execute immediate v_stmt_6 using v_id_6,
  dbms_random.string('P',100);

  SELECT
    (CASE trunc(dbms_random.value(1,3))
      WHEN 1 THEN 'V'
      WHEN 2 THEN 'A'
    END) as tipo
  INTO v_tipo
  FROM dual;
  execute immediate v_stmt_7 using v_id_7,
  dbms_random.string('P',16),
  dbms_random.string('P',100),
  v_tipo,
  trunc(DBMS_RANDOM.VALUE(1,1000000)),
  NUMTODSINTERVAL(trunc(DBMS_RANDOM.VALUE(1,180)),'MINUTE'),
  trunc(DBMS_RANDOM.VALUE(1,1000000)),
  trunc(DBMS_RANDOM.VALUE(1,5)),
  v_id_6;
  IF v_tipo = 'V' THEN
    execute immediate v_stmt_video using v_id_7,
    dbms_random.string('P',40),
    dbms_random.string('P',1),
    dbms_random.string('P',40),
    dbms_random.string('P',40);
  ELSE
    execute immediate v_stmt_audio using v_id_7,
    dbms_random.string('P',trunc(DBMS_RANDOM.VALUE(1000,3000))),
    dbms_random.string('P',40),
    DBMS_RANDOM.VALUE(1000,36000);
	END IF;
  
  for r in cur_update_3 loop
    UPDATE ADMIN_MULTIMEDIA.CONTENIDO_MULTIMEDIA SET
      nombre=dbms_random.string('P',16),
      tipo=dbms_random.string('P',100)
    WHERE CONTENIDO_MULTIMEDIA_ID = r.CONTENIDO_MULTIMEDIA_ID;
  end loop;

  for r in cur_delete_3 loop
    DELETE FROM ADMIN_MULTIMEDIA.CONTENIDO_MULTIMEDIA
    WHERE CONTENIDO_MULTIMEDIA_ID = r.CONTENIDO_MULTIMEDIA_ID;
  end loop;

end loop;
DBMS_LOCK.Sleep(100 );
end;
/
administer key management set keystore CLOSE identified by "Hola1234!";
--commit;
