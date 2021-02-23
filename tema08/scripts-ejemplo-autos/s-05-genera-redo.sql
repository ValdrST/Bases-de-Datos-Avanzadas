--@Autor:           Jorge Rodriguez
--@Fecha creación:  dd/mm/yyyy
--@Descripción:     Simulación de actividad
set serveroutput on;
whenever sqlerror exit rollback

--------------------------------------------------
-------- Redo para la tabla AUTO-------------------
---------------------------------------------------
declare
  v_max_id number;
  v_count number;
  cursor cur_insert is
    select auto_seq.nextval as auto_id, marca,modelo,anio,
     substr(num_serie,4)||auto_seq.currval as num_serie,tipo,precio,
      descuento,foto,fecha_status,status_auto_id,agencia_id,cliente_id
    from auto sample(60) a where rownum <=50;
  
  cursor cur_update is
    select * from auto sample (60) where rownum <=50;
begin
   -- insert
   v_count := 0;
  for r in cur_insert loop
    insert into auto (auto_id, marca,modelo,anio,num_serie,tipo,precio,
      descuento,foto,fecha_status,status_auto_id,agencia_id,cliente_id)
    values(r.auto_id, r.marca,r.modelo,r.anio,r.num_serie,r.tipo,r.precio,
      r.descuento,r.foto,r.fecha_status,r.status_auto_id,r.agencia_id,
      r.cliente_id);
    v_count := v_count + sql%rowcount;
  end loop;

  dbms_output.put_line('Registros insertados en AUTO: '||v_count);

  select max(auto_id) into v_max_id
  from auto;
  -- update 
  v_count := 0;
  for r in cur_update loop
      update auto set marca = r.marca, modelo = r.modelo, anio = r.anio,
        tipo = r.tipo, precio = r.precio,descuento = r.descuento, 
        foto = r.foto, fecha_status = r.fecha_status,
        agencia_id = r.agencia_id, cliente_id = r.cliente_id
        where auto_id = (select trunc(dbms_random.value(1,v_max_id))from dual);
        v_count := v_count + sql%rowcount;
  end loop;
  dbms_output.put_line('Registros modificados en AUTO: '||v_count);

end;
/

--------------------------------------------------
-------- Redo para la tabla PAGO_AUTO-------------
---------------------------------------------------

declare 
  cursor cur_pagos_insert is
    select auto_id 
    from auto a
    where not exists(
      select 1 from
      pago_auto p 
      where p.auto_id = a.auto_id
    ) and rownum <=40;

  v_count number;
  
    cursor cur_update is
      select * from pago_auto sample(95)
      where rownum <=90;
    
    cursor cur_delete is
      select * from pago_auto sample(40)
      where rownum <=30;
begin

  v_count := 0;
  --insert 
  for r in cur_pagos_insert loop
    for i in 1..10 loop
      insert into pago_auto(num_pago,auto_id,fecha_pago,importe)
      values(i,r.auto_id,sysdate,round(dbms_random.value(3000,998998),2));
      v_count := v_count +1;
    end loop;
  end loop;
  dbms_output.put_line('Registros insertados en PAGO_AUTO: '||v_count);
  
  v_count := 0;
  ---update
  for r in cur_update loop
    update pago_auto set 
      fecha_pago = (fecha_pago + dbms_random.value(1,100)), 
      importe = importe + round(dbms_random.value(1,1000),2)
      where num_pago = r.num_pago and auto_id = r.auto_id;
      v_count := v_count +1;
  end loop;
  dbms_output.put_line('Registros modificados en PAGO_AUTO: '||v_count);

  v_count := 0;
  --delete
  for r in cur_delete loop
    delete from pago_auto 
    where num_pago = r.num_pago 
    and auto_id = r.auto_id;
    v_count := v_count +1;
  end loop;
  dbms_output.put_line('Registros eliminados en PAGO_AUTO: '||v_count);

end;
/

--------------------------------------------------
---- Redo para la tabla HISTORICO_STATUS_AUTO-----
---------------------------------------------------
declare
  cursor cur_insert is
    select auto_id
    from auto a where not exists (
      select 1
      from historico_status_auto h
      where h.auto_id  = a.auto_id
    ) and rownum <= 30;

  cursor cur_update is
    select * from historico_status_auto sample(10)
    where rownum <= 100;

  cursor cur_delete is
    select * from historico_status_auto sample(5)
    where rownum <=25;

  v_count number;

begin

  --insert
  v_count := 0;
  for r in cur_insert loop
    -- inserta 6 registros, uno por status:
    --en transito, en agencia, apartado, vendido, defectuoso, en reparacion
    for v_index in 1..6 loop
      --status 1 en transito
      insert into historico_status_auto(historico_status_auto_id,fecha_status,
        status_auto_id,auto_id)
      values(historico_status_auto_seq.nextval,sysdate+v_index,v_index,r.auto_id);
      v_count := v_count + 1;
    end loop;
  end loop;
  dbms_output.put_line('Registros creados en HISTORICO_STATUS_AUTO: '||v_count);

  --update
  v_count := 0;
  for r in cur_update loop

    update historico_status_auto set 
      fecha_status = r.fecha_status + dbms_random.value(1,20),
      status_auto_id = round(dbms_random.value(1,6))
      where historico_status_auto_id = r.historico_status_auto_id;
      v_count := v_count + 1;
  end loop;
  dbms_output.put_line('Registros modificados en HISTORICO_STATUS_AUTO: '||v_count);

  --delete
  v_count := 0;
  for r in cur_delete loop
    delete from historico_status_auto 
    where historico_status_auto_id = r.historico_status_auto_id;
    v_count := v_count + 1;
  end loop;
  dbms_output.put_line('Registros eliminados en HISTORICO_STATUS_AUTO: '||v_count);

end;
/

--------------------------------------------------
---- Redo para la tabla TARJETA_CLIENTE-----
---------------------------------------------------

declare
  cursor cur_insert is 
    select cliente_id from cliente c 
    where not exists (
      select 1
      from tarjeta_cliente t
      where t.cliente_id = c.cliente_id
    ) and rownum <= 40;
  
  v_count number;

  cursor cur_update is
    select cliente_id from tarjeta_cliente sample(90)
    where rownum <= 20;

   cursor cur_delete is
    select cliente_id from tarjeta_cliente sample(90)
    where rownum <= 30;
   
begin

  -- insert
  v_count := 0;
  for r in cur_insert loop
    insert into tarjeta_cliente(cliente_id,num_tarjeta,anio_expira,mes_expira,
      codigo_seguridad,tipo)
    values(
      r.cliente_id,to_char(r.cliente_id,'FM0000000000000000'),
      to_char(trunc(dbms_random.value(1,100)),'FM00'),
      to_char(trunc(dbms_random.value(1,13)),'FM00'),
      to_char(trunc(dbms_random.value(1,1000)),'FM000'),
      dbms_random.string('X',1)
    );
    v_count := v_count +1;
  end loop;

  dbms_output.put_line('Registros insertados en TARJETA_CLIENTE: '||v_count);

  --update 
  v_count := 0;
  for r in cur_update loop
    update tarjeta_cliente set 
      anio_expira = to_char(trunc(dbms_random.value(1,100)),'FM00'),
      mes_expira =  to_char(trunc(dbms_random.value(1,13)),'FM00'),
      codigo_seguridad =  to_char(trunc(dbms_random.value(1,1000)),'FM000'),
      tipo = dbms_random.string('X',1)
    where cliente_id = r.cliente_id;
    v_count := v_count + 1;
  end loop; 
  dbms_output.put_line('Registros modificados en TARJETA_CLIENTE: '||v_count);

  --delete
  v_count := 0;
  for r in cur_delete loop
    delete from tarjeta_cliente where cliente_id = r.cliente_id;
    v_count := v_count +1;
  end loop;
  dbms_output.put_line('Registros eliminados en TARJETA_CLIENTE: '||v_count);

end;
/

--------------------------------------------------
---- Redo para la tabla AUTO_PARTICULAR, AUTO_CARGA
---------------------------------------------------
declare
  cursor cur_update_ap is
    select auto_id from auto_particular sample(90)
    where rownum <=50;

  cursor cur_update_ac is
    select auto_id from auto_carga sample(90)
    where rownum <=50;  

  v_count number;
  v_user varchar2(100) := sys_context('USERENV', 'SESSION_USER');
begin
  --update para auto_particular
  v_count := 0;
  for r in cur_update_ap loop
    update auto_particular set 
    num_cilindros = round(dbms_random.value(3,9)),
    num_pasajeros = round(dbms_random.value(15,60)),
    clase = dbms_random.string('X',1)
    where auto_id = r.auto_id;
    v_count := v_count + 1;
  end loop;
  dbms_output.put_line('Registros modificados en AUTO_PARTICULAR: '||v_count);

  --update para auto_carga
  v_count := 0;
  for r in cur_update_ac loop
    update auto_carga set 
    peso_maximo = round(dbms_random.value(1500,99999999),2),
    volumen = round(dbms_random.value(1500,99999999),2),
    tipo_combustible = dbms_random.string('X',1)
    where auto_id = r.auto_id;
    v_count := v_count + 1;
  end loop;
  dbms_output.put_line('Registros modificados en AUTO_CARGA: '||v_count);

  dbms_output.put_line('Cambios concluidos - '
    ||to_char(sysdate,'dd/mm/yyyy hh24:mi:ss')
    ||' Usuario: '
    ||v_user
  );

end;
/

Prompt Confirmando Cambios
commit;

whenever sqlerror continue none