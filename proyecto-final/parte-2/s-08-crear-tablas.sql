--@Autor: Vicente Romero Andrade
--@Fecha Creacion: 28/07/2021
--@Descripcion: Creacion del codigo DDL
--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      proyecto_BDA.DM1
--
-- Date Created : Friday, July 30, 2021 16:54:56
-- Target DBMS : Oracle 12c
--
connect sys/system2 as sysdba
-- 
-- TABLE: admin_multimedia.GENERO 
--

CREATE TABLE admin_multimedia.GENERO(
    GENERO_ID    NUMBER(10, 0)    NOT NULL,
    NOMBRE       VARCHAR2(100)    NOT NULL,
    CONSTRAINT GENERO_PK PRIMARY KEY (GENERO_ID)
)
TABLESPACE multimediaTbs
;



-- 
-- TABLE: admin_multimedia.CONTENIDO_MULTIMEDIA 
--

CREATE TABLE admin_multimedia.CONTENIDO_MULTIMEDIA(
    CONTENIDO_MULTIMEDIA_ID    NUMBER(10, 0)    NOT NULL,
    CLAVE                      CHAR(16)         NOT NULL,
    NOMBRE                     VARCHAR2(100)    NOT NULL,
    TIPO                       CHAR(1)          NOT NULL,
    TOTAL_REPRODUCCIONES       NUMBER(10, 0)    NOT NULL,
    DURACION                   DATE             NOT NULL,
    REPRODUCCIONES             NUMBER(10, 0)    NOT NULL,
    CALIFICACION               NUMBER(1, 0)     NOT NULL,
    GENERO_ID                  NUMBER(10, 0)    NOT NULL,
    CONSTRAINT CONTENIDO_MULTIMEDIA_TIPO_CHK CHECK (TIPO IN ('A','V')),
    CONSTRAINT CONTENIDO_MULTIMEDIA_PK PRIMARY KEY (CONTENIDO_MULTIMEDIA_ID), 
    CONSTRAINT CONTENIDO_MULTIMEDIA_GENERO_ID_FK FOREIGN KEY (GENERO_ID)
    REFERENCES admin_multimedia.GENERO(GENERO_ID)
)
TABLESPACE multimediaTbs
;

grant REFERENCES on admin_multimedia.CONTENIDO_MULTIMEDIA to usuario;

-- 
-- TABLE: admin_multimedia.AUDIO 
--

CREATE TABLE admin_multimedia.AUDIO(
    CONTENIDO_MULTIMEDIA_ID    NUMBER(10, 0)    NOT NULL,
    LETRA                      CLOB,
    FORMATO                    VARCHAR2(40),
    BITRATE                    NUMBER(10, 0),
    CONSTRAINT AUDIO_PK PRIMARY KEY (CONTENIDO_MULTIMEDIA_ID), 
    CONSTRAINT AUDIO_CONTENIDO_MULTIMEDIA_ID_FK FOREIGN KEY (CONTENIDO_MULTIMEDIA_ID)
    REFERENCES admin_multimedia.CONTENIDO_MULTIMEDIA(CONTENIDO_MULTIMEDIA_ID)
)
TABLESPACE multimediaTbs
LOB(LETRA) STORE AS AUDIO_LETRA_CLOB (TABLESPACE multimediaObjTbs CHUNK 8000 NOCACHE LOGGING)
;



-- 
-- TABLE: admin_multimedia.AUTOR 
--

CREATE TABLE admin_multimedia.AUTOR(
    AUTOR_ID            NUMBER(10, 0)    NOT NULL,
    NOMBRE              VARCHAR2(100)    NOT NULL,
    APELLIDOS           VARCHAR2(100)    NOT NULL,
    EMAIL               VARCHAR2(100)    NOT NULL,
    NOMBRE_ARTISTICO    VARCHAR2(100)    NOT NULL,
    CONSTRAINT AUTOR_PK PRIMARY KEY (AUTOR_ID)
)
TABLESPACE multimediaTbs
;



-- 
-- TABLE: admin_usuario.PLAN_SUSCRIPCION 
--

CREATE TABLE admin_usuario.PLAN_SUSCRIPCION(
    PLAN_SUSCRIPCION_ID    NUMBER(10, 0)    NOT NULL,
    CLAVE                  CHAR(10)         NOT NULL,
    NOMBRE                 VARCHAR2(60)     NOT NULL,
    DESCRIPCION            VARCHAR2(200)    NOT NULL,
    COSTO                  NUMBER(10, 2)    NOT NULL,
    CONSTRAINT PLAN_SUSCRIPCION_PRECIO_CHK CHECK (COSTO >= 0.00),
    CONSTRAINT PK5 PRIMARY KEY (PLAN_SUSCRIPCION_ID)
)
TABLESPACE usersTbs
;



-- 
-- TABLE: admin_usuario.USUARIO 
--

CREATE TABLE admin_usuario.USUARIO(
    USUARIO_ID             NUMBER(10, 0)    NOT NULL,
    USERNAME               VARCHAR2(40)     NOT NULL,
    PASSWORD               VARCHAR2(40)     NOT NULL,
    EMAIL                  VARCHAR2(120)    NOT NULL,
    NOMBRE                 VARCHAR2(100)    NOT NULL,
    APELLIDOS              VARCHAR2(100)    NOT NULL,
    RFC                    CHAR(12),
    PLAN_SUSCRIPCION_ID    NUMBER(10, 0)    NOT NULL,
    CONSTRAINT USUARIO_PK PRIMARY KEY (USUARIO_ID), 
    CONSTRAINT USUARIO_PLAN_SUSCRIPCION_ID_FK FOREIGN KEY (PLAN_SUSCRIPCION_ID)
    REFERENCES admin_usuario.PLAN_SUSCRIPCION(PLAN_SUSCRIPCION_ID)
)
TABLESPACE usersTbs
;

grant REFERENCES on admin_usuario.USUARIO to admin_multimedia;

-- 
-- TABLE: admin_multimedia.COMENTARIO 
--

CREATE TABLE admin_multimedia.COMENTARIO(
    COMENTARIO_ID              NUMBER(10, 0)    NOT NULL,
    COMENTARIO                 VARCHAR2(150)    NOT NULL,
    COMENTARIO_RESPUESTA_ID    NUMBER(10, 0),
    CONTENIDO_MULTIMEDIA_ID    NUMBER(10, 0)    NOT NULL,
    USUARIO_ID                 NUMBER(10, 0)    NOT NULL,
    CONSTRAINT COMENTARIO_PK PRIMARY KEY (COMENTARIO_ID), 
    CONSTRAINT COMENTARIO_COMENTARIO_RESPUESTA_ID_FK FOREIGN KEY (COMENTARIO_RESPUESTA_ID)
    REFERENCES admin_multimedia.COMENTARIO(COMENTARIO_ID),
    CONSTRAINT COMENTARIO_CONTENIDO_MULTIMEDIA_ID_FK FOREIGN KEY (CONTENIDO_MULTIMEDIA_ID)
    REFERENCES admin_multimedia.CONTENIDO_MULTIMEDIA(CONTENIDO_MULTIMEDIA_ID),
    CONSTRAINT COMENTARIO_USUARIO_ID_FK FOREIGN KEY (USUARIO_ID)
    REFERENCES admin_usuario.USUARIO(USUARIO_ID)
)
TABLESPACE multimediaTbs
;


-- 
-- TABLE: admin_multimedia.CONTENIDO_MULTIMEDIA_AUTOR 
--

CREATE TABLE admin_multimedia.CONTENIDO_MULTIMEDIA_AUTOR(
    CONTENIDO_MULTIMEDIA_AUTOR_ID    NUMBER(10, 0)    NOT NULL,
    PORCENTAJE_PARTICIPACION         NUMBER(3, 2)     NOT NULL,
    AUTOR_ID                         NUMBER(10, 0)    NOT NULL,
    CONTENIDO_MULTIMEDIA_ID          NUMBER(10, 0)    NOT NULL,
    CONSTRAINT CONTENIDO_MULTIMEDIA_AUTOR_PORCENTAJE_CHK CHECK (PORCENTAJE_PARTICIPACION <= 100.00 AND PORCENTAJE_PARTICIPACION >= 0.00),
    CONSTRAINT CONTENIDO_MULTIMEDIA_AUTOR_PK PRIMARY KEY (CONTENIDO_MULTIMEDIA_AUTOR_ID), 
    CONSTRAINT CONTENIDO_MULTIMEDIA_AUTOR_AUTOR_ID_FK FOREIGN KEY (AUTOR_ID)
    REFERENCES admin_multimedia.AUTOR(AUTOR_ID),
    CONSTRAINT CONTENIDO_MULTIMEDIA_AUTOR_CONTENIDO_MULTIMEDIA_ID_FK FOREIGN KEY (CONTENIDO_MULTIMEDIA_ID)
    REFERENCES admin_multimedia.CONTENIDO_MULTIMEDIA(CONTENIDO_MULTIMEDIA_ID)
)
TABLESPACE multimediaTbs
;



-- 
-- TABLE: admin_multimedia.CONTENIDO_SECCION 
--

CREATE TABLE admin_multimedia.CONTENIDO_SECCION(
    CONTENIDO_SECCION_ID       CHAR(10)         NOT NULL,
    ID_SECUENCIA               CHAR(16)         NOT NULL,
    CONTENIDO                  BLOB             NOT NULL,
    CONTENIDO_MULTIMEDIA_ID    NUMBER(10, 0)    NOT NULL,
    CONSTRAINT CONTENIDO_SECCION_PK PRIMARY KEY (CONTENIDO_SECCION_ID), 
    CONSTRAINT CONTENIDO_SECCION_CONTENIDO_MULTIMEDIA_ID_FK FOREIGN KEY (CONTENIDO_MULTIMEDIA_ID)
    REFERENCES admin_multimedia.CONTENIDO_MULTIMEDIA(CONTENIDO_MULTIMEDIA_ID)
)
TABLESPACE multimediaTbs
LOB(CONTENIDO) STORE AS CONTENIDO_SECCION_BLOB (TABLESPACE multimediaObjTbs CHUNK 8000 NOCACHE LOGGING)
;



-- 
-- TABLE: admin_usuario.PLAYLIST 
--

CREATE TABLE admin_usuario.PLAYLIST(
    PLAYLIST_ID           NUMBER(10, 0)    NOT NULL,
    NOMBRE                VARCHAR2(40)     NOT NULL,
    USUARIO_CREADOR_ID    NUMBER(10, 0)    NOT NULL,
    CONSTRAINT PLAYLIST_PK PRIMARY KEY (PLAYLIST_ID), 
    CONSTRAINT PLAYLIST_USUARIO_CREADOR_ID_FK FOREIGN KEY (USUARIO_CREADOR_ID)
    REFERENCES admin_usuario.USUARIO(USUARIO_ID)
)
TABLESPACE usersTbs
;



-- 
-- TABLE: admin_multimedia.PLAYLIST_CONTENIDO 
--

CREATE TABLE admin_multimedia.PLAYLIST_CONTENIDO(
    PLAYLIST_CONTENIDO_ID      NUMBER(10, 0)    NOT NULL,
    PLAYLIST_ID                NUMBER(10, 0)    NOT NULL,
    CONTENIDO_MULTIMEDIA_ID    NUMBER(10, 0)    NOT NULL,
    CONSTRAINT PLAYLIST_CONTENIDO_PK PRIMARY KEY (PLAYLIST_CONTENIDO_ID), 
    CONSTRAINT PLAYLIST_CONTENIDO_CONTENIDO_MULTIMEDIA_ID_FK FOREIGN KEY (CONTENIDO_MULTIMEDIA_ID)
    REFERENCES admin_multimedia.CONTENIDO_MULTIMEDIA(CONTENIDO_MULTIMEDIA_ID),
    CONSTRAINT PLAYLIST_CONTENIDO_PLAYLIST_ID_FK FOREIGN KEY (PLAYLIST_ID)
    REFERENCES admin_usuario.PLAYLIST(PLAYLIST_ID)
)
TABLESPACE multimediaTbs
;



-- 
-- TABLE: admin_usuario.DISPOSITIVO 
--

CREATE TABLE admin_usuario.DISPOSITIVO(
    DISPOSITIVO_ID       NUMBER(10, 0)    NOT NULL,
    TIPO                 VARCHAR2(40)     NOT NULL,
    IP                   VARCHAR2(16),
    SISTEMA_OPERATIVO    VARCHAR2(40)     NOT NULL,
    nombre               VARCHAR2(40)     NOT NULL,
    MARCA                VARCHAR2(40)     NOT NULL,
    USUARIO_ID           NUMBER(10, 0)    NOT NULL,
    CONSTRAINT DISPOSITIVO_PK PRIMARY KEY (DISPOSITIVO_ID), 
    CONSTRAINT DISPOSITIVO_USUARIO_ID_FK FOREIGN KEY (USUARIO_ID)
    REFERENCES admin_usuario.USUARIO(USUARIO_ID)
)
TABLESPACE usersTbs
;

grant select on admin_usuario.DISPOSITIVO to admin_multimedia;

-- 
-- TABLE: admin_multimedia.REPRODUCCION 
--

CREATE TABLE admin_multimedia.REPRODUCCION(
    REPRODUCCION_ID            NUMBER(10, 0)    NOT NULL,
    HORA_INICIO                TIMESTAMP(6)     NOT NULL,
    HORA_FIN                   TIMESTAMP(6)     NOT NULL,
    FECHA_REPRODUCCION         TIMESTAMP(6)     NOT NULL,
    DISPOSITIVO                VARCHAR2(40)     NOT NULL,
    VELOCIDAD_DESCARGA         NUMBER(10, 2)    NOT NULL,
    VELOCIDAD_CARGA            NUMBER(10, 2)    NOT NULL,
    LATITUD                    NUMBER(11, 8),
    LONGITUD                   NUMBER(11, 8),
    CONTENIDO_MULTIMEDIA_ID    NUMBER(10, 0)    NOT NULL,
    DISPOSITIVO_ID             NUMBER(10, 0)    NOT NULL,
    CONSTRAINT REPRODUCCION_PERIODO_CHK CHECK (HORA_INICIO > HORA_FIN),
    CONSTRAINT REPRODUCCION_PK PRIMARY KEY (REPRODUCCION_ID), 
    CONSTRAINT REPRODUCCION_CONTENIDO_MULTIMEDIA_ID_FK FOREIGN KEY (CONTENIDO_MULTIMEDIA_ID)
    REFERENCES admin_multimedia.CONTENIDO_MULTIMEDIA(CONTENIDO_MULTIMEDIA_ID),
    CONSTRAINT REPRODUCCION_DISPOSITIVO_ID_FK FOREIGN KEY (DISPOSITIVO_ID)
    REFERENCES admin_usuario.DISPOSITIVO(DISPOSITIVO_ID)
)
TABLESPACE multimediaTbs
;



-- 
-- TABLE: admin_multimedia.VIDEO 
--

CREATE TABLE admin_multimedia.VIDEO(
    CONTENIDO_MULTIMEDIA_ID    NUMBER(10, 0)    NOT NULL,
    TIPO_VIDEO                 VARCHAR2(40)     NOT NULL,
    CLASIFICACION              CHAR(1)          NOT NULL,
    CODIFICACION               VARCHAR2(40),
    TIPO_TRANSPORTE            VARCHAR2(40),
    CONSTRAINT VIDEO_PK PRIMARY KEY (CONTENIDO_MULTIMEDIA_ID), 
    CONSTRAINT VIDEO_CONTENIDO_MULTIMEDIA_ID_FK FOREIGN KEY (CONTENIDO_MULTIMEDIA_ID)
    REFERENCES admin_multimedia.CONTENIDO_MULTIMEDIA(CONTENIDO_MULTIMEDIA_ID)
)
TABLESPACE multimediaTbs
;



-- 
-- TABLE: admin_usuario.TARJETA 
--

CREATE TABLE admin_usuario.TARJETA(
    PLAYLIST_ID         NUMBER(10, 0)    NOT NULL,
    NUMERO              CHAR(16)         NOT NULL,
    TIPO                VARCHAR2(40)     NOT NULL,
    NUMERO_SEGURIDAD    CHAR(3)          NOT NULL,
    FECHA_VIGENCIA      DATE             NOT NULL,
    USUARIO_ID          NUMBER(10, 0)    NOT NULL,
    CONSTRAINT TARJETA_PK PRIMARY KEY (PLAYLIST_ID), 
    CONSTRAINT TARJETA_USUARIO_ID_FK FOREIGN KEY (USUARIO_ID)
    REFERENCES admin_usuario.USUARIO(USUARIO_ID)
)
TABLESPACE usersPayTbs
;



-- 
-- TABLE: admin_usuario.CARGO_TARJETA 
--

CREATE TABLE admin_usuario.CARGO_TARJETA(
    CARGO_TARJETA_ID    NUMBER(10, 0)    NOT NULL,
    FECHA_CARGO         TIMESTAMP(6)     NOT NULL,
    FOLIO               CHAR(12)         NOT NULL,
    IMPORTE             NUMBER(10, 2)    NOT NULL,
    TARJETA_ID          NUMBER(10, 0)    NOT NULL,
    CONSTRAINT CARGO_TARJETA_PK PRIMARY KEY (CARGO_TARJETA_ID), 
    CONSTRAINT CARGO_TARJETA_TARJETA_ID_FK FOREIGN KEY (TARJETA_ID)
    REFERENCES admin_usuario.TARJETA(PLAYLIST_ID)
)
TABLESPACE usersPayTbs
;



-- 
-- TABLE: admin_usuario.COSTO_VIGENTE_HISTORICO 
--

CREATE TABLE admin_usuario.COSTO_VIGENTE_HISTORICO(
    COSTO_VIGENTE_HISTORICO_ID    NUMBER(10, 0)    NOT NULL,
    COSTO                         NUMBER(10, 2)    NOT NULL,
    FECHA_INICIO                  DATE             NOT NULL,
    FECHA_FIN                     DATE             NOT NULL,
    PLAN_SUSCRIPCION_ID           NUMBER(10, 0)    NOT NULL,
    CONSTRAINT COSTO_VIGENTE_HISTORICO_PRECIO_CHK CHECK (COSTO >= 0),
    CONSTRAINT COSTO_VIGENTE_HISTORICO_PERIODO_CHK CHECK (FECHA_INICIO < FECHA_FIN),
    CONSTRAINT COSTO_VIGENTE_HISTORICO_PK PRIMARY KEY (COSTO_VIGENTE_HISTORICO_ID), 
    CONSTRAINT COSTO_VIGENTE_HISTORICO_PLAN_SUSCRIPCION_ID_FK FOREIGN KEY (PLAN_SUSCRIPCION_ID)
    REFERENCES admin_usuario.PLAN_SUSCRIPCION(PLAN_SUSCRIPCION_ID)
)
TABLESPACE usersTbs
;



-- 
-- TABLE: admin_usuario.CUENTA_USUARIO 
--

CREATE TABLE admin_usuario.CUENTA_USUARIO(
    CUENTA_USUARIO_ID         CHAR(10)         NOT NULL,
    USUARIO_PROPIETARIO_ID    NUMBER(10, 0)    NOT NULL,
    USUARIO_ID                NUMBER(10, 0)    NOT NULL,
    CONSTRAINT CUENTA_USUARIO_PK PRIMARY KEY (CUENTA_USUARIO_ID), 
    CONSTRAINT CUENTA_USUARIO_USUARIO_ID_FK FOREIGN KEY (USUARIO_ID)
    REFERENCES admin_usuario.USUARIO(USUARIO_ID),
    CONSTRAINT CUENTA_USUARIO_USUARIO_PROPIETARIO_ID_FK FOREIGN KEY (USUARIO_PROPIETARIO_ID)
    REFERENCES admin_usuario.USUARIO(USUARIO_ID)
)
TABLESPACE usersTbs
;



-- 
-- TABLE: admin_usuario.PLAYLIST_USUARIO 
--

CREATE TABLE admin_usuario.PLAYLIST_USUARIO(
    PLAYLIST_USUARIO_ID    CHAR(10)         NOT NULL,
    USUARIO_ID             NUMBER(10, 0)    NOT NULL,
    PLAYLIST_ID            NUMBER(10, 0)    NOT NULL,
    CONSTRAINT PLAYLIST_USUARIO_PK PRIMARY KEY (PLAYLIST_USUARIO_ID), 
    CONSTRAINT PLAYLIST_USUARIO_PLAYLIST_ID_FK FOREIGN KEY (PLAYLIST_ID)
    REFERENCES admin_usuario.PLAYLIST(PLAYLIST_ID),
    CONSTRAINT PLAYLIST_USUARIO_USUARIO_ID_FK FOREIGN KEY (USUARIO_ID)
    REFERENCES admin_usuario.USUARIO(USUARIO_ID)
)
TABLESPACE usersTbs
;



-- 
-- INDEX: admin_multimedia.AUDIO_CONTENIDO_MULTIMEDIA_ID_FK
--

CREATE INDEX admin_multimedia.AUDIO_CONTENIDO_MULTIMEDIA_ID_FK ON admin_multimedia.AUDIO(CONTENIDO_MULTIMEDIA_ID)
;
-- 
-- INDEX: admin_multimedia.AUTOR_NOMBRE_REAL_ARTISTICO_IUK 
--

CREATE UNIQUE INDEX admin_multimedia.AUTOR_NOMBRE_REAL_ARTISTICO_IUK ON admin_multimedia.AUTOR(NOMBRE, APELLIDOS, NOMBRE_ARTISTICO)
TABLESPACE indexesTbs
;
-- 
-- INDEX: admin_multimedia.COMENTARIO_CONTENIDO_MULTIMEDIA_ID_FK 
--

CREATE INDEX admin_multimedia.COMENTARIO_CONTENIDO_MULTIMEDIA_ID_FK ON admin_multimedia.COMENTARIO(CONTENIDO_MULTIMEDIA_ID)
;
-- 
-- INDEX: admin_multimedia.COMENTARIO_USUARIO_ID_FK 
--

CREATE INDEX admin_multimedia.COMENTARIO_USUARIO_ID_FK ON admin_multimedia.COMENTARIO(USUARIO_ID)
;
-- 
-- INDEX: admin_multimedia.COMENTARIO_COMENTARIO_RESPUESTA_ID_FK 
--

CREATE INDEX admin_multimedia.COMENTARIO_COMENTARIO_RESPUESTA_ID_FK ON admin_multimedia.COMENTARIO(COMENTARIO_RESPUESTA_ID)
;
-- 
-- INDEX: admin_multimedia.COMENTARIO_USUARIO_CONTENIDO_IX 
--

CREATE INDEX admin_multimedia.COMENTARIO_USUARIO_CONTENIDO_IX ON admin_multimedia.COMENTARIO(USUARIO_ID, CONTENIDO_MULTIMEDIA_ID)
TABLESPACE indexesTbs
;
-- 
-- INDEX: admin_multimedia.COMENTARIO_USUARIO_RESPUESTA_IX 
--

CREATE INDEX admin_multimedia.COMENTARIO_USUARIO_RESPUESTA_IX ON admin_multimedia.COMENTARIO(COMENTARIO_RESPUESTA_ID)
TABLESPACE indexesTbs
;
-- 
-- INDEX: admin_multimedia.CONTENIDO_MULTIMEDIA_GENERO_ID_FK 
--

CREATE INDEX admin_multimedia.CONTENIDO_MULTIMEDIA_GENERO_ID_FK ON admin_multimedia.CONTENIDO_MULTIMEDIA(GENERO_ID)
;
-- 
-- INDEX: admin_multimedia.CONTENIDO_MULTIMEDIA_CLAVE_IUK 
--

CREATE UNIQUE INDEX admin_multimedia.CONTENIDO_MULTIMEDIA_CLAVE_IUK ON admin_multimedia.CONTENIDO_MULTIMEDIA(CLAVE)
TABLESPACE indexesTbs
;
-- 
-- INDEX: admin_multimedia.CONTENIDO_MULTIMEDIA_NOMBRE_IUK 
--

CREATE INDEX admin_multimedia.CONTENIDO_MULTIMEDIA_NOMBRE_IUK ON admin_multimedia.CONTENIDO_MULTIMEDIA(NOMBRE)
TABLESPACE indexesTbs
;
-- 
-- INDEX: admin_multimedia.CONTENIDO_MULTIMEDIA_AUTOR_AUTOR_ID_FK 
--

CREATE INDEX admin_multimedia.CONTENIDO_MULTIMEDIA_AUTOR_AUTOR_ID_FK ON admin_multimedia.CONTENIDO_MULTIMEDIA_AUTOR(AUTOR_ID)
;
-- 
-- INDEX: admin_multimedia.CONTENIDO_MULTIMEDIA_AUTOR_CONTENIDO_MULTIMEDIA_ID_FK 
--

CREATE INDEX admin_multimedia.CONTENIDO_MULTIMEDIA_AUTOR_CONTENIDO_MULTIMEDIA_ID_FK ON admin_multimedia.CONTENIDO_MULTIMEDIA_AUTOR(CONTENIDO_MULTIMEDIA_ID)
;
-- 
-- INDEX: admin_multimedia.CONTENIDO_MULTIMEDIA_AUTOR_AUTOR_CONTENIDO_IUK 
--

CREATE UNIQUE INDEX admin_multimedia.CONTENIDO_MULTIMEDIA_AUTOR_AUTOR_CONTENIDO_IUK ON admin_multimedia.CONTENIDO_MULTIMEDIA_AUTOR(AUTOR_ID, CONTENIDO_MULTIMEDIA_ID)
TABLESPACE indexesTbs
;
-- 
-- INDEX: admin_multimedia.CONTENIDO_SECCION_CONTENIDO_MULTIMEDIA_ID_FK 
--

CREATE INDEX admin_multimedia.CONTENIDO_SECCION_CONTENIDO_MULTIMEDIA_ID_FK ON admin_multimedia.CONTENIDO_SECCION(CONTENIDO_MULTIMEDIA_ID)
;
-- 
-- INDEX: admin_multimedia.CONTENIDO_SECCION_SECUENCIA_CONTENIDO_IUK 
--

CREATE UNIQUE INDEX admin_multimedia.CONTENIDO_SECCION_SECUENCIA_CONTENIDO_IUK ON admin_multimedia.CONTENIDO_SECCION(ID_SECUENCIA, CONTENIDO_MULTIMEDIA_ID)
TABLESPACE indexesTbs
;
-- 
-- INDEX: admin_multimedia.GENERO_NOMBRE_IUK 
--

CREATE UNIQUE INDEX admin_multimedia.GENERO_NOMBRE_IUK ON admin_multimedia.GENERO(NOMBRE)
TABLESPACE indexesTbs
;
-- 
-- INDEX: admin_multimedia.PLAYLIST_CONTENIDO_PLAYLIST_ID_FK 
--

CREATE INDEX admin_multimedia.PLAYLIST_CONTENIDO_PLAYLIST_ID_FK ON admin_multimedia.PLAYLIST_CONTENIDO(PLAYLIST_ID)
;
-- 
-- INDEX: admin_multimedia.PLAYLIST_CONTENIDO_CONTENIDO_MULTIMEDIA_ID_FK 
--

CREATE INDEX admin_multimedia.PLAYLIST_CONTENIDO_CONTENIDO_MULTIMEDIA_ID_FK ON admin_multimedia.PLAYLIST_CONTENIDO(CONTENIDO_MULTIMEDIA_ID)
;
-- 
-- INDEX: admin_multimedia.REPRODUCCION_CONTENIDO_MULTIMEDIA_ID_FK 
--

CREATE INDEX admin_multimedia.REPRODUCCION_CONTENIDO_MULTIMEDIA_ID_FK ON admin_multimedia.REPRODUCCION(CONTENIDO_MULTIMEDIA_ID)
;
-- 
-- INDEX: admin_multimedia.REPRODUCCION_DISPOSITIVO_ID_FK 
--

CREATE INDEX admin_multimedia.REPRODUCCION_DISPOSITIVO_ID_FK ON admin_multimedia.REPRODUCCION(DISPOSITIVO_ID)
;
-- 
-- INDEX: admin_multimedia.REPRODUCCION_DISPOSITIVO_CONTENIDO_IX 
--

CREATE INDEX admin_multimedia.REPRODUCCION_DISPOSITIVO_CONTENIDO_IX ON admin_multimedia.REPRODUCCION(DISPOSITIVO_ID, CONTENIDO_MULTIMEDIA_ID)
TABLESPACE indexesTbs
;
-- 
-- INDEX: admin_multimedia.VIDEO_CONTENIDO_MULTIMEDIA_ID_FK
--

CREATE INDEX admin_multimedia.VIDEO_CONTENIDO_MULTIMEDIA_ID_FK ON admin_multimedia.VIDEO(CONTENIDO_MULTIMEDIA_ID)
;
-- 
-- INDEX: admin_usuario.CARGO_TARJETA_TARJETA_ID_FK 
--

CREATE UNIQUE INDEX admin_usuario.CARGO_TARJETA_TARJETA_ID_FK ON admin_usuario.CARGO_TARJETA(TARJETA_ID, FOLIO)
;
-- 
-- INDEX: admin_usuario.CARGO_TARJETA_FOLIO_IUK 
--

CREATE UNIQUE INDEX admin_usuario.CARGO_TARJETA_FOLIO_IUK ON admin_usuario.CARGO_TARJETA(FOLIO)
TABLESPACE indexesTbs
;
-- 
-- INDEX: admin_usuario.COSTO_VIGENTE_HISTORICO_PLAN_SUSCRIPCION_ID_FK 
--

CREATE INDEX admin_usuario.COSTO_VIGENTE_HISTORICO_PLAN_SUSCRIPCION_ID_FK ON admin_usuario.COSTO_VIGENTE_HISTORICO(PLAN_SUSCRIPCION_ID)
;
-- 
-- INDEX: admin_usuario.COSTO_VIGENTE_HISTORICO_VIGENCIA_IUK 
--

CREATE UNIQUE INDEX admin_usuario.COSTO_VIGENTE_HISTORICO_VIGENCIA_IUK ON admin_usuario.COSTO_VIGENTE_HISTORICO(PLAN_SUSCRIPCION_ID, FECHA_FIN, FECHA_INICIO)
TABLESPACE indexesTbs
;
-- 
-- INDEX: admin_usuario.CUENTA_USUARIO_USUARIO_ID_FK 
--

CREATE INDEX admin_usuario.CUENTA_USUARIO_USUARIO_ID_FK ON admin_usuario.CUENTA_USUARIO(USUARIO_ID)
;
-- 
-- INDEX: admin_usuario.CUENTA_USUARIO_USUARIO_PROPIETARIO_ID_FK 
--

CREATE INDEX admin_usuario.CUENTA_USUARIO_USUARIO_PROPIETARIO_ID_FK ON admin_usuario.CUENTA_USUARIO(USUARIO_PROPIETARIO_ID)
;
-- 
-- INDEX: admin_usuario.CUENTA_USUARIO_CUENTA_COMPARTIDA_IUK 
--

CREATE UNIQUE INDEX admin_usuario.CUENTA_USUARIO_CUENTA_COMPARTIDA_IUK ON admin_usuario.CUENTA_USUARIO(USUARIO_PROPIETARIO_ID, USUARIO_ID)
TABLESPACE indexesTbs
;
-- 
-- INDEX: admin_usuario.DISPOSITIVO_USUARIO_ID_FK 
--

CREATE INDEX admin_usuario.DISPOSITIVO_USUARIO_ID_FK ON admin_usuario.DISPOSITIVO(USUARIO_ID)
;
-- 
-- INDEX: admin_usuario.DISPOSITIVO_USUARIO_IX 
--

CREATE INDEX admin_usuario.DISPOSITIVO_USUARIO_IX ON admin_usuario.DISPOSITIVO(USUARIO_ID)
TABLESPACE indexesTbs
;
-- 
-- INDEX: admin_usuario.PLAN_SUSCRIPCION_DATOS_IUK 
--

CREATE UNIQUE INDEX admin_usuario.PLAN_SUSCRIPCION_DATOS_IUK ON admin_usuario.PLAN_SUSCRIPCION(CLAVE, NOMBRE)
TABLESPACE indexesTbs
;
-- 
-- INDEX: admin_usuario.PLAYLIST_USUARIO_CREADOR_ID_FK 
--

CREATE INDEX admin_usuario.PLAYLIST_USUARIO_CREADOR_ID_FK ON admin_usuario.PLAYLIST(USUARIO_CREADOR_ID)
;
-- 
-- INDEX: admin_usuario.PLAYLIST_NOMBRE_USUARIO_IUK 
--

CREATE UNIQUE INDEX admin_usuario.PLAYLIST_NOMBRE_USUARIO_IUK ON admin_usuario.PLAYLIST(NOMBRE, USUARIO_CREADOR_ID)
TABLESPACE indexesTbs
;
-- 
-- INDEX: admin_usuario.PLAYLIST_USUARIO_USUARIO_ID_FK 
--

CREATE INDEX admin_usuario.PLAYLIST_USUARIO_USUARIO_ID_FK ON admin_usuario.PLAYLIST_USUARIO(USUARIO_ID)
;
-- 
-- INDEX: admin_usuario.PLAYLIST_USUARIO_PLAYLIST_ID_FK 
--

CREATE INDEX admin_usuario.PLAYLIST_USUARIO_PLAYLIST_ID_FK ON admin_usuario.PLAYLIST_USUARIO(PLAYLIST_ID)
;
-- 
-- INDEX: admin_usuario.PLAYLIST_USUARIO_USUARIO_PLAYLIST_IUK 
--

CREATE UNIQUE INDEX admin_usuario.PLAYLIST_USUARIO_USUARIO_PLAYLIST_IUK ON admin_usuario.PLAYLIST_USUARIO(USUARIO_ID, PLAYLIST_ID)
TABLESPACE indexesTbs
;
-- 
-- INDEX: admin_usuario.TARJETA_USUARIO_ID_FK 
--

CREATE INDEX admin_usuario.TARJETA_USUARIO_ID_FK ON admin_usuario.TARJETA(USUARIO_ID)
;
-- 
-- INDEX: admin_usuario.TARJETA_USUARIO_NUMERO_IUK 
--

CREATE UNIQUE INDEX admin_usuario.TARJETA_USUARIO_NUMERO_IUK ON admin_usuario.TARJETA(USUARIO_ID, NUMERO)
TABLESPACE indexesTbs
;
-- 
-- INDEX: admin_usuario.USUARIO_PLAN_SUSCRIPCION_ID_FK 
--

CREATE INDEX admin_usuario.USUARIO_PLAN_SUSCRIPCION_ID_FK ON admin_usuario.USUARIO(PLAN_SUSCRIPCION_ID)
;
-- 
-- INDEX: admin_usuario.USUARIO_USERNAME_IUK 
--

CREATE UNIQUE INDEX admin_usuario.USUARIO_USERNAME_IUK ON admin_usuario.USUARIO(USERNAME)
TABLESPACE indexesTbs
;