

-- 
-- sequence: auto_seq 
--

create sequence auto_seq
    start with 101
    increment by 1
    nominvalue
    nomaxvalue
    cache 20
    noorder
;

-- 
-- sequence: historico_status_auto_seq 
--

create sequence historico_status_auto_seq
    start with 1001
    increment by 1
    nominvalue
    nomaxvalue
    cache 20
    noorder
;

-- 
-- table: agencia 
--

create table agencia(
    agencia_id          number(10, 0)    not null,
    nombre              varchar2(40)     not null,
    clave               varchar2(8)      not null,
    agencia_anexa_id    number(10, 0),
    constraint agencia_pk primary key (agencia_id)
    tablespace indexes_tbs, 
    constraint agencia_anexa_id_fk foreign key (agencia_anexa_id)
    references agencia(agencia_id)
) tablespace clientes_tbs
;



-- 
-- table: cliente 
--

create table cliente(
    cliente_id            number(10, 0)    not null,
    nombre                varchar2(40)     not null,
    ap_paterno            varchar2(40)     not null,
    ap_materno            varchar2(40),
    num_identificacion    varchar2(18)     not null,
    email                 varchar2(500)    not null,
    constraint cliente_pk primary key (cliente_id)
    tablespace indexes_tbs
) tablespace clientes_tbs
;



-- 
-- table: status_auto 
--

create table status_auto(
    status_auto_id    number(2, 0)    not null,
    clave             varchar2(20)    not null,
    descripcion       varchar2(40)    not null,
    constraint status_auto_pk primary key (status_auto_id)
    tablespace indexes_tbs
) tablespace autos_tbs
;



-- 
-- table: auto 
--

create table auto(
    auto_id           number(10, 0)    not null,
    marca             varchar2(40)     not null,
    modelo            varchar2(40)     not null,
    anio              number(4, 0)     not null,
    num_serie         varchar2(20)     not null,
    tipo              char(1)          not null,
    precio            number(9, 2)     not null,
    descuento         number(9, 2),
    foto              blob             not null,
    fecha_status      timestamp(6)     not null,
    status_auto_id    number(2, 0)     not null,
    agencia_id        number(10, 0)    not null,
    cliente_id        number(10, 0),
    constraint auto_pk primary key (auto_id)
    tablespace indexes_tbs, 
    constraint auto_agencia_id_fk foreign key (agencia_id)
    references agencia(agencia_id),
    constraint auto_cliente_id_fk foreign key (cliente_id)
    references cliente(cliente_id),
    constraint auto_status_id_fk foreign key (status_auto_id)
    references status_auto(status_auto_id)
) tablespace autos_tbs
;



-- 
-- table: auto_carga 
--

create table auto_carga(
    auto_id             number(10, 0)    not null,
    peso_maximo         number(10, 2)    not null,
    volumen             number(10, 2)    not null,
    tipo_combustible    char(1)          not null,
    constraint auto_carga_pk primary key (auto_id)
    tablespace indexes_tbs, 
    constraint refauto2 foreign key (auto_id)
    references auto(auto_id)
) tablespace autos_tbs
; 



-- 
-- table: auto_particular 
--

create table auto_particular(
    auto_id          number(10, 0)    not null,
    num_cilindros    number(1, 0)     not null,
    num_pasajeros    number(2, 0)     not null,
    clase            char(1)          not null,
    constraint auto_particular_pk primary key (auto_id)
    tablespace indexes_tbs, 
    constraint refauto1 foreign key (auto_id)
    references auto(auto_id)
) tablespace autos_tbs
;



-- 
-- table: historico_status_auto 
--

create table historico_status_auto(
    historico_status_auto_id    number(10, 0)    not null,
    fecha_status           timestamp(6)     not null,
    status_auto_id         number(2, 0)     not null,
    auto_id                number(10, 0)    not null,
    constraint historico_status_auto_pk primary key (historico_status_auto_id)
    tablespace indexes_tbs, 
    constraint h_status_auto_status_auto_id_fk foreign key (status_auto_id)
    references status_auto(status_auto_id),
    constraint h_status_auto_auto_id_fk foreign key (auto_id)
    references auto(auto_id)
) tablespace autos_tbs
;



-- 
-- table: pago_auto 
--

create table pago_auto(
    num_pago              number(3, 0)     not null,
    auto_id               number(10, 0)    not null,
    fecha_pago            timestamp(6)     not null,
    importe               number(8, 2)     not null,
    importe_devolucion    number(8, 2),
    constraint pago_auto_pk primary key (num_pago, auto_id)
    tablespace indexes_tbs, 
    constraint pago_auto_id_fk foreign key (auto_id)
    references auto(auto_id)
) tablespace clientes_tbs
;



-- 
-- table: tarjeta_cliente 
--

create table tarjeta_cliente(
    cliente_id          number(10, 0)    not null,
    num_tarjeta         varchar2(16)     not null,
    anio_expira         varchar2(2)      not null,
    mes_expira          varchar2(2)      not null,
    codigo_seguridad    number(3, 0)     not null,
    tipo                char(1)          not null,
    constraint tarjeta_cliente_pk primary key (cliente_id)
    tablespace indexes_tbs, 
    constraint tarjeta_cliente_id_fk foreign key (cliente_id)
    references cliente(cliente_id)
) tablespace clientes_tbs
;



-- 
-- index: auto_num_serie_uk 
--

create unique index auto_num_serie_uk on auto(num_serie)
;
-- 
-- index: cliente_email_uk 
--

create unique index cliente_email_uk on cliente(num_identificacion, email)
;
-- 
-- index: tarjeta_cliente_num_tarjeta_uk 
--

create unique index tarjeta_cliente_num_tarjeta_uk on tarjeta_cliente(num_tarjeta)
;
