-- ============================================================
--  Modelo Relacional - Gobierno de Datos
--  Script de creación de tablas (DDL)
-- ============================================================

-- ------------------------------------------------------------
-- 1. ACTORES Y SUJETOS
-- ------------------------------------------------------------
CREATE TABLE SUJETO (
    id_sujeto   INT         NOT NULL,
    tipo_sujeto VARCHAR(50) NOT NULL,
	formacion    VARCHAR(20)  NOT NULL,
    CONSTRAINT PK_SUJETO PRIMARY KEY (id_sujeto)
);

CREATE TABLE ESPECIALIDAD (
    id_especialidad INT          NOT NULL,
    nombre          VARCHAR(100) NOT NULL,
    descripcion     TEXT,
    CONSTRAINT PK_ESPECIALIDAD PRIMARY KEY (id_especialidad)
);

CREATE TABLE PROFESIONAL (
    id_sujeto       INT NOT NULL,
    id_especialidad INT NOT NULL,
    CONSTRAINT PK_PROFESIONAL    PRIMARY KEY (id_sujeto),
    CONSTRAINT FK_PROF_SUJETO    FOREIGN KEY (id_sujeto)       REFERENCES SUJETO(id_sujeto),
    CONSTRAINT FK_PROF_ESPEC     FOREIGN KEY (id_especialidad) REFERENCES ESPECIALIDAD(id_especialidad)
);

CREATE TABLE PUESTO_TRABAJO (
    id_puesto_trabajo INT          NOT NULL,
    nombre            VARCHAR(100) NOT NULL,
    CONSTRAINT PK_PUESTO_TRABAJO PRIMARY KEY (id_puesto_trabajo)
);

CREATE TABLE MIEMBRO_UO (
    id_sujeto         INT          NOT NULL,
    email_corporativo VARCHAR(150) NOT NULL,
    fecha_ingreso     DATE         NOT NULL,
    fecha_salida      DATE,
    id_puesto_trabajo INT          NOT NULL,
    CONSTRAINT PK_MIEMBRO_UO PRIMARY KEY (id_sujeto),
    CONSTRAINT FK_MUO_SUJETO FOREIGN KEY (id_sujeto) REFERENCES SUJETO(id_sujeto),
    CONSTRAINT FK_MUO_PUESTO FOREIGN KEY (id_puesto_trabajo) REFERENCES PUESTO_TRABAJO(id_puesto_trabajo),
    CONSTRAINT UQ_MUO_EMAIL  UNIQUE (email_corporativo),
    CONSTRAINT CK_MUO_FECHAS CHECK (fecha_ingreso <= fecha_salida) 
);

CREATE TABLE EXTERNO (
    id_sujeto      INT          NOT NULL,
    email_contacto VARCHAR(150) NOT NULL,
    CONSTRAINT PK_EXTERNO    PRIMARY KEY (id_sujeto),
    CONSTRAINT FK_EXT_SUJETO FOREIGN KEY (id_sujeto) REFERENCES SUJETO(id_sujeto),
    CONSTRAINT UQ_EXT_EMAIL  UNIQUE (email_contacto)
);

CREATE TABLE ORGANIZACION (
    id_sujeto           INT          NOT NULL,
    nombre              VARCHAR(150) NOT NULL,
    cuit                VARCHAR(20)  NOT NULL,
    telefono            VARCHAR(30),
    fecha_alta_relacion DATE         NOT NULL,
    CONSTRAINT PK_ORGANIZACION PRIMARY KEY (id_sujeto),
    CONSTRAINT FK_ORG_SUJETO   FOREIGN KEY (id_sujeto) REFERENCES SUJETO(id_sujeto),
    CONSTRAINT UQ_ORG_CUIT     UNIQUE (cuit),     
    CONSTRAINT UQ_ORG_TEL      UNIQUE (telefono)  
);

-- ------------------------------------------------------------
-- 2. ORGANIZACIÓN Y EQUIPOS
-- ------------------------------------------------------------
CREATE TABLE DEPARTAMENTO (
    id_departamento INT          NOT NULL,
    nombre          VARCHAR(100) NOT NULL,
    CONSTRAINT PK_DEPARTAMENTO PRIMARY KEY (id_departamento)
);

CREATE TABLE EQUIPO (
    id_equipo       INT          NOT NULL,
    nombre          VARCHAR(100) NOT NULL,
    id_departamento INT          NOT NULL,
    CONSTRAINT PK_EQUIPO   PRIMARY KEY (id_equipo),
    CONSTRAINT FK_EQ_DEPTO FOREIGN KEY (id_departamento) REFERENCES DEPARTAMENTO(id_departamento)
);

CREATE TABLE OPERACION (
    id_operacion    INT          NOT NULL,
    descripcion     TEXT,
    id_departamento INT          NOT NULL,
    CONSTRAINT PK_OPERACION PRIMARY KEY (id_operacion),
    CONSTRAINT FK_OP_DEPTO  FOREIGN KEY (id_departamento) REFERENCES DEPARTAMENTO(id_departamento)
);

CREATE TABLE PERTENECE_A_EQUIPO (
    id_sujeto   INT  NOT NULL,
    id_equipo   INT  NOT NULL,
    fecha_desde DATE NOT NULL,
    fecha_hasta DATE,
    CONSTRAINT PK_PERTENECE  PRIMARY KEY (id_sujeto, id_equipo, fecha_desde),
    CONSTRAINT FK_PE_SUJETO  FOREIGN KEY (id_sujeto) REFERENCES SUJETO(id_sujeto),
    CONSTRAINT FK_PE_EQUIPO  FOREIGN KEY (id_equipo) REFERENCES EQUIPO(id_equipo),
    CONSTRAINT CK_PE_FECHAS  CHECK (fecha_desde <= fecha_hasta) 
);

CREATE TABLE DIRIGE_EQUIPO (
    id_sujeto   INT  NOT NULL,
    id_equipo   INT  NOT NULL,
    fecha_desde DATE NOT NULL,
    fecha_hasta DATE,
    CONSTRAINT PK_DIRIGE     PRIMARY KEY (id_sujeto, id_equipo, fecha_desde),
    CONSTRAINT FK_DIR_SUJETO FOREIGN KEY (id_sujeto) REFERENCES SUJETO(id_sujeto),
    CONSTRAINT FK_DIR_EQUIPO FOREIGN KEY (id_equipo) REFERENCES EQUIPO(id_equipo),
    CONSTRAINT CK_DIR_FECHAS CHECK (fecha_desde <= fecha_hasta) 
);

-- ------------------------------------------------------------
-- 3. FUENTES DE DATOS, PERFILES Y ACCESOS
-- ------------------------------------------------------------
CREATE TABLE FUENTE_DE_DATOS (
    id_fuente   INT          NOT NULL,
    nombre      VARCHAR(100) NOT NULL,
    tipo_fuente VARCHAR(50),
    modelo      VARCHAR(100),
    CONSTRAINT PK_FUENTE PRIMARY KEY (id_fuente)
);

CREATE TABLE PERFIL (
    id_perfil   INT          NOT NULL,
    nombre      VARCHAR(100) NOT NULL,
    descripcion TEXT,
    CONSTRAINT PK_PERFIL PRIMARY KEY (id_perfil)
);

CREATE TABLE PERMISO (
    id_permiso  INT          NOT NULL,
    nombre      VARCHAR(100) NOT NULL,
    descripcion TEXT,
    CONSTRAINT PK_PERMISO PRIMARY KEY (id_permiso)
);

CREATE TABLE PERFIL_TIENE_PERMISO (
    id_perfil  INT NOT NULL,
    id_permiso INT NOT NULL,
    CONSTRAINT PK_PERFIL_PERMISO PRIMARY KEY (id_perfil, id_permiso),
    CONSTRAINT FK_PTP_PERFIL     FOREIGN KEY (id_perfil)  REFERENCES PERFIL(id_perfil),
    CONSTRAINT FK_PTP_PERMISO    FOREIGN KEY (id_permiso) REFERENCES PERMISO(id_permiso)
);

CREATE TABLE ROL (
    id_rol INT          NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    CONSTRAINT PK_ROL PRIMARY KEY (id_rol)
);

CREATE TABLE ACCESO_FUENTE_DATOS (
    id_sujeto   INT  NOT NULL,
    id_fuente   INT  NOT NULL,
    fecha_desde DATE NOT NULL,
    fecha_hasta DATE,
    id_rol      INT  NOT NULL,
    id_perfil   INT NOT NULL,
    CONSTRAINT PK_ACCESO_FUENTE  PRIMARY KEY (id_sujeto, id_fuente, fecha_desde),
    CONSTRAINT FK_AFD_SUJETO     FOREIGN KEY (id_sujeto) REFERENCES SUJETO(id_sujeto),
    CONSTRAINT FK_AFD_FUENTE     FOREIGN KEY (id_fuente) REFERENCES FUENTE_DE_DATOS(id_fuente),
    CONSTRAINT FK_AFD_ROL        FOREIGN KEY (id_rol)    REFERENCES ROL(id_rol),
    CONSTRAINT FK_AFD_PERFIL     FOREIGN KEY (id_perfil) REFERENCES PERFIL(id_perfil),
    CONSTRAINT CK_AFD_FECHAS     CHECK (fecha_desde <= fecha_hasta) 
);

-- ------------------------------------------------------------
-- 4. INFRAESTRUCTURA Y UBICACIÓN
-- ------------------------------------------------------------
CREATE TABLE UBICACION (
    id_ubicacion INT NOT NULL,
	tipo_ubicacion VARCHAR(50) NOT NULL,
    CONSTRAINT PK_UBICACION PRIMARY KEY (id_ubicacion)
);

CREATE TABLE APLICACION (
    id_ubicacion INT         NOT NULL,
    version      VARCHAR(50),
    CONSTRAINT PK_APLICACION PRIMARY KEY (id_ubicacion),
    CONSTRAINT FK_APP_UBIC   FOREIGN KEY (id_ubicacion) REFERENCES UBICACION(id_ubicacion)
);

CREATE TABLE REGION (
    id_region INT          NOT NULL,
    nombre    VARCHAR(100) NOT NULL,
    CONSTRAINT PK_REGION PRIMARY KEY (id_region)
);

CREATE TABLE PAIS (
    id_pais   INT          NOT NULL,
    nombre    VARCHAR(100) NOT NULL,
    id_region INT          NOT NULL,
    CONSTRAINT PK_PAIS    PRIMARY KEY (id_pais),
    CONSTRAINT FK_PAI_REG FOREIGN KEY (id_region) REFERENCES REGION(id_region)
);

CREATE TABLE PROVINCIA (
    id_provincia INT          NOT NULL,
    nombre       VARCHAR(100) NOT NULL,
    id_pais      INT          NOT NULL,
    CONSTRAINT PK_PROVINCIA PRIMARY KEY (id_provincia),
    CONSTRAINT FK_PRO_PAI   FOREIGN KEY (id_pais) REFERENCES PAIS(id_pais)
);

CREATE TABLE LOCALIDAD (
    id_localidad INT          NOT NULL,
    nombre       VARCHAR(100) NOT NULL,
    id_provincia INT          NOT NULL,
    CONSTRAINT PK_LOCALIDAD PRIMARY KEY (id_localidad),
    CONSTRAINT FK_LOC_PRO   FOREIGN KEY (id_provincia) REFERENCES PROVINCIA(id_provincia)
);

CREATE TABLE CALLE (
    id_calle     INT          NOT NULL,
    nombre       VARCHAR(150) NOT NULL,
    id_localidad INT          NOT NULL,
    CONSTRAINT PK_CALLE   PRIMARY KEY (id_calle),
    CONSTRAINT FK_CAL_LOC FOREIGN KEY (id_localidad) REFERENCES LOCALIDAD(id_localidad)
);

CREATE TABLE DIRECCION_FISICA (
    id_ubicacion INT NOT NULL,
    numero       INT,
    id_calle     INT NOT NULL,
    CONSTRAINT PK_DIR_FISICA PRIMARY KEY (id_ubicacion),
    CONSTRAINT FK_DF_UBIC    FOREIGN KEY (id_ubicacion) REFERENCES UBICACION(id_ubicacion),
    CONSTRAINT FK_DF_CAL     FOREIGN KEY (id_calle)     REFERENCES CALLE(id_calle)
);

CREATE TABLE FUENTE_UBICADA_EN (
    id_fuente    INT NOT NULL,
    id_ubicacion INT NOT NULL,
    CONSTRAINT PK_FUENTE_UBICADA PRIMARY KEY (id_fuente, id_ubicacion),
    CONSTRAINT FK_FUE_FUE        FOREIGN KEY (id_fuente)    REFERENCES FUENTE_DE_DATOS(id_fuente),
    CONSTRAINT FK_FUE_UBIC       FOREIGN KEY (id_ubicacion) REFERENCES UBICACION(id_ubicacion)
);

CREATE TABLE NUBE_EN_REGION (
    id_region    INT NOT NULL,
    id_ubicacion INT NOT NULL,
    CONSTRAINT PK_NUBE_REGION PRIMARY KEY (id_region, id_ubicacion),
    CONSTRAINT FK_NER_REG     FOREIGN KEY (id_region)    REFERENCES REGION(id_region),
    CONSTRAINT FK_NER_UBIC    FOREIGN KEY (id_ubicacion) REFERENCES UBICACION(id_ubicacion)
);

-- ------------------------------------------------------------
-- 5. ACTIVOS, GLOSARIO, HERRAMIENTAS Y LINAJE
-- ------------------------------------------------------------
CREATE TABLE DEFINICION_FUNCIONAL (
    id_definicion INT          NOT NULL,
    nombre        VARCHAR(100) NOT NULL,
    descripcion   TEXT,
    CONSTRAINT PK_DEF_FUNC PRIMARY KEY (id_definicion)
);

CREATE TABLE PROVEEDOR (
    id_proveedor INT          NOT NULL,
    nombre       VARCHAR(100) NOT NULL,
    CONSTRAINT PK_PROVEEDOR PRIMARY KEY (id_proveedor)
);

CREATE TABLE HERRAMIENTA (
    id_herramienta   INT          NOT NULL,
    nombre           VARCHAR(100) NOT NULL,
    tipo_herramienta VARCHAR(50),
    id_proveedor     INT          NOT NULL,
    CONSTRAINT PK_HERRAMIENTA PRIMARY KEY (id_herramienta),
    CONSTRAINT FK_HER_PROV    FOREIGN KEY (id_proveedor) REFERENCES PROVEEDOR(id_proveedor)
);

CREATE TABLE LICENCIA (
    id_herramienta INT  NOT NULL,
    fecha_desde    DATE NOT NULL,
    fecha_hasta    DATE,
    CONSTRAINT PK_LICENCIA   PRIMARY KEY (id_herramienta),
    CONSTRAINT FK_LIC_HER    FOREIGN KEY (id_herramienta) REFERENCES HERRAMIENTA(id_herramienta),
    CONSTRAINT CK_LIC_FECHAS CHECK (fecha_desde <= fecha_hasta)
);

CREATE TABLE SOFTWARE (
    id_herramienta      INT NOT NULL,
    fecha_ultima_actualizacion DATE,
    CONSTRAINT PK_SOFTWARE PRIMARY KEY (id_herramienta),
    CONSTRAINT FK_SOF_HER  FOREIGN KEY (id_herramienta) REFERENCES HERRAMIENTA(id_herramienta)
);

CREATE TABLE HERRAMIENTA_OPEN_SOURCE (
    id_herramienta    INT NOT NULL,
    version           VARCHAR(50),
    fecha_instalacion DATE,
    CONSTRAINT PK_APP_OS  PRIMARY KEY (id_herramienta),
    CONSTRAINT FK_AOS_HER FOREIGN KEY (id_herramienta) REFERENCES HERRAMIENTA(id_herramienta)
);

CREATE TABLE FASE_VIDA_ACTIVO (
    id_fase INT          NOT NULL,
    nombre  VARCHAR(100) NOT NULL,
    CONSTRAINT PK_FASE_ACTIVO PRIMARY KEY (id_fase)
);

CREATE TABLE ACTIVO (
    id_activo     INT          NOT NULL,
    nombre        VARCHAR(150) NOT NULL,
    tipo_activo   VARCHAR(50)  NOT NULL,
    id_fase       INT          NOT NULL,
    id_definicion INT          NOT NULL,
    CONSTRAINT PK_ACTIVO   PRIMARY KEY (id_activo),
    CONSTRAINT FK_ACT_FASE FOREIGN KEY (id_fase)       REFERENCES FASE_VIDA_ACTIVO(id_fase),
    CONSTRAINT FK_ACT_DEF  FOREIGN KEY (id_definicion) REFERENCES DEFINICION_FUNCIONAL(id_definicion)
);

CREATE TABLE OBJETO (
    id_activo   INT         NOT NULL,
    tipo_objeto VARCHAR(50) NOT NULL,
    CONSTRAINT PK_OBJETO  PRIMARY KEY (id_activo),
    CONSTRAINT FK_OBJ_ACT FOREIGN KEY (id_activo) REFERENCES ACTIVO(id_activo)
);

CREATE TABLE REPORTE (
    id_activo      INT NOT NULL,
    formato_salida VARCHAR(50),
    CONSTRAINT PK_REPORTE PRIMARY KEY (id_activo),
    CONSTRAINT FK_REP_OBJ FOREIGN KEY (id_activo) REFERENCES OBJETO(id_activo)
);

CREATE TABLE TABLERO (
    id_activo  INT NOT NULL,
    url_acceso VARCHAR(255),
    CONSTRAINT PK_TABLERO PRIMARY KEY (id_activo),
    CONSTRAINT FK_TAB_OBJ FOREIGN KEY (id_activo) REFERENCES OBJETO(id_activo)
);

CREATE TABLE PROCESO (
    id_activo             INT NOT NULL,
    tiempo_maximo_minutos INT,
    CONSTRAINT PK_PROCESO PRIMARY KEY (id_activo),
    CONSTRAINT FK_PRO_OBJ FOREIGN KEY (id_activo) REFERENCES OBJETO(id_activo)
);

CREATE TABLE OPERACION_VINCULADA_ACTIVO (
    id_operacion INT NOT NULL,
    id_activo    INT NOT NULL,
    CONSTRAINT PK_OP_ACTIVO PRIMARY KEY (id_operacion, id_activo),
    CONSTRAINT FK_OVA_OP    FOREIGN KEY (id_operacion) REFERENCES OPERACION(id_operacion),
    CONSTRAINT FK_OVA_ACT   FOREIGN KEY (id_activo)    REFERENCES ACTIVO(id_activo)
);

CREATE TABLE HERRAMIENTA_GESTIONA_ACTIVO (
    id_activo      INT NOT NULL,
    id_herramienta INT NOT NULL,
    CONSTRAINT PK_HER_ACTIVO PRIMARY KEY (id_activo, id_herramienta),
    CONSTRAINT FK_HGA_ACT    FOREIGN KEY (id_activo)      REFERENCES ACTIVO(id_activo),
    CONSTRAINT FK_HGA_HER    FOREIGN KEY (id_herramienta) REFERENCES HERRAMIENTA(id_herramienta)
);

CREATE TABLE EQUIPO_TRABAJA_OBJETO (
    id_activo    INT  NOT NULL,
    id_equipo    INT  NOT NULL,
    fecha_acceso DATE NOT NULL,
    CONSTRAINT PK_EQ_OBJETO PRIMARY KEY (id_activo, id_equipo, fecha_acceso),
    CONSTRAINT FK_ETO_OBJ   FOREIGN KEY (id_activo) REFERENCES OBJETO(id_activo),
    CONSTRAINT FK_ETO_EQ    FOREIGN KEY (id_equipo) REFERENCES EQUIPO(id_equipo)
);

CREATE TABLE LINAJE_DATOS (
    id_activo_origen  INT NOT NULL,
    id_activo_destino INT NOT NULL,
    CONSTRAINT PK_LINAJE      PRIMARY KEY (id_activo_origen, id_activo_destino),
    CONSTRAINT FK_LIN_ORIGEN  FOREIGN KEY (id_activo_origen)  REFERENCES ACTIVO(id_activo),
    CONSTRAINT FK_LIN_DESTINO FOREIGN KEY (id_activo_destino) REFERENCES ACTIVO(id_activo),
    CONSTRAINT CK_LIN_ACICLICO CHECK (id_activo_origen <> id_activo_destino) 
);

-- ------------------------------------------------------------
-- 6. INCIDENTES
-- ------------------------------------------------------------
CREATE TABLE FUENTE_IMPACTA_OBJETO (
    id_fuente INT NOT NULL,
    id_activo INT NOT NULL,
    CONSTRAINT PK_FUENTE_IMPACTA PRIMARY KEY (id_fuente, id_activo),
    CONSTRAINT FK_FIO_FUE        FOREIGN KEY (id_fuente) REFERENCES FUENTE_DE_DATOS(id_fuente),
    CONSTRAINT FK_FIO_OBJ        FOREIGN KEY (id_activo) REFERENCES OBJETO(id_activo)
);

CREATE TABLE PROBLEMA (
    id_problema  INT         NOT NULL,
    descripcion  TEXT,
    fecha_origen DATE        NOT NULL,
    estado       VARCHAR(50) NOT NULL,
    id_fuente    INT         NOT NULL,
    id_activo    INT         NOT NULL,
    CONSTRAINT PK_PROBLEMA     PRIMARY KEY (id_problema),
    CONSTRAINT FK_PROB_IMPACTA FOREIGN KEY (id_fuente, id_activo) REFERENCES FUENTE_IMPACTA_OBJETO(id_fuente, id_activo)
);

CREATE TABLE PROBLEMA_RESUELTO (
    id_problema         INT  NOT NULL,
    fecha_resolucion    DATE NOT NULL,
    id_sujeto_resolutor INT  NOT NULL,
    id_equipo_resolutor INT  NOT NULL, 
    CONSTRAINT PK_PROB_RES PRIMARY KEY (id_problema),
    CONSTRAINT FK_PR_PROB  FOREIGN KEY (id_problema)         REFERENCES PROBLEMA(id_problema),
    CONSTRAINT FK_PR_SUJ   FOREIGN KEY (id_sujeto_resolutor) REFERENCES SUJETO(id_sujeto),
    CONSTRAINT FK_PR_EQ    FOREIGN KEY (id_equipo_resolutor) REFERENCES EQUIPO(id_equipo)
);