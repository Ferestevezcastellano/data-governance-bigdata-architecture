-- =============================================================
-- DML GOBIERNO DE DATOS
-- =============================================================
BEGIN TRANSACTION;
 
-- ============================================================
-- 1. PUESTO_TRABAJO
-- ============================================================
INSERT INTO PUESTO_TRABAJO (id_puesto_trabajo, nombre) VALUES
(1,  'Data Engineer'), (2,  'Data Analyst'), (3,  'Data Scientist'),
(4,  'Data Steward'), (5,  'Data Architect'), (6,  'Business Intelligence Analyst'),
(7,  'Database Administrator'), (8,  'Data Governance Lead'),
(9,  'Data Protection Officer (DPO)'), (10, 'Chief Data Officer');
 
-- ============================================================
-- 2. ROL
-- ============================================================
INSERT INTO ROL (id_rol, nombre) VALUES
(1, 'Data Owner'), (2, 'Data Custodian'), (3, 'Data Consumer'),
(4, 'Data Steward de Dominio'), (5, 'Auditor de Cumplimiento'),
(6, 'Data Operator');
 
-- ============================================================
-- 3. PERFIL
-- ============================================================
INSERT INTO PERFIL (id_perfil, nombre, descripcion) VALUES
(1, 'Lectura Total',      'Acceso de solo lectura a todos los objetos'),
(2, 'Lectura Restringida','Acceso de solo lectura a objetos no sensibles'),
(3, 'Escritura',          'Acceso de lectura y escritura'),
(4, 'Administración',     'Control total incluyendo permisos'),
(5, 'Auditoría',          'Acceso de lectura a logs y metadatos');
 
-- ============================================================
-- 4. PERMISO
-- ============================================================
INSERT INTO PERMISO (id_permiso, nombre, descripcion) VALUES
(1,  'SELECT',         'Permiso de consulta sobre tablas'),
(2,  'INSERT',         'Permiso de inserción de registros'),
(3,  'UPDATE',         'Permiso de actualización de registros'),
(4,  'DELETE',         'Permiso de eliminación de registros'),
(5,  'EXECUTE',        'Permiso de ejecución de procedimientos'),
(6,  'CREATE',         'Permiso de creación de objetos'),
(7,  'DROP',           'Permiso de eliminación de objetos'),
(8,  'GRANT',          'Permiso de concesión de privilegios'),
(9,  'VIEW_METADATA',  'Permiso de visualización de metadatos'),
(10, 'EXPORT',         'Permiso de exportación de datos');
 
-- ============================================================
-- 5. PERFIL_TIENE_PERMISO
-- ============================================================
INSERT INTO PERFIL_TIENE_PERMISO (id_perfil, id_permiso) VALUES
(1, 1),(1, 9),(1, 10),(2, 1),(2, 9),(3, 1),(3, 2),(3, 3),(3, 4),(3, 5),(3, 9),(3, 10),
(4, 1),(4, 2),(4, 3),(4, 4),(4, 5),(4, 6),(4, 7),(4, 8),(4, 9),(4, 10),
(5, 1),(5, 9);
 
-- ============================================================
-- 6. FASE_VIDA_ACTIVO
-- ============================================================
INSERT INTO FASE_VIDA_ACTIVO (id_fase, nombre) VALUES
(1, 'Create'), (2, 'Store'), (3, 'Use'),
(4, 'Share'), (5, 'Archive'), (6, 'Destroy');
 
-- ============================================================
-- 7. DEPARTAMENTO
-- ============================================================
INSERT INTO DEPARTAMENTO (id_departamento, nombre) VALUES
(1, 'Finanzas'), (2, 'IT'), (3, 'Marketing'),
(4, 'Operaciones'), (5, 'Recursos Humanos');
 
-- ============================================================
-- 8. EQUIPO
-- ============================================================
INSERT INTO EQUIPO (id_equipo, nombre, id_departamento) VALUES
(1,  'Contabilidad General',         1), (2,  'Control de Presupuesto',       1),
(3,  'Tesorería',                    1), (4,  'Auditoría Interna',            1),
(5,  'Infraestructura Cloud',        2), (6,  'Seguridad de la Información',  2),
(7,  'Desarrollo de Software',       2), (8,  'Datos e Inteligencia',         2),
(9,  'Soporte Técnico',              2), (10, 'Analítica de Clientes',        3),
(11, 'Campañas Digitales',           3), (12, 'Investigación de Mercado',     3),
(13, 'Gestión de Contenidos',        3), (14, 'Planificación Operativa',      4),
(15, 'Calidad y Procesos',           4), (16, 'Logística',                    4),
(17, 'Compras y Abastecimiento',     4), (18, 'Selección y Reclutamiento',    5),
(19, 'Capacitación y Desarrollo',    5), (20, 'Compensaciones y Beneficios',  5);
 
-- ============================================================
-- 9. ESPECIALIDAD
-- ============================================================
INSERT INTO ESPECIALIDAD (id_especialidad, nombre, descripcion) VALUES
(1,  'Ingeniería de Datos',       'Diseño y construcción de pipelines de datos'),
(2,  'Ciencia de Datos',          'Modelado estadístico y machine learning'),
(3,  'Business Intelligence',     'Reportería y visualización empresarial'),
(4,  'Arquitectura de Datos',     'Diseño de plataformas y modelos de datos'),
(5,  'Gobernanza de Datos',       'Políticas, calidad y gestión de datos'),
(6,  'Base de Datos',             'Administración y optimización de DBMS'),
(7,  'Cloud Computing',           'Servicios e infraestructura en nube'),
(8,  'Seguridad de Datos',        'Protección y cumplimiento normativo'),
(9,  'ETL / ELT',                 'Extracción, transformación y carga'),
(10, 'Analítica Avanzada',        'Técnicas avanzadas de análisis predictivo'),
(11, 'Finanzas Corporativas',     'Análisis y gestión financiera'),
(12, 'Marketing Digital',         'Estrategias de marketing online'),
(13, 'Recursos Humanos',          'Gestión del talento y cultura organizacional'),
(14, 'Operaciones y Procesos',    'Optimización de procesos operativos'),
(15, 'Auditoría y Compliance',    'Cumplimiento normativo y auditoría');
 
-- ============================================================
-- 10. REGION
-- ============================================================
INSERT INTO REGION (id_region, nombre) VALUES
(1, 'América del Sur'), (2, 'América del Norte'), (3, 'Europa');
 
-- ============================================================
-- 11. PAIS
-- ============================================================
INSERT INTO PAIS (id_pais, nombre, id_region) VALUES
(1, 'Argentina', 1), (2, 'Brasil', 1), (3, 'Chile', 1), (4, 'Colombia', 1),
(5, 'Uruguay', 1), (6, 'Estados Unidos', 2), (7, 'Canadá', 2), (8, 'México', 2),
(9, 'España', 3), (10, 'Alemania', 3);
 
-- ============================================================
-- 12. PROVINCIA
-- ============================================================
INSERT INTO PROVINCIA (id_provincia, nombre, id_pais) VALUES
(1, 'Buenos Aires', 1), (2, 'Córdoba', 1), (3, 'Santa Fe', 1), (4, 'Mendoza', 1), (5, 'Tucumán', 1),
(6, 'São Paulo', 2), (7, 'Rio de Janeiro', 2), (8, 'Minas Gerais', 2), (9, 'Bahia', 2), (10, 'Paraná', 2),
(11, 'Región Metropolitana',3), (12, 'Valparaíso', 3), (13, 'Biobío', 3), (14, 'Antofagasta', 3), (15, 'Araucanía', 3),
(16, 'Cundinamarca', 4), (17, 'Antioquia', 4), (18, 'Valle del Cauca', 4), (19, 'Atlántico', 4), (20, 'Santander', 4),
(21, 'Montevideo', 5), (22, 'California', 6), (23, 'Texas', 6), (24, 'New York', 6), (25, 'Ontario', 7),
(26, 'Ciudad de México', 8), (27, 'Jalisco', 8), (28, 'Madrid', 9), (29, 'Cataluña', 9), (30, 'Baviera', 10);
 
-- ============================================================
-- 13. LOCALIDAD
-- ============================================================
INSERT INTO LOCALIDAD (id_localidad, nombre, id_provincia) VALUES
(1, 'Ciudad Autónoma de Buenos Aires', 1), (2, 'La Plata', 1), (3, 'Mar del Plata', 1),
(4, 'Quilmes', 1), (5, 'San Isidro', 1), (6, 'Ciudad de Córdoba', 2), (7, 'Villa Carlos Paz', 2),
(8, 'Río Cuarto', 2), (9, 'Rosario', 3), (10, 'Santa Fe Capital', 3), (11, 'Ciudad de Mendoza', 4),
(12, 'San Rafael', 4), (13, 'San Miguel de Tucumán', 5), (14, 'São Paulo Capital', 6),
(15, 'Campinas', 6), (16, 'Santos', 6), (17, 'Rio de Janeiro Capital', 7), (18, 'Niterói', 7),
(19, 'Belo Horizonte', 8), (20, 'Salvador', 9), (21, 'Curitiba', 10), (22, 'Santiago', 11),
(23, 'Viña del Mar', 12), (24, 'Concepción', 13), (25, 'Antofagasta Capital', 14), (26, 'Temuco', 15),
(27, 'Bogotá', 16), (28, 'Medellín', 17), (29, 'Cali', 18), (30, 'Barranquilla', 19),
(31, 'Bucaramanga', 20), (32, 'Montevideo Capital', 21), (33, 'Punta del Este', 21),
(34, 'San Francisco', 22), (35, 'Los Angeles', 22), (36, 'San José', 22), (37, 'Houston', 23),
(38, 'Dallas', 23), (39, 'Nueva York', 24), (40, 'Buffalo', 24), (41, 'Toronto', 25),
(42, 'Ottawa', 25), (43, 'Ciudad de México Capital', 26), (44, 'Guadalajara', 27),
(45, 'Madrid Capital', 28), (46, 'Alcalá de Henares', 28), (47, 'Barcelona', 29),
(48, 'Tarragona', 29), (49, 'Múnich', 30), (50, 'Núremberg', 30);
 
-- ============================================================
-- 14. CALLE
-- ============================================================
INSERT INTO CALLE (id_calle, nombre, id_localidad) VALUES
(1,  'Av. Corrientes', 1), (2,  'Av. 9 de Julio', 1), (3,  'Av. Santa Fe', 1), (4,  'Calle Florida', 1),
(5,  'Av. Rivadavia', 1), (6,  'Calle San Martín', 1), (7,  'Diagonal 73', 2), (8,  'Calle 1', 2),
(9,  'Av. Colón', 3), (10, 'Av. Independencia', 3), (11, 'Bv. San Juan', 9), (12, 'Av. Belgrano', 9),
(13, 'Calle Córdoba', 9), (14, 'Av. Pellegrini', 9), (15, 'Av. Vélez Sársfield', 6), (16, 'Bv. San Juan', 6),
(17, 'Av. Colón', 6), (18, 'Calle Obispo Trejo', 6), (19, 'Av. San Martín', 11), (20, 'Calle Las Heras', 11),
(21, 'Av. España', 13), (22, 'Calle 24 de Septiembre', 13), (23, 'Av. Paulista', 14), (24, 'Rua Augusta', 14),
(25, 'Av. Brigadeiro Faria Lima',14), (26, 'Rua Oscar Freire', 14), (27, 'Av. Atlântica', 17),
(28, 'Rua Visconde de Pirajá', 17), (29, 'Av. Nossa Senhora de Copacabana',17), (30, 'Rua das Flores', 18),
(31, 'Av. Afonso Pena', 19), (32, 'Rua da Bahia', 19), (33, 'Av. Sete de Setembro', 20), (34, 'Rua Chile', 20),
(35, 'Av. XV de Novembro', 21), (36, 'Rua das Flores', 21), (37, 'Av. Libertador Bernardo OHiggins',22),
(38, 'Calle Huérfanos',22), (39, 'Av. Nueva Providencia', 22), (40, 'Calle Estado', 22),
(41, 'Av. Marina', 23), (42, 'Calle Valparaíso', 23), (43, 'Calle Freire', 24), (44, 'Av. Pedro de Valdivia', 24),
(45, 'Calle Prat', 25), (46, 'Av. Balmaceda', 25), (47, 'Calle Aldunate', 26), (48, 'Av. Alemania', 26),
(49, 'Cra. 7', 27), (50, 'Clle 72', 27), (51, 'Av. El Dorado', 27), (52, 'Cra. 50', 28),
(53, 'Clle 10', 28), (54, 'Av. El Poblado', 28), (55, 'Av. 6N', 29), (56, 'Clle 5', 29),
(57, 'Cra. 43', 30), (58, 'Clle 30', 30), (59, 'Av. 18 de Julio', 32), (60, 'Calle Yi', 32),
(61, 'Market Street', 34), (62, 'Mission Street', 34), (63, 'Sunset Blvd', 35), (64, 'Wilshire Blvd', 35),
(65, 'Main St', 36), (66, 'Technology Dr', 36), (67, 'Westheimer Rd', 37), (68, 'Kirby Dr', 37),
(69, 'Commerce St', 38), (70, 'Elm St', 38), (71, '5th Avenue', 39), (72, 'Broadway', 39),
(73, 'King Street West', 41), (74, 'Bay Street', 41), (75, 'Insurgentes Sur', 43), (76, 'Reforma', 43),
(77, 'Gran Vía', 45), (78, 'Calle Alcalá', 45), (79, 'Rambla de Catalunya', 47), (80, 'Passeig de Gràcia', 47);
 
-- ============================================================
-- 15. UBICACION
-- ============================================================
INSERT INTO UBICACION (id_ubicacion, tipo_ubicacion) VALUES
(1, 'Direccion_Fisica'), (2, 'Direccion_Fisica'), (3, 'Direccion_Fisica'), (4, 'Direccion_Fisica'), (5, 'Direccion_Fisica'),
(6, 'Direccion_Fisica'), (7, 'Direccion_Fisica'), (8, 'Direccion_Fisica'), (9, 'Direccion_Fisica'), (10, 'Direccion_Fisica'),
(11, 'Direccion_Fisica'), (12, 'Direccion_Fisica'), (13, 'Direccion_Fisica'), (14, 'Direccion_Fisica'), (15, 'Direccion_Fisica'),
(16, 'Direccion_Fisica'), (17, 'Direccion_Fisica'), (18, 'Direccion_Fisica'), (19, 'Direccion_Fisica'), (20, 'Direccion_Fisica'),
(21, 'Direccion_Fisica'), (22, 'Direccion_Fisica'), (23, 'Direccion_Fisica'), (24, 'Direccion_Fisica'), (25, 'Direccion_Fisica'),
(26, 'Direccion_Fisica'), (27, 'Direccion_Fisica'), (28, 'Direccion_Fisica'), (29, 'Direccion_Fisica'), (30, 'Direccion_Fisica'),
(31, 'Nube'), (32, 'Nube'), (33, 'Nube'), (34, 'Nube'), (35, 'Nube'),
(36, 'Nube'), (37, 'Nube'), (38, 'Nube'), (39, 'Nube'), (40, 'Nube'),
(41, 'Aplicacion'), (42, 'Aplicacion'), (43, 'Aplicacion'), (44, 'Aplicacion'), (45, 'Aplicacion'),
(46, 'Aplicacion'), (47, 'Aplicacion'), (48, 'Aplicacion'), (49, 'Aplicacion'), (50, 'Aplicacion');
 
 
-- ============================================================
-- 16. NUBE_EN_REGION
-- ============================================================
INSERT INTO NUBE_EN_REGION (id_region, id_ubicacion) VALUES
(1, 31),(1, 32),(1, 33), (2, 34),(2, 35),(2, 36),(2, 37), (3, 38),(3, 39),(3, 40);
 
-- ============================================================
-- 17. APLICACION
-- ============================================================
INSERT INTO APLICACION (id_ubicacion, version) VALUES
(41, '3.2.1'), (42, '4.0.0'), (43, '2.8.5'), (44, '5.1.0'), (45, '3.9.2'),
(46, '4.5.0'), (47, '2.1.3'), (48, '6.0.1'), (49, '3.0.0'), (50, '1.9.7');
 
-- ============================================================
-- 18. DIRECCION_FISICA
-- ============================================================
INSERT INTO DIRECCION_FISICA (id_ubicacion, numero, id_calle) VALUES
(1,  1234, 1),(2,  567,  2),(3,  890,  3),(4,  1100, 4),(5,  250,  5),
(6,  300,  7),(7,  410,  8),(8,  780,  9),(9,  640,  10),(10, 520,  11),
(11, 990,  12),(12, 1300, 13),(13, 450,  14),(14, 200,  15),(15, 800,  16),
(16, 1500, 17),(17, 320,  18),(18, 740,  19),(19, 160,  20),(20, 600,  21),
(21, 880,  22),(22, 1020, 23),(23, 470,  24),(24, 350,  25),(25, 910,  26),
(26, 230,  27),(27, 580,  28),(28, 1200, 29),(29, 660,  30),(30, 430,  31);
 
-- ============================================================
-- 19. PROVEEDOR
-- ============================================================
INSERT INTO PROVEEDOR (id_proveedor, nombre) VALUES
(1, 'Microsoft'), (2, 'Amazon Web Services'), (3, 'Apache Software Foundation'),
(4, 'Tableau Software'), (5, 'Snowflake Inc.'), (6, 'Oracle Corporation'),
(7, 'Google LLC'), (8, 'Databricks');
 
-- ============================================================
-- 20. HERRAMIENTA
-- ============================================================
INSERT INTO HERRAMIENTA (id_herramienta, nombre, tipo_herramienta, id_proveedor) VALUES
(1,  'SQL Server',             'Software',               1),
(2,  'Power BI',               'Software',               1),
(3,  'Azure Data Factory',     'Software',               1),
(4,  'Amazon S3',              'Licencia',               2),
(5,  'Amazon Redshift',        'Software',               2),
(6,  'AWS Glue',               'Licencia',               2),
(7,  'Amazon Athena',          'Licencia',               2),
(8,  'Apache Kafka',           'Herramienta Open Source', 3),
(9,  'Apache Spark',           'Herramienta Open Source', 3),
(10, 'Apache Airflow',         'Herramienta Open Source', 3),
(11, 'Apache Hive',            'Herramienta Open Source', 3),
(12, 'Apache NiFi',            'Herramienta Open Source', 3),
(13, 'Tableau Desktop',        'Software',               4),
(14, 'Tableau Server',         'Software',               4),
(15, 'Tableau Prep',           'Licencia',               4),
(16, 'Snowflake',              'Software',               5),
(17, 'Oracle DB',              'Software',               6),
(18, 'Oracle Analytics Cloud', 'Licencia',               6),
(19, 'Oracle Data Integrator', 'Licencia',               6),
(20, 'BigQuery',               'Software',               7),
(21, 'Looker',                 'Licencia',               7),
(22, 'Google Cloud Dataflow',  'Licencia',               7),
(23, 'Databricks Lakehouse',   'Software',               8),
(24, 'Delta Lake',             'Licencia',               8),
(25, 'MLflow',                 'Licencia',               8);
 
-- ============================================================
-- 21. SOFTWARE
-- ============================================================
INSERT INTO SOFTWARE (id_herramienta, fecha_ultima_actualizacion) VALUES
(1,  '2024-01-15'), (2,  '2024-03-20'), (3,  '2024-02-10'), (5,  '2023-11-05'),
(13, '2024-04-01'), (14, '2024-04-01'), (16, '2024-05-10'), (17, '2023-10-22'),
(20, '2024-03-15'), (23, '2024-04-20');
 
-- ============================================================
-- 22. LICENCIA
-- ============================================================
INSERT INTO LICENCIA (id_herramienta, fecha_desde, fecha_hasta) VALUES
(4,  '2020-01-01', '2025-12-31'), (6,  '2021-06-01', '2026-05-31'),
(7,  '2022-03-15', NULL),         (15, '2021-01-01', '2025-12-31'),
(18, '2020-07-01', '2024-06-30'), (19, '2021-07-01', '2025-06-30'),
(21, '2022-01-01', NULL),         (22, '2019-05-01', '2024-04-30'),
(24, '2022-06-01', NULL),         (25, '2023-01-01', NULL);
 
-- ============================================================
-- 23. APLICACION_OPEN_SOURCE
-- ============================================================
INSERT INTO HERRAMIENTA_OPEN_SOURCE (id_herramienta, version, fecha_instalacion) VALUES
(8,  '3.5.1',  '2022-04-10'), (9,  '3.4.0',  '2022-09-15'), (10, '2.7.3',  '2021-11-20'),
(11, '3.1.2',  '2020-08-05'), (12, '1.20.0', '2023-02-28');
 
-- ============================================================
-- 24. FUENTE_DE_DATOS
-- ============================================================
INSERT INTO FUENTE_DE_DATOS (id_fuente, nombre, tipo_fuente, modelo) VALUES
(1,  'DWH Finanzas Oracle',           'Relacional',    'Database'),
(2,  'DWH Ventas SQL Server',         'Relacional',    'Database'),
(3,  'Data Lake Operaciones S3',      'No Relacional', 'Data Store'),
(4,  'Data Cloud RRHH Snowflake',     'No Relacional', 'Data Store'),
(5,  'BD Clientes Oracle',            'Relacional',    'Database'),
(6,  'Repositorio Marketing S3',      'No Relacional', 'Data Store'),
(7,  'DWH Logística SQL Server',      'Relacional',    'Database'),
(8,  'Lakehouse Analytics Delta',     'No Relacional', 'Data Store'),
(9,  'BD Proveedores Oracle',         'Relacional',    'Database'),
(10, 'Stream Eventos Kafka',          'No Relacional', 'Data Store'),
(11, 'BigQuery Analytics',            'No Relacional', 'Data Store'),
(12, 'BD Inventario SQL Server',      'Relacional',    'Database'),
(13, 'Snowflake Marketing',           'No Relacional', 'Data Store'),
(14, 'Archivos Externos S3 Glacier',  'No Relacional', 'Data Store'),
(15, 'BD Compliance Oracle',          'Relacional',    'Database');
 
-- ============================================================
-- 25. FUENTE_UBICADA_EN
-- ============================================================
INSERT INTO FUENTE_UBICADA_EN (id_fuente, id_ubicacion) VALUES
(1, 5), (2, 10), (3, 35), (4, 36), (5, 2), (6, 37), (7, 8), (8, 38),
(9, 15), (10, 32), (11, 41), (12, 20), (13, 42), (14, 43), (15, 25);
 
-- ============================================================
-- 26. SUJETO
-- ============================================================
 
INSERT INTO SUJETO (id_sujeto, tipo_sujeto, formacion) VALUES
(1000,'Miembro UO','Profesional'),(1001,'Miembro UO','Profesional'),(1002,'Miembro UO','Profesional'),(1003,'Miembro UO','Profesional'),(1004,'Miembro UO','Profesional'),
(1005,'Miembro UO','Profesional'),(1006,'Miembro UO','Profesional'),(1007,'Miembro UO','Profesional'),(1008,'Miembro UO','Profesional'),(1009,'Miembro UO','Profesional'),
(1010,'Miembro UO','Profesional'),(1011,'Miembro UO','Profesional'),(1012,'Miembro UO','Profesional'),(1013,'Miembro UO','Profesional'),(1014,'Miembro UO','Profesional'),
(1015,'Miembro UO','Profesional'),(1016,'Miembro UO','Profesional'),(1017,'Miembro UO','Profesional'),(1018,'Miembro UO','Profesional'),(1019,'Miembro UO','Profesional'),
(1020,'Miembro UO','Profesional'),(1021,'Miembro UO','Profesional'),(1022,'Miembro UO','Profesional'),(1023,'Miembro UO','Profesional'),(1024,'Miembro UO','Profesional'),
(1025,'Miembro UO','Profesional'),(1026,'Miembro UO','Profesional'),(1027,'Miembro UO','Profesional'),(1028,'Miembro UO','Profesional'),(1029,'Miembro UO','Profesional'),
(1030,'Miembro UO','No Profesional'),(1031,'Miembro UO','No Profesional'),(1032,'Miembro UO','No Profesional'),(1033,'Miembro UO','No Profesional'),(1034,'Miembro UO','No Profesional'),
(1035,'Miembro UO','No Profesional'),(1036,'Miembro UO','No Profesional'),(1037,'Miembro UO','No Profesional'),(1038,'Miembro UO','No Profesional'),(1039,'Miembro UO','No Profesional'),
(1040,'Miembro UO','No Profesional'),(1041,'Miembro UO','No Profesional'),(1042,'Miembro UO','No Profesional'),(1043,'Miembro UO','No Profesional'),(1044,'Miembro UO','No Profesional'),
(1045,'Miembro UO','No Profesional'),(1046,'Miembro UO','No Profesional'),(1047,'Miembro UO','No Profesional'),(1048,'Miembro UO','No Profesional'),(1049,'Miembro UO','No Profesional'),
(1050,'Miembro UO','No Profesional'),(1051,'Miembro UO','No Profesional'),(1052,'Miembro UO','No Profesional'),(1053,'Miembro UO','No Profesional'),(1054,'Miembro UO','No Profesional'),
(1055,'Miembro UO','No Profesional'),(1056,'Miembro UO','No Profesional'),(1057,'Miembro UO','No Profesional'),(1058,'Miembro UO','No Profesional'),(1059,'Miembro UO','No Profesional'),
(1060,'Miembro UO','No Profesional'),(1061,'Miembro UO','No Profesional'),(1062,'Miembro UO','No Profesional'),(1063,'Miembro UO','No Profesional'),(1064,'Miembro UO','No Profesional'),
(1065,'Miembro UO','No Profesional'),(1066,'Miembro UO','No Profesional'),(1067,'Miembro UO','No Profesional'),(1068,'Miembro UO','No Profesional'),(1069,'Miembro UO','No Profesional'),
(1070,'Miembro UO','No Profesional'),(1071,'Miembro UO','No Profesional'),(1072,'Miembro UO','No Profesional'),(1073,'Miembro UO','No Profesional'),(1074,'Miembro UO','No Profesional'),
(1075,'Miembro UO','No Profesional'),(1076,'Miembro UO','No Profesional'),(1077,'Miembro UO','No Profesional'),(1078,'Miembro UO','No Profesional'),(1079,'Miembro UO','No Profesional'),
(1080,'Miembro UO','No Profesional'),(1081,'Miembro UO','No Profesional'),(1082,'Miembro UO','No Profesional'),(1083,'Miembro UO','No Profesional'),(1084,'Miembro UO','No Profesional'),
(1085,'Miembro UO','No Profesional'),(1086,'Miembro UO','No Profesional'),(1087,'Miembro UO','No Profesional'),(1088,'Miembro UO','No Profesional'),(1089,'Miembro UO','No Profesional'),
(1090,'Miembro UO','No Profesional'),(1091,'Miembro UO','No Profesional'),(1092,'Miembro UO','No Profesional'),(1093,'Miembro UO','No Profesional'),(1094,'Miembro UO','No Profesional'),
(1095,'Miembro UO','No Profesional'),(1096,'Miembro UO','No Profesional'),(1097,'Miembro UO','No Profesional'),(1098,'Miembro UO','No Profesional'),(1099,'Miembro UO','No Profesional'),
(1100,'Miembro UO','No Profesional'),(1101,'Miembro UO','No Profesional'),(1102,'Miembro UO','No Profesional'),(1103,'Miembro UO','No Profesional'),(1104,'Miembro UO','No Profesional'),
(1105,'Miembro UO','No Profesional'),(1106,'Miembro UO','No Profesional'),(1107,'Miembro UO','No Profesional'),(1108,'Miembro UO','No Profesional'),(1109,'Miembro UO','No Profesional'),
(1110,'Miembro UO','No Profesional'),(1111,'Miembro UO','No Profesional'),(1112,'Miembro UO','No Profesional'),(1113,'Miembro UO','No Profesional'),(1114,'Miembro UO','No Profesional'),
(1115,'Miembro UO','No Profesional'),(1116,'Miembro UO','No Profesional'),(1117,'Miembro UO','No Profesional'),(1118,'Miembro UO','No Profesional'),(1119,'Miembro UO','No Profesional'),
(1120,'Miembro UO','No Profesional'),(1121,'Miembro UO','No Profesional'),(1122,'Miembro UO','No Profesional'),(1123,'Miembro UO','No Profesional'),(1124,'Miembro UO','No Profesional'),
(1125,'Miembro UO','No Profesional'),(1126,'Miembro UO','No Profesional'),(1127,'Miembro UO','No Profesional'),(1128,'Miembro UO','No Profesional'),(1129,'Miembro UO','No Profesional'),
(1130,'Miembro UO','No Profesional'),(1131,'Miembro UO','No Profesional'),(1132,'Miembro UO','No Profesional'),(1133,'Miembro UO','No Profesional'),(1134,'Miembro UO','No Profesional'),
(1135,'Miembro UO','No Profesional'),(1136,'Miembro UO','No Profesional'),(1137,'Miembro UO','No Profesional'),(1138,'Miembro UO','No Profesional'),(1139,'Miembro UO','No Profesional'),
(1140,'Miembro UO','No Profesional'),(1141,'Miembro UO','No Profesional'),(1142,'Miembro UO','No Profesional'),(1143,'Miembro UO','No Profesional'),(1144,'Miembro UO','No Profesional'),
(1145,'Miembro UO','No Profesional'),(1146,'Miembro UO','No Profesional'),(1147,'Miembro UO','No Profesional'),(1148,'Miembro UO','No Profesional'),(1149,'Miembro UO','No Profesional'),
(2000,'Externo','Profesional'),(2001,'Externo','Profesional'),(2002,'Externo','Profesional'),(2003,'Externo','Profesional'),(2004,'Externo','Profesional'),
(2005,'Externo','Profesional'),(2006,'Externo','Profesional'),(2007,'Externo','Profesional'),(2008,'Externo','Profesional'),(2009,'Externo','Profesional'),
(2010,'Externo','No Profesional'),(2011,'Externo','No Profesional'),(2012,'Externo','No Profesional'),(2013,'Externo','No Profesional'),(2014,'Externo','No Profesional'),
(2015,'Externo','No Profesional'),(2016,'Externo','No Profesional'),(2017,'Externo','No Profesional'),(2018,'Externo','No Profesional'),(2019,'Externo','No Profesional'),
(3000,'Organizacion','No Profesional'),(3001,'Organizacion','No Profesional'),(3002,'Organizacion','No Profesional'),(3003,'Organizacion','No Profesional'),(3004,'Organizacion','No Profesional'),
(3005,'Organizacion','No Profesional'),(3006,'Organizacion','No Profesional'),(3007,'Organizacion','No Profesional'),(3008,'Organizacion','No Profesional'),(3009,'Organizacion','No Profesional');
-- ============================================================
-- 27. MIEMBRO_UO
-- ============================================================
INSERT INTO MIEMBRO_UO (id_sujeto, email_corporativo, fecha_ingreso, fecha_salida, id_puesto_trabajo) VALUES
(1000,'ana.garcia@uo.com',        '2015-03-15', NULL,         3),
(1001,'carlos.lopez@uo.com',      '2016-07-01', NULL,         1),
(1002,'marta.rodriguez@uo.com',   '2017-02-20', NULL,         4),
(1003,'jorge.martinez@uo.com',    '2018-11-05', NULL,         2),
(1004,'lucia.fernandez@uo.com',   '2019-06-30', NULL,         6),
(1005,'pablo.gomez@uo.com',       '2020-01-15', NULL,         5),
(1006,'sofia.diaz@uo.com',        '2021-04-22', NULL,         7),
(1007,'andres.sanchez@uo.com',    '2022-08-10', NULL,         8),
(1008,'valentina.perez@uo.com',   '2023-03-01', NULL,         9),
(1009,'nicolas.alvarez@uo.com',   '2015-09-12', NULL,         10),
(1010,'camila.torres@uo.com',     '2016-12-01', NULL,         1),
(1011,'diego.ramirez@uo.com',     '2017-05-18', NULL,         2),
(1012,'florencia.vega@uo.com',    '2018-02-28', NULL,         3),
(1013,'martin.reyes@uo.com',      '2019-10-14', NULL,         4),
(1014,'pilar.morales@uo.com',     '2020-07-07', NULL,         5),
(1015,'tomas.jimenez@uo.com',     '2021-11-30', NULL,         6),
(1016,'agustina.ruiz@uo.com',     '2022-04-05', NULL,         7),
(1017,'facundo.gutierrez@uo.com', '2023-01-20', NULL,         8),
(1018,'natalia.castro@uo.com',    '2015-06-25', NULL,         9),
(1019,'gabriel.ortiz@uo.com',     '2016-03-10', NULL,         10),
(1020,'rocio.vargas@uo.com',      '2017-08-15', NULL,         1),
(1021,'franco.mendez@uo.com',     '2018-05-20', NULL,         2),
(1022,'belen.paredes@uo.com',     '2019-02-14', NULL,         3),
(1023,'leandro.silva@uo.com',     '2020-09-01', NULL,         4),
(1024,'daniela.rojas@uo.com',     '2021-06-15', NULL,         5),
(1025,'mateo.nunez@uo.com',       '2022-03-28', NULL,         6),
(1026,'julieta.herrera@uo.com',   '2023-07-10', NULL,         7),
(1027,'ezequiel.medina@uo.com',   '2015-11-02', NULL,         8),
(1028,'lorena.flores@uo.com',     '2016-08-18', NULL,         9),
(1029,'ignacio.campos@uo.com',    '2017-04-30', NULL,         10),
(1030,'vanesa.espinoza@uo.com',   '2018-01-11', NULL,         1),
(1031,'rodrigo.suarez@uo.com',    '2019-07-22', NULL,         2),
(1032,'cecilia.molina@uo.com',    '2020-04-16', NULL,         3),
(1033,'alejandro.ponce@uo.com',   '2021-01-08', NULL,         4),
(1034,'mariela.ibarra@uo.com',    '2022-10-25', NULL,         5),
(1035,'gustavo.cabrera@uo.com',   '2023-05-03', NULL,         6),
(1036,'patricia.rios@uo.com',     '2015-04-19', NULL,         7),
(1037,'sebastian.aguilar@uo.com', '2016-01-27', NULL,         8),
(1038,'roxana.valdez@uo.com',     '2017-09-13', NULL,         9),
(1039,'mauricio.acosta@uo.com',   '2018-06-04', NULL,         10),
(1040,'silvana.benitez@uo.com',   '2019-03-17', NULL,         1),
(1041,'nicolas.tapia@uo.com',     '2020-12-01', NULL,         2),
(1042,'mariana.carrillo@uo.com',  '2021-09-14', NULL,         3),
(1043,'leonardo.montoya@uo.com',  '2022-06-20', NULL,         4),
(1044,'veronica.delgado@uo.com',  '2023-02-08', NULL,         5),
(1045,'hernan.guzman@uo.com',     '2015-07-30', NULL,         6),
(1046,'claudia.serrano@uo.com',   '2016-04-11', NULL,         7),
(1047,'oscar.roman@uo.com',       '2017-01-23', NULL,         8),
(1048,'adriana.soto@uo.com',      '2018-10-09', NULL,         9),
(1049,'javier.pino@uo.com',       '2019-08-26', NULL,         10),
(1050,'elena.cuevas@uo.com',      '2020-05-12', NULL,         1),
(1051,'roberto.luna@uo.com',      '2021-02-28', NULL,         2),
(1052,'graciela.mora@uo.com',     '2022-11-15', NULL,         3),
(1053,'emilio.alarcon@uo.com',    '2023-08-01', NULL,         4),
(1054,'susana.navarro@uo.com',    '2015-10-07', NULL,         5),
(1055,'pablo.bustos@uo.com',      '2016-06-22', NULL,         6),
(1056,'romina.andrade@uo.com',    '2017-03-05', NULL,         7),
(1057,'hector.palma@uo.com',      '2018-12-18', NULL,         8),
(1058,'irene.pizarro@uo.com',     '2019-09-04', NULL,         9),
(1059,'carlos.fuentes@uo.com',    '2020-06-17', NULL,         10),
(1060,'ana.toledo@uo.com',        '2021-03-31', NULL,         1),
(1061,'marco.vidal@uo.com',       '2022-01-14', NULL,         2),
(1062,'diana.cortez@uo.com',      '2023-09-27', NULL,         3),
(1063,'hugo.bravo@uo.com',        '2015-12-03', NULL,         4),
(1064,'karina.zamora@uo.com',     '2016-09-16', NULL,         5),
(1065,'raul.ceron@uo.com',        '2017-06-29', NULL,         6),
(1066,'victoria.nieto@uo.com',    '2018-04-12', NULL,         7),
(1067,'arnaldo.guerra@uo.com',    '2019-01-25', NULL,         8),
(1068,'marcela.leal@uo.com',      '2020-10-08', NULL,         9),
(1069,'walter.palacios@uo.com',   '2021-07-21', NULL,         10),
(1070,'beatriz.coronel@uo.com',   '2022-05-04', NULL,         1),
(1071,'julio.rendon@uo.com',      '2023-02-17', NULL,         2),
(1072,'miriam.contreras@uo.com',  '2015-08-20', NULL,         3),
(1073,'ernesto.gallego@uo.com',   '2016-05-03', NULL,         4),
(1074,'virginia.santiago@uo.com', '2017-02-14', NULL,         5),
(1075,'oscar.quintero@uo.com',    '2018-11-27', NULL,         6),
(1076,'silvia.barrios@uo.com',    '2019-09-09', NULL,         7),
(1077,'german.espinal@uo.com',    '2020-06-22', NULL,         8),
(1078,'eugenia.tovar@uo.com',     '2021-04-05', NULL,         9),
(1079,'nelson.arroyo@uo.com',     '2022-01-18', NULL,         10),
(1080,'marisol.fuentes@uo.com',   '2023-10-01', NULL,         1),
(1081,'edgar.ocampo@uo.com',      '2015-05-14', NULL,         2),
(1082,'liliana.ospina@uo.com',    '2016-02-25', NULL,         3),
(1083,'cesar.duran@uo.com',       '2017-11-08', NULL,         4),
(1084,'esperanza.hoyos@uo.com',   '2018-08-21', NULL,         5),
(1085,'alvaro.escobar@uo.com',    '2019-06-03', NULL,         6),
(1086,'claudia.zapata@uo.com',    '2020-03-16', NULL,         7),
(1087,'jairo.montoya@uo.com',     '2021-12-29', NULL,         8),
(1088,'lina.jimenez@uo.com',      '2022-10-11', NULL,         9),
(1089,'fredy.velez@uo.com',       '2023-07-24', NULL,         10),
(1090,'paola.cardona@uo.com',     '2015-02-06', NULL,         1),
(1091,'ivan.correa@uo.com',       '2016-11-19', NULL,         2),
(1092,'yuliana.mesa@uo.com',      '2017-08-02', NULL,         3),
(1093,'jhon.rios@uo.com',         '2018-05-15', NULL,         4),
(1094,'sandra.mora@uo.com',       '2019-02-26', NULL,         5),
(1095,'william.leon@uo.com',      '2020-11-10', NULL,         6),
(1096,'adriana.parra@uo.com',     '2021-08-23', NULL,         7),
(1097,'mario.garcia@uo.com',      '2022-06-05', NULL,         8),
(1098,'nora.salinas@uo.com',      '2023-03-19', NULL,         9),
(1099,'xavier.porto@uo.com',      '2015-09-01', NULL,         10),
(1100,'irma.velasco@uo.com',      '2016-06-14', NULL,         1),
(1101,'rafael.blanco@uo.com',     '2017-03-27', NULL,         2),
(1102,'yolanda.naranjo@uo.com',   '2018-01-09', NULL,         3),
(1103,'samuel.pacheco@uo.com',    '2019-10-22', NULL,         4),
(1104,'tamara.lozano@uo.com',     '2020-08-04', NULL,         5),
(1105,'gonzalo.baez@uo.com',      '2021-05-18', NULL,         6),
(1106,'amanda.pinzon@uo.com',     '2022-02-01', NULL,         7),
(1107,'rodrigo.cano@uo.com',      '2023-11-14', NULL,         8),
(1108,'delia.trujillo@uo.com',    '2015-06-27', NULL,         9),
(1109,'aurelio.macias@uo.com',    '2016-04-09', NULL,         10),
(1110,'fabiola.quiroga@uo.com',   '2017-01-21', NULL,         1),
(1111,'manuel.soria@uo.com',      '2018-10-04', NULL,         2),
(1112,'amparo.cano@uo.com',       '2019-07-17', NULL,         3),
(1113,'rolando.salazar@uo.com',   '2020-04-30', NULL,         4),
(1114,'nelly.figueroa@uo.com',    '2021-02-12', NULL,         5),
(1115,'alejandro.meza@uo.com',    '2022-11-25', NULL,         6),
(1116,'constanza.ibarra@uo.com',  '2023-09-07', NULL,         7),
(1117,'omar.paredes@uo.com',      '2015-03-20', NULL,         8),
(1118,'rebeca.fuentes@uo.com',    '2016-12-03', NULL,         9),
(1119,'hugo.castillo@uo.com',     '2017-09-15', NULL,         10),
(1120,'josefina.campos@uo.com',   '2018-06-28', NULL,         1),
(1121,'felix.guerrero@uo.com',    '2019-04-10', NULL,         2),
(1122,'alba.quintana@uo.com',     '2020-01-23', NULL,         3),
(1123,'enrique.delgado@uo.com',   '2021-10-06', NULL,         4),
(1124,'rosario.cisneros@uo.com',  '2022-07-19', NULL,         5),
(1125,'danilo.valverde@uo.com',   '2023-05-01', NULL,         6),
(1126,'esperanza.peralta@uo.com', '2015-11-14', NULL,         7),
(1127,'isaias.mendoza@uo.com',    '2016-08-26', NULL,         8),
(1128,'teresa.herrera@uo.com',    '2017-06-08', NULL,         9),
(1129,'joel.carpio@uo.com',       '2018-03-21', NULL,         10),
(1130,'celia.luna@uo.com',        '2019-01-03', NULL,         1),
(1131,'arturo.bermudez@uo.com',   '2020-10-16', NULL,         2),
(1132,'ines.villanueva@uo.com',   '2021-07-29', NULL,         3),
(1133,'moises.yepez@uo.com',      '2022-05-11', NULL,         4),
(1134,'leticia.calderon@uo.com',  '2023-02-24', NULL,         5),
-- 15 bajas (fecha_salida completada)
(1135,'edmundo.prado@uo.com',     '2015-08-10', '2020-12-31', 6),
(1136,'rosa.vivanco@uo.com',      '2016-03-22', '2021-06-30', 7),
(1137,'alfredo.saenz@uo.com',     '2017-10-05', '2022-03-31', 8),
(1138,'hortensia.abad@uo.com',    '2018-07-18', '2022-12-31', 9),
(1139,'leonel.rivas@uo.com',      '2019-04-30', '2023-06-30', 10),
(1140,'patricia.solano@uo.com',   '2020-02-12', '2024-01-31', 1),
(1141,'gilberto.moran@uo.com',    '2015-12-25', '2020-07-31', 2),
(1142,'amelia.bonilla@uo.com',    '2016-10-07', '2021-11-30', 3),
(1143,'ramirez.cuellar@uo.com',   '2017-07-20', '2022-08-31', 4),
(1144,'mirtha.coronado@uo.com',   '2018-05-02', '2023-02-28', 5),
(1145,'hilario.lazo@uo.com',      '2019-02-15', '2023-09-30', 6),
(1146,'perpetua.roman@uo.com',    '2020-11-28', '2024-05-31', 7),
(1147,'wenceslao.sala@uo.com',    '2021-09-10', '2024-08-31', 8),
(1148,'clementina.roca@uo.com',   '2022-06-23', '2024-11-30', 9),
(1149,'epifanio.meza@uo.com',     '2015-04-05', '2019-12-31', 10);
 
-- ============================================================
-- 28. EXTERNO
-- ============================================================
INSERT INTO EXTERNO (id_sujeto, email_contacto) VALUES
(2000,'m.rodriguez@accenture.com'), (2001,'l.fernandez@kpmg.com'), (2002,'j.gomez@pwc.com'),
(2003,'a.perez@deloitte.com'), (2004,'s.martinez@globant.com'), (2005,'d.lopez@mckinsey.com'),
(2006,'r.sanchez@aws-consulting.com'), (2007,'p.diaz@microsoft-partners.com'), (2008,'c.ruiz@gcp-experts.com'),
(2009,'m.torres@data-freelance.net'), (2010,'l.castro@tech-auditors.com'), (2011,'e.vega@legal-compliance.com'),
(2012,'f.romero@security-ops.com'), (2013,'a.herrera@agile-coaches.org'), (2014,'n.medina@bi-solutions.com'),
(2015,'m.vargas@marketing-analytics.com'), (2016,'v.castillo@cloud-architects.io'), (2017,'j.silva@external-dba.com'),
(2018,'s.ortiz@risk-advisors.com'), (2019,'c.morales@ml-freelancers.com');
 
-- ============================================================
-- 29. PROFESIONAL
-- ============================================================
INSERT INTO PROFESIONAL (id_sujeto, id_especialidad) VALUES
 
(1000, 2),(1001, 1),(1002, 5),(1003, 3),(1004, 6),
(1005, 4),(1006, 6),(1007, 5),(1008, 9),(1009,10),
(1010, 1),(1011, 3),(1012, 2),(1013, 5),(1014, 4),
(1015, 7),(1016, 8),(1017, 5),(1018, 9),(1019,10),
(1020, 1),(1021, 2),(1022, 3),(1023,11),(1024,12),
(1025,13),(1026,14),(1027,15),(1028, 1),(1029, 5),
(2000,4),(2001,15),(2002, 11),(2003, 5),(2004, 1),
(2005, 10),(2006, 7),(2007,4),(2008, 2),(2009, 3); 
 
-- ============================================================
-- 30. ORGANIZACION
-- ============================================================
INSERT INTO ORGANIZACION (id_sujeto, nombre, cuit, telefono, fecha_alta_relacion) VALUES
(3000,'Accenture Argentina',      '30-12345678-9','+54 11 4000-1000','2018-01-15'),
(3001,'KPMG Latam',               '30-23456789-0','+54 11 4000-2000','2019-03-22'),
(3002,'PwC Consultores',          '30-34567890-1','+54 11 4000-3000','2020-07-10'),
(3003,'Deloitte & Co.',           '30-45678901-2','+54 11 4000-4000','2017-11-05'),
(3004,'Globant SA',               '30-56789012-3','+54 11 4000-5000','2021-02-28'),
(3005,'McKinsey & Company',       '30-67890123-4','+54 11 4000-6000','2022-06-14'),
(3006,'Ernst & Young (EY)',       '30-78901234-5','+54 11 4000-7000','2015-09-01'),
(3007,'Capgemini Argentina',      '30-89012345-6','+54 11 4000-8000','2023-04-19'),
(3008,'NTT Data Latam',           '30-90123456-7','+54 11 4000-9000','2016-12-30'),
(3009,'Baufest IT Services',      '30-01234567-8','+54 11 4000-1100','2024-01-07');
 
-- ============================================================
-- 31. PERTENECE_A_EQUIPO
-- ============================================================
INSERT INTO PERTENECE_A_EQUIPO (id_sujeto, id_equipo, fecha_desde, fecha_hasta) VALUES
(1000, 8,'2015-03-15',NULL),(1001, 8,'2016-07-01',NULL),(1002, 4,'2017-02-20',NULL),
(1003, 3,'2018-11-05',NULL),(1004, 1,'2019-06-30',NULL),(1005, 5,'2020-01-15',NULL),
(1006, 6,'2021-04-22',NULL),(1007, 7,'2022-08-10',NULL),(1008, 9,'2023-03-01',NULL),
(1009,10,'2015-09-12',NULL),(1010, 1,'2016-12-01',NULL),(1011, 2,'2017-05-18',NULL),
(1012, 3,'2018-02-28',NULL),(1013, 4,'2019-10-14',NULL),(1014, 5,'2020-07-07',NULL),
(1015,10,'2021-11-30',NULL),(1016, 6,'2022-04-05',NULL),(1017, 7,'2023-01-20',NULL),
(1018, 8,'2015-06-25',NULL),(1019, 9,'2016-03-10',NULL),(1020, 1,'2017-08-15',NULL),
(1021, 2,'2018-05-20',NULL),(1022,11,'2019-02-14',NULL),(1023,12,'2020-09-01',NULL),
(1024,13,'2021-06-15',NULL),(1025,14,'2022-03-28',NULL),(1026,15,'2023-07-10',NULL),
(1027,16,'2015-11-02',NULL),(1028,17,'2016-08-18',NULL),(1029,18,'2017-04-30',NULL),
(1030,19,'2018-01-11',NULL),(1031,20,'2019-07-22',NULL),(1032, 1,'2020-04-16',NULL),
(1033, 2,'2021-01-08',NULL),(1034, 3,'2022-10-25',NULL),(1035, 4,'2023-05-03',NULL),
(1036, 5,'2015-04-19',NULL),(1037, 6,'2016-01-27',NULL),(1038, 7,'2017-09-13',NULL),
(1039, 8,'2018-06-04',NULL),(1040, 9,'2019-03-17',NULL),(1041,10,'2020-12-01',NULL),
(1042,11,'2021-09-14',NULL),(1043,12,'2022-06-20',NULL),(1044,13,'2023-02-08',NULL),
(1045,14,'2015-07-30',NULL),(1046,15,'2016-04-11',NULL),(1047,16,'2017-01-23',NULL),
(1048,17,'2018-10-09',NULL),(1049,18,'2019-08-26',NULL),(1050,19,'2020-05-12',NULL),
(1051,20,'2021-02-28',NULL),(1052, 1,'2022-11-15',NULL),(1053, 2,'2023-08-01',NULL),
(1054, 3,'2015-10-07',NULL),(1055, 4,'2016-06-22',NULL),(1056, 5,'2017-03-05',NULL),
(1057, 6,'2018-12-18',NULL),(1058, 7,'2019-09-04',NULL),(1059, 8,'2020-06-17',NULL),
(1060, 9,'2021-03-31',NULL),(1061,10,'2022-01-14',NULL),(1062,11,'2023-09-27',NULL),
(1063,12,'2015-12-03',NULL),(1064,13,'2016-09-16',NULL),(1065,14,'2017-06-29',NULL),
(1066,15,'2018-04-12',NULL),(1067,16,'2019-01-25',NULL),(1068,17,'2020-10-08',NULL),
(1069,18,'2021-07-21',NULL),(1070,19,'2022-05-04',NULL),(1071,20,'2023-02-17',NULL),
(1072, 1,'2015-08-20',NULL),(1073, 2,'2016-05-03',NULL),(1074, 3,'2017-02-14',NULL),
(1075, 4,'2018-11-27',NULL),(1076, 5,'2019-09-09',NULL),(1077, 6,'2020-06-22',NULL),
(1078, 7,'2021-04-05',NULL),(1079, 8,'2022-01-18',NULL),(1080, 9,'2023-10-01',NULL),
(1081,10,'2015-05-14',NULL),(1082,11,'2016-02-25',NULL),(1083,12,'2017-11-08',NULL),
(1084,13,'2018-08-21',NULL),(1085,14,'2019-06-03',NULL),(1086,15,'2020-03-16',NULL),
(1087,16,'2021-12-29',NULL),(1088,17,'2022-10-11',NULL),(1089,18,'2023-07-24',NULL),
(1090,19,'2015-02-06',NULL),(1091,20,'2016-11-19',NULL),(1092, 1,'2017-08-02',NULL),
(1093, 2,'2018-05-15',NULL),(1094, 3,'2019-02-26',NULL),(1095, 4,'2020-11-10',NULL),
(1096, 5,'2021-08-23',NULL),(1097, 6,'2022-06-05',NULL),(1098, 7,'2023-03-19',NULL),
(1099, 8,'2015-09-01',NULL),(1100, 9,'2016-06-14',NULL),(1101,10,'2017-03-27',NULL),
(1102,11,'2018-01-09',NULL),(1103,12,'2019-10-22',NULL),(1104,13,'2020-08-04',NULL),
(1105,14,'2021-05-18',NULL),(1106,15,'2022-02-01',NULL),(1107,16,'2023-11-14',NULL),
(1108,17,'2015-06-27',NULL),(1109,18,'2016-04-09',NULL),(1110,19,'2017-01-21',NULL),
(1111, 1, '2018-10-04', NULL), (1112, 2, '2019-07-17', NULL),
(1113, 3, '2020-04-30', NULL), (1114, 4, '2021-02-12', NULL),
(1115, 5, '2022-11-25', NULL), (1116, 6, '2023-09-07', NULL),
(1117, 7, '2015-03-20', NULL), (1118, 8, '2016-12-03', NULL),
(1119, 8, '2017-09-15', NULL), (1120, 10, '2018-06-28', NULL), 
(1121, 11, '2019-04-10', NULL),(1122, 12, '2020-01-23', NULL), 
(1123, 13, '2021-10-06', NULL),(1124, 14, '2022-07-19', NULL), 
(1125, 15, '2023-05-01', NULL),(1126, 16, '2015-11-14', NULL), 
(1127, 17, '2016-08-26', NULL),(1128, 18, '2017-06-08', NULL), 
(1129, 8, '2018-03-21', NULL), (1130, 20, '2019-01-03', NULL), 
(1131, 1, '2020-10-16', NULL), (1132, 2, '2021-07-29', NULL), 
(1133, 3, '2022-05-11', NULL), (1134, 4, '2023-02-24', NULL),
(1135, 6,'2015-08-10','2020-12-31'),(1136, 7,'2016-03-22','2021-06-30'),
(1137, 8,'2017-10-05','2022-03-31'),(1138, 9,'2018-07-18','2022-12-31'),
(1139,10,'2019-04-30','2023-06-30'),(1140, 1,'2020-02-12','2024-01-31'),
(1141, 2,'2015-12-25','2020-07-31'),(1142, 3,'2016-10-07','2021-11-30'),
(1143, 4,'2017-07-20','2022-08-31'),(1144, 5,'2018-05-02','2023-02-28');

-- ============================================================
-- 32. DIRIGE_EQUIPO
-- ============================================================
INSERT INTO DIRIGE_EQUIPO (id_sujeto, id_equipo, fecha_desde, fecha_hasta) VALUES
(1010, 1,'2016-12-01',NULL), (1011, 2,'2017-05-18',NULL),
(1012, 3,'2018-02-28',NULL), (1013, 4,'2019-10-14',NULL),
(1014, 5,'2020-07-07',NULL), (1016, 6,'2022-04-05',NULL),
(1017, 7,'2023-01-20',NULL), (1018, 8,'2015-06-25',NULL),
(1008, 9,'2023-03-01',NULL), (1015,10,'2021-11-30',NULL),
(1022,11,'2019-02-14',NULL), (1023,12,'2020-09-01',NULL),
(1024,13,'2021-06-15',NULL), (1025,14,'2022-03-28',NULL),
(1026,15,'2023-07-10',NULL), (1027,16,'2015-11-02',NULL),
(1028,17,'2016-08-18',NULL), (1049,18,'2019-08-26',NULL),
(1030,19,'2018-01-11',NULL), (1031,20,'2019-07-22',NULL);
 
-- ============================================================
-- 33. ACCESO_FUENTE_DATOS
-- ============================================================
INSERT INTO ACCESO_FUENTE_DATOS (id_sujeto, id_fuente, fecha_desde, fecha_hasta, id_rol, id_perfil) VALUES
(1000,  1, '2015-04-01', NULL        , 1, 4),  (1000,  3, '2021-01-01', NULL        , 2, 4),
(1001,  1, '2016-08-01', NULL        , 2, 4),  (1001,  2, '2021-01-01', NULL        , 2, 4),
(1002,  2, '2017-03-01', NULL        , 1, 4),  (1003,  3, '2018-12-01', NULL        , 1, 4),
(1004,  4, '2019-07-01', NULL        , 1, 4),  (1005,  5, '2020-02-01', NULL        , 1, 4),
(1006,  6, '2021-05-01', NULL        , 1, 4),  (1007,  7, '2022-09-01', NULL        , 1, 4),
(1008,  8, '2023-04-01', NULL        , 3, 1),  (1009,  9, '2015-10-01', NULL        , 1, 4),
(1010,  1, '2017-01-01', NULL        , 3, 2),  (1011,  2, '2017-06-01', NULL        , 3, 1),
(1012,  3, '2018-03-01', NULL        , 3, 2),  (1013,  4, '2019-11-01', NULL        , 2, 4),
(1014,  5, '2020-08-01', NULL        , 3, 1),  (1015, 10, '2021-12-01', NULL        , 1, 4),
(1016,  6, '2022-05-01', NULL        , 2, 4),  (1017,  7, '2023-02-01', NULL        , 3, 1),
(1018,  2, '2021-01-01', NULL        , 2, 4),  (1018,  8, '2015-07-01', NULL        , 1, 4),
(1019,  9, '2016-04-01', NULL        , 5, 5),  (1020,  1, '2017-09-01', NULL        , 3, 2),
(1021,  2, '2018-06-01', NULL        , 3, 1),  (1022,  6, '2021-01-01', NULL        , 2, 4),
(1022, 11, '2019-03-01', NULL        , 1, 4),  (1023, 12, '2020-10-01', NULL        , 1, 4),
(1024, 13, '2021-07-01', NULL        , 1, 4),  (1025, 14, '2022-04-01', NULL        , 1, 4),
(1026, 15, '2023-08-01', NULL        , 1, 4),  (1027,  1, '2015-12-01', NULL        , 2, 4),
(1028,  2, '2016-09-01', NULL        , 2, 4),  (1029,  3, '2017-06-01', NULL        , 3, 2),
(1030,  4, '2018-03-01', NULL        , 3, 1),  (1031,  5, '2019-09-01', NULL        , 3, 1),
(1032,  6, '2020-06-01', NULL        , 2, 4),  (1033,  7, '2021-03-01', NULL        , 4, 4),
(1034,  8, '2022-12-01', NULL        , 3, 1),  (1035,  9, '2023-06-01', NULL        , 5, 5),
(1036,  1, '2015-05-01', NULL        , 3, 2),  (1037,  2, '2016-02-01', NULL        , 3, 1),
(1038,  3, '2017-10-01', NULL        , 3, 2),  (1039,  4, '2018-07-01', NULL        , 2, 4),
(1040,  5, '2019-04-01', NULL        , 3, 1),  (1041, 10, '2021-01-01', NULL        , 3, 1),
(1042, 11, '2021-10-01', NULL        , 3, 2),  (1043, 12, '2022-07-01', NULL        , 2, 4),
(1044, 13, '2023-03-01', NULL        , 3, 1),  (1045, 14, '2015-08-01', NULL        , 3, 1),
(1046, 15, '2016-05-01', NULL        , 5, 5),  (1047,  1, '2017-02-01', NULL        , 3, 2),
(1048,  2, '2018-11-01', NULL        , 3, 1),  (1049,  3, '2019-10-01', NULL        , 3, 2),
(1050,  4, '2020-06-01', NULL        , 2, 4),  (1051,  5, '2021-03-01', NULL        , 3, 1),
(1052,  6, '2022-12-01', NULL        , 2, 4),  (1053,  7, '2023-09-01', NULL        , 4, 4),
(1054,  8, '2015-11-01', NULL        , 3, 1),  (1055,  9, '2016-07-01', NULL        , 5, 5),
(1056,  1, '2017-04-01', NULL        , 3, 2),  (1057,  2, '2019-01-01', NULL        , 3, 1),
(1058,  3, '2019-10-01', NULL        , 3, 2),  (1059,  4, '2020-07-01', NULL        , 2, 4),
(1060,  5, '2021-04-01', NULL        , 3, 1),  (1061, 10, '2022-02-01', NULL        , 3, 1),
(1062, 11, '2023-10-01', NULL        , 3, 2),  (1063, 12, '2016-01-01', NULL        , 2, 4),
(1064, 13, '2016-10-01', NULL        , 3, 1),  (1065, 14, '2017-07-01', NULL        , 3, 1),
(1066, 15, '2018-05-01', NULL        , 5, 5),  (1067,  1, '2019-02-01', NULL        , 3, 2),
(1068,  2, '2020-11-01', NULL        , 3, 1),  (1069,  3, '2021-08-01', NULL        , 3, 2),
(1070,  4, '2022-06-01', NULL        , 2, 4),  (1071,  5, '2023-03-01', NULL        , 3, 1),
(1072,  6, '2015-09-01', NULL        , 2, 4),  (1073,  7, '2016-06-01', NULL        , 4, 4),
(1074,  8, '2017-03-01', NULL        , 3, 1),  (1075,  9, '2019-01-01', NULL        , 5, 5),
(1076,  1, '2019-10-01', NULL        , 3, 2),  (1077,  2, '2020-07-01', NULL        , 3, 1),
(1078,  3, '2021-04-05', NULL        , 3, 2),  (1079,  4, '2022-02-01', NULL        , 2, 4),
(1080,  5, '2023-11-01', NULL        , 3, 1),  (1081,  1, '2021-03-01', NULL        , 6, 3),
(1081,  8, '2021-03-01', NULL        , 6, 3),  (1082,  2, '2021-09-01', NULL        , 6, 3),
(1082, 10, '2021-09-01', NULL        , 6, 3),  (1083,  3, '2022-01-15', NULL        , 6, 3),
(1083,  7, '2022-01-15', NULL        , 6, 3),  (1084,  4, '2022-06-01', NULL        , 6, 3),
(1084, 12, '2022-06-01', NULL        , 6, 3),  (1085,  5, '2022-11-01', NULL        , 6, 3),
(1085, 13, '2022-11-01', NULL        , 6, 3),  (1086,  6, '2023-02-01', NULL        , 6, 3),
(1086, 11, '2023-02-01', NULL        , 6, 3),  (1087,  1, '2023-04-01', NULL        , 6, 3),
(1087, 15, '2023-04-01', NULL        , 6, 3),  (1088,  8, '2023-07-01', NULL        , 6, 3),
(1089,  3, '2023-07-24', NULL        , 6, 3),  (1089,  9, '2023-07-24', NULL        , 6, 3),
(1090,  2, '2022-03-01', NULL        , 6, 3),  (1091,  4, '2022-10-01', NULL        , 6, 3),
(1092,  6, '2023-01-01', NULL        , 6, 3),
(2000,  1, '2020-01-01', '2023-12-31', 3, 2),  (2001,  2, '2021-06-01', NULL        , 3, 1),
(2002,  3, '2019-03-01', '2022-06-30', 3, 2),  (2003,  4, '2022-01-01', NULL        , 2, 4),
(2004,  5, '2020-09-01', '2024-08-31', 3, 1),  (2005,  6, '2021-04-01', NULL        , 2, 4),
(2006,  7, '2022-11-01', NULL        , 4, 4),  (2007,  8, '2019-07-01', '2023-06-30', 3, 1),
(2008,  9, '2023-01-01', NULL        , 5, 5),  (2009, 10, '2020-05-01', NULL        , 3, 2),
(2010, 11, '2021-02-01', '2024-01-31', 3, 1),  (2011, 12, '2022-09-01', NULL        , 3, 2),
(2012, 13, '2023-06-01', NULL        , 2, 4),  (2013, 14, '2020-03-01', '2023-02-28', 3, 1),
(2014, 15, '2021-10-01', NULL        , 3, 1),  (2015,  1, '2019-01-01', '2022-12-31', 5, 5),
(2016,  2, '2022-07-01', NULL        , 3, 2),  (2017,  3, '2023-04-01', NULL        , 3, 1),
(2018,  4, '2020-11-01', '2024-10-31', 2, 4),  (2019,  5, '2021-08-01', NULL        , 3, 1),
(3000,  1, '2018-02-01', NULL        , 5, 5),  (3001,  3, '2019-04-01', NULL        , 5, 5),
(3002,  5, '2020-08-01', NULL        , 5, 5),  (3003,  7, '2017-12-01', NULL        , 5, 5),
(3004,  9, '2021-03-01', NULL        , 5, 5),  (3005,  2, '2022-07-01', NULL        , 5, 5),
(3006,  4, '2015-10-01', NULL        , 5, 5),  (3007,  6, '2023-05-01', NULL        , 5, 5),
(3008,  8, '2017-01-01', NULL        , 5, 5),  (3009, 10, '2024-02-01', NULL        , 5, 5);

-- ============================================================
-- 34. DEFINICION_FUNCIONAL
-- ============================================================
INSERT INTO DEFINICION_FUNCIONAL (id_definicion, nombre, descripcion) VALUES
(1,  'Cliente Activo',                  'Todo cliente que haya realizado al menos una transacción comercial confirmada en los últimos 90 días naturales.'),
(2,  'Lead Calificado (MQL)',           'Prospecto comercial que ha interactuado con campañas de marketing y cumple con los criterios de scoring mínimos para ser contactado.'),
(3,  'Ingreso Neto Mensual (MRR)',      'Ingreso Mensual Recurrente. Suma total de los ingresos generados en un mes calendario, descontando impuestos, devoluciones y descuentos.'),
(4,  'Margen Operativo',                'Indicador de rentabilidad que se calcula dividiendo el beneficio operativo entre las ventas netas. Excluye impuestos e intereses.'),
(5,  'Proveedor Homologado',            'Organización externa que ha superado satisfactoriamente los procesos de debida diligencia (Due Diligence) legal, fiscal y operativa de UO.'),
(6,  'Churn Rate (Tasa de Abandono)',   'Porcentaje de clientes que han cancelado sus contratos o dejado de operar con la compañía en un período determinado (generalmente mensual).'),
(7,  'Tasa de Retención',               'Métrica inversa al Churn Rate. Porcentaje de clientes que continúan operando con la organización de un período a otro.'),
(8,  'Headcount (Plantilla Activa)',    'Número total de empleados en relación de dependencia directa con UO en un momento dado, excluyendo contratistas y consultores externos.'),
(9,  'Stock de Seguridad',              'Nivel mínimo de inventario que debe mantenerse en reserva para mitigar el riesgo de quiebre de stock ante picos de demanda o retrasos de proveedores.'),
(10, 'NPS (Net Promoter Score)',        'Índice de lealtad y satisfacción del cliente calculado a partir de la pregunta "¿Qué tan probable es que recomiende nuestra empresa?", en escala de -100 a +100.'),
(11, 'Tiempo de Entrega (Lead Time)',   'Cantidad de días hábiles transcurridos desde que un cliente confirma un pedido hasta que el producto o servicio es entregado/implementado.'),
(12, 'SKU (Stock Keeping Unit)',        'Código alfanumérico único utilizado para identificar y rastrear de manera unívoca un producto o servicio específico en el inventario.'),
(13, 'Valor de Ciclo de Vida (LTV)',    'Estimación del ingreso neto total que un cliente generará para la empresa durante toda su relación comercial con la misma.'),
(14, 'Costo de Adquisición (CAC)',      'Inversión total en marketing y ventas dividida por el número de clientes nuevos adquiridos en el mismo período.'),
(15, 'Tiempo Medio de Resolución',      '(MTTR) Promedio de horas transcurridas desde la apertura de un ticket o reporte de incidente hasta su resolución y cierre efectivo.');
 
-- ============================================================
-- 35. OPERACION
-- ============================================================
INSERT INTO OPERACION (id_operacion, descripcion, id_departamento) VALUES
(1,  'Cierre contable mensual',                    1), (2,  'Conciliación bancaria',                      1),
(3,  'Procesamiento de nómina',                    1), (4,  'Gestión de presupuesto anual',               1),
(5,  'Monitoreo de infraestructura cloud',         2), (6,  'Despliegue de pipelines ETL',                2),
(7,  'Auditoría de accesos y permisos',            2), (8,  'Análisis de campañas digitales',             3),
(9,  'Segmentación de audiencias',                 3), (10, 'Generación de reportes de ventas',           3),
(11, 'Planificación de producción',                4), (12, 'Control de calidad de procesos',             4),
(13, 'Gestión de inventario',                      4), (14, 'Reclutamiento y selección',                  5),
(15, 'Evaluación de desempeño',                    5);
 
-- ============================================================
-- 36. ACTIVO
-- ============================================================
INSERT INTO ACTIVO (id_activo, nombre, tipo_activo, id_fase, id_definicion) VALUES
(1,  'Reporte Ingreso Neto Mensual',       'Objeto', 3,  3), (2,  'Reporte Ingreso Neto Anual',         'Objeto', 3,  3),
(3,  'Reporte Clientes Activos',           'Objeto', 3,  1), (4,  'Reporte Costo Directo por Área',     'Objeto', 3,  4),
(5,  'Reporte Tasa de Retención',          'Objeto', 3,  7), (6,  'Reporte Estado de Oportunidades',    'Objeto', 3,  2),
(7,  'Reporte NPS Trimestral',             'Objeto', 3, 10), (8,  'Reporte Tiempo de Ciclo por Pedido', 'Objeto', 3, 11),
(9,  'Reporte Nivel de Stock',             'Objeto', 3,  9), (10, 'Reporte Horas No Trabajadas',        'Objeto', 3,  8),
(11, 'Reporte Fechas de Baja de Empleados','Objeto', 3,  8), (12, 'Reporte Margen Bruto',               'Objeto', 3,  4),
(13, 'Reporte Costo de Adquisición Canal', 'Objeto', 3, 14), (14, 'Reporte Valor de Ciclo de Vida',     'Objeto', 3, 13),
(15, 'Reporte Disponibilidad de Sistemas', 'Objeto', 3, 15), (16, 'Reporte Tasa de Defectos',           'Objeto', 3, 15),
(17, 'Reporte Comparativo Ingresos',       'Objeto', 4,  3), (18, 'Reporte Benchmark Retención',        'Objeto', 4,  7),
(19, 'Reporte Forecast de Oportunidades',  'Objeto', 4,  2), (20, 'Reporte Análisis CAC vs LTV',        'Objeto', 4, 14),
(21, 'Reporte Cohorte por Fecha de Alta',  'Objeto', 4,  1), (22, 'Reporte Costos Directos Logísticos', 'Objeto', 4, 11),
(23, 'Reporte Eficiencia Operativa',       'Objeto', 4, 15), (24, 'Reporte Satisfacción NPS',           'Objeto', 4, 10),
(25, 'Reporte Fechas de Baja vs Retención','Objeto', 4,  6),
(26, 'Panel Ejecutivo Finanzas',           'Panel De Control', 3,  3), (27, 'Panel Clientes 360',                 'Panel De Control', 3,  1),
(28, 'Panel Operaciones en Tiempo Real',   'Panel De Control', 3, 11), (29, 'Panel Pipeline Comercial',           'Panel De Control', 3,  2),
(30, 'Panel NPS & Satisfacción',           'Panel De Control', 3, 10), (31, 'Panel Supply Chain',                 'Panel De Control', 3,  9),
(32, 'Panel RRHH Analytics',               'Panel De Control', 3,  8), (33, 'Panel Marketing Performance',        'Panel De Control', 3, 14),
(34, 'Panel IT Uptime & Incidentes',       'Panel De Control', 3, 15), (35, 'Panel Costos y Márgenes',            'Panel De Control', 3,  4),
(36, 'Tablero Retención y Churn',          'Objeto', 4,  6), (37, 'Tablero Forecast de Demanda',        'Objeto', 4, 12),
(38, 'Tablero Adquisición de Clientes',    'Objeto', 4, 14), (39, 'Tablero Análisis LTV',               'Objeto', 4, 13),
(40, 'Tablero Comparativo Anual',          'Objeto', 5,  3), (41, 'Tablero Mapa de Riesgo Operativo',   'Objeto', 4, 15),
(42, 'Tablero KPIs Estratégicos',          'Objeto', 3,  3), (43, 'Tablero Rendimiento por Región',     'Objeto', 3,  3),
(44, 'Tablero Inventario en Tiempo Real',  'Objeto', 3,  9), (45, 'Tablero Productividad por Equipo',   'Objeto', 3,  8),
(46, 'ETL Ingesta Diaria Ventas',          'Objeto', 2,  3), (47, 'ETL Ingesta Diaria Finanzas',        'Objeto', 2,  4),
(48, 'ETL Carga DWH Clientes',             'Objeto', 2,  1), (49, 'Proceso Calidad Datos Proveedores',  'Objeto', 3,  5),
(50, 'Pipeline ML Segmentación',           'Objeto', 3,  1), (51, 'Proceso Conciliación Contable',      'Objeto', 3,  3),
(52, 'ETL Nómina a DWH',                   'Objeto', 2,  8), (53, 'Pipeline Eventos Clickstream',       'Objeto', 3,  2),
(54, 'Proceso Archivado Histórico',        'Objeto', 5,  1), (55, 'ETL Inventario a Lakehouse',         'Objeto', 2, 12),
(56, 'Proceso Generación NPS',             'Objeto', 3, 10), (57, 'Pipeline Streaming Kafka',           'Objeto', 2, 11),
(58, 'Proceso Forecast Automático',        'Objeto', 3,  3), (59, 'ETL Datos RRHH',                     'Objeto', 2,  8),
(60, 'Proceso Depuración Datos Externos',  'Objeto', 3,  5),
(61, 'Tabla Maestra de Clientes',          'Datos Estructurado', 2,  1), (62, 'Tabla de Transacciones Financieras', 'Datos Estructurado', 2,  3),
(63, 'Tabla de Pedidos y Entregas',        'Datos Estructurado', 2, 11), (64, 'Tabla de Empleados Activos',         'Datos Estructurado', 2,  8),
(65, 'Tabla de Proveedores Homologados',   'Datos Estructurado', 2,  5), (66, 'Tabla de Productos y SKUs',          'Datos Estructurado', 2, 12),
(67, 'Tabla de Oportunidades Comerciales', 'Datos Estructurado', 2,  2), (68, 'Tabla de Movimientos de Inventario', 'Datos Estructurado', 2,  9),
(69, 'Tabla de Incidentes de Calidad',     'Datos Estructurado', 2, 15), (70, 'Tabla de Accesos Empleados',         'Datos Estructurado', 2,  8),
(71, 'Dataset Histórico de Ventas',        'Datos Estructurado', 5,  3), (72, 'Dataset Encuestas Satisfacción',     'Datos Estructurado', 2, 10),
(73, 'Dataset Ausentismo Anual',           'Datos Estructurado', 5,  8), (74, 'Dataset Costos por Centro',          'Datos Estructurado', 2,  4),
(75, 'Dataset Disponibilidad de Sistemas', 'Datos Estructurado', 2, 15), (76, 'Archivos PDF de Contratos',          'Datos No Estructurado', 2,  5),
(77, 'Grabaciones de Llamadas Soporte',    'Datos No Estructurado', 2, 15), (78, 'Imágenes de Documentos RRHH',        'Datos No Estructurado', 2,  8),
(79, 'Correos de Quejas y Reclamos',       'Datos No Estructurado', 2, 10), (80, 'Logs de Aplicaciones Web',           'Datos No Estructurado', 2, 15),
(81, 'Archivos JSON Eventos Clickstream',  'Datos No Estructurado', 2,  2), (82, 'Videos de Capacitación Interna',     'Datos No Estructurado', 2,  8),
(83, 'Modelo Predictivo Churn',            'Modelo', 3,  6), (84, 'Modelo Segmentación RFM',            'Modelo', 3, 13),
(85, 'Modelo Forecast Series de Tiempo',   'Modelo', 3,  3), (86, 'Modelo Detección Anomalías Finanzas','Modelo', 3,  4),
(87, 'Modelo NLP Análisis Sentimientos',   'Modelo', 3, 10), (88, 'Modelo Scoring Crediticio',          'Modelo', 3,  1),
(89, 'Diccionario de Datos Corporativo',   'Otro', 3,  1), (90, 'Política de Retención de Datos',     'Otro', 3,  5);
 
-- ============================================================
-- 37. OBJETO
-- ============================================================
INSERT INTO OBJETO (id_activo, tipo_objeto) VALUES
(1,'Reporte'),(2,'Reporte'),(3,'Reporte'),(4,'Reporte'),(5,'Reporte'),
(6,'Reporte'),(7,'Reporte'),(8,'Reporte'),(9,'Reporte'),(10,'Reporte'),
(11,'Reporte'),(12,'Reporte'),(13,'Reporte'),(14,'Reporte'),(15,'Reporte'),
(16,'Reporte'),(17,'Reporte'),(18,'Reporte'),(19,'Reporte'),(20,'Reporte'),
(21,'Reporte'),(22,'Reporte'),(23,'Reporte'),(24,'Reporte'),(25,'Reporte'),
(36,'Tablero'),(37,'Tablero'),(38,'Tablero'),(39,'Tablero'),(40,'Tablero'),
(41,'Tablero'),(42,'Tablero'),(43,'Tablero'),(44,'Tablero'),(45,'Tablero'),
(46,'Proceso'),(47,'Proceso'),(48,'Proceso'),(49,'Proceso'),(50,'Proceso'),
(51,'Proceso'),(52,'Proceso'),(53,'Proceso'),(54,'Proceso'),(55,'Proceso'),
(56,'Proceso'),(57,'Proceso'),(58,'Proceso'),(59,'Proceso'),(60,'Proceso');
 
-- ============================================================
-- 38. REPORTE
-- ============================================================
INSERT INTO REPORTE (id_activo, formato_salida) VALUES
(1,'PDF'),(2,'PDF'),(3,'Excel'),(4,'PDF'),(5,'Excel'),
(6,'PDF'),(7,'PowerPoint'),(8,'Excel'),(9,'Excel'),(10,'PDF'),
(11,'PDF'),(12,'Excel'),(13,'PDF'),(14,'Excel'),(15,'PDF'),
(16,'Excel'),(17,'PDF'),(18,'PDF'),(19,'Excel'),(20,'PDF'),
(21,'Excel'),(22,'PDF'),(23,'Excel'),(24,'PDF'),(25,'Excel');
 
-- ============================================================
-- 39. TABLERO
-- ============================================================
INSERT INTO TABLERO (id_activo, url_acceso) VALUES
(36,'https://bi.uo.com/tableros/retencion-churn'), (37,'https://bi.uo.com/tableros/forecast-demanda'),
(38,'https://bi.uo.com/tableros/adquisicion-clientes'), (39,'https://bi.uo.com/tableros/ltv-analisis'),
(40,'https://bi.uo.com/tableros/comparativo-anual'), (41,'https://bi.uo.com/tableros/riesgo-operativo'),
(42,'https://bi.uo.com/tableros/kpis-estrategicos'), (43,'https://bi.uo.com/tableros/rendimiento-region'),
(44,'https://bi.uo.com/tableros/inventario-rt'), (45,'https://bi.uo.com/tableros/productividad-equipo');
 
-- ============================================================
-- 40. PROCESO
-- ============================================================
INSERT INTO PROCESO (id_activo, tiempo_maximo_minutos) VALUES
(46, 90),(47, 120),(48, 180),(49, 60),(50, 240),
(51, 45),(52, 150),(53, 30),(54, 360),(55, 120),
(56, 60),(57, 15),(58, 240),(59, 90),(60, 120);
 
-- ============================================================
-- 41. OPERACION_VINCULADA_ACTIVO
-- ============================================================
INSERT INTO OPERACION_VINCULADA_ACTIVO (id_operacion, id_activo) VALUES
(1, 1), (1, 2), (4, 4), (1, 12), (1, 17), (2, 36), (4, 40), (1, 47), (2, 51),
(7, 15), (7, 16), (5, 41), (6, 46), (6, 48), (6, 55), (5, 57),
(10, 3), (8, 5), (10, 6), (9, 7), (8, 13), (9, 14), (8, 18), (10, 19), (9, 20), (8, 21), (9, 24), (8, 38), (9, 39), (8, 50), (9, 53), (10, 56),
(13, 8), (13, 9), (12, 22), (11, 23), (11, 37), (12, 42), (13, 43), (13, 44), (12, 49), (13, 54), (11, 58), (12, 60),
(14, 10), (15, 11), (14, 25), (15, 45), (14, 52), (15, 59), (1, 26),  (9, 27),  (13, 28), (10, 29), (15, 30), (11, 31), (14, 32), (8, 33),  (5, 34),  (4, 35),
(10, 61), (1, 62),  (11, 63), (3, 64),  (12, 65), (11, 66), (10, 67), (11, 68), (12, 69), (7, 70),
(10, 71), (15, 72), (15, 73), (1, 74),  (5, 75),  (12, 76), (15, 77), (3, 78),  (12, 79), (5, 80),
(8, 81),  (14, 82), (15, 83), (9, 84),  (10, 85), (1, 86),  (15, 87), (10, 88), (6, 89),  (7, 90);
 
-- ============================================================
-- 42. HERRAMIENTA_GESTIONA_ACTIVO
-- ============================================================
INSERT INTO HERRAMIENTA_GESTIONA_ACTIVO (id_activo, id_herramienta) VALUES
(1,2),(2,2),(3,13),(4,2),(5,13),(6,21),(7,2),(8,13),(9,14),(10,2),
(11,14),(12,2),(13,13),(14,21),(15,2),(16,13),(17,2),(18,14),(19,21),(20,2),
(21,13),(22,14),(23,21),(24,13),(25,2),
(36,13),(37,14),(38,21),(39,13),(40,14),(41,21),(42,13),(43,14),(44,21),(45,13),
(46,6),(47,9),(48,6),(49,10),(50,9),(51,3),(52,6),(53,8),(54,11),(55,9),
(56,10),(57,8),(58,9),(59,3),(60,12), (64, 1),  (76, 4),  (71, 5),  
(79, 7),  (25, 15), (62, 16),(61, 17),(26, 18),(48, 19), (73, 20), 
(52, 22), (83, 23), (68, 24), (84, 25), (27, 2),  (28, 13), (29, 2),  (30, 14), (31, 2),  (32, 13), (33, 2),  (34, 14), (35, 2),
(63, 1),  (65, 17), (66, 16), (67, 20), (69, 1),  (70, 17), (72, 4),  (74, 4),  (75, 4),
(77, 4),  (78, 4),  (80, 4),  (81, 4),  (82, 4),  (89, 4),  (90, 4),  (85, 25), (86, 23),
(87, 25), (88, 23);
 
-- ============================================================
-- 43. EQUIPO_TRABAJA_OBJETO
-- ============================================================
INSERT INTO EQUIPO_TRABAJA_OBJETO(id_activo, id_equipo, fecha_acceso) VALUES
(1, 1, '2020-01-15'), (2, 2, '2020-01-15'), (4, 3, '2021-01-10'), (12, 4, '2021-06-15'), (36, 1, '2020-02-01'), (40, 2, '2022-02-28'), (47, 3, '2020-06-01'), (51, 4, '2021-03-10'),
(15, 5, '2023-03-15'), (16, 6, '2022-11-01'),(17, 1, '2020-01-15'), (41, 7, '2022-05-10'), (46, 8, '2020-06-01'), (48, 9, '2021-01-15'), (55, 5, '2021-11-01'), (57, 6, '2023-02-01'),
(3, 10, '2020-03-01'), (5, 11, '2021-05-20'), (6, 12, '2021-06-01'), (7, 13, '2022-01-15'), (13, 10, '2022-07-01'), (14, 11, '2023-01-20'), (18, 12, '2022-02-14'), (19, 13, '2022-09-30'), (20, 10, '2023-04-01'), (21, 11, '2023-05-15'), (24, 12, '2023-06-01'), (38, 13, '2021-07-01'), (39, 10, '2021-10-15'), (50, 11, '2022-05-01'), (53, 12, '2022-11-15'), (56, 13, '2022-09-01'),
(8, 14, '2022-03-10'), (9, 15, '2022-04-01'), (22, 16, '2022-06-20'), (23, 17, '2023-01-10'), (37, 14, '2023-02-15'), (42, 15, '2020-11-01'), (43, 16, '2022-08-20'), (44, 17, '2023-04-10'), (49, 14, '2021-09-01'), (54, 15, '2023-01-01'), (58, 16, '2023-06-15'), (60, 17, '2023-07-01'),
(10, 18, '2020-09-01'), (11, 19, '2021-01-01'), (25, 20, '2022-12-01'), (45, 18, '2021-12-01'), (52, 19, '2021-07-01'), (59, 20, '2021-08-20');
 
-- ============================================================
-- 44. FUENTE_IMPACTA_OBJETO
-- ============================================================
INSERT INTO FUENTE_IMPACTA_OBJETO(id_fuente, id_activo) VALUES
(1, 1),(1, 2),(1, 12),(1, 17),(1, 36),(1, 47),(1, 51),
(2, 3),(2, 6), (2, 19), (2, 37),(2, 39),(2, 48),(2, 53),(2, 13),(2, 58),
(3, 4),(3, 8),(3, 9),(3, 41),(3, 44),(3, 54),(3, 55),
(4,10),(4,11),(4, 25), (4,42), (4, 45), (4,52),(4,59),
(5, 3),(5, 5), (5, 21), (5, 36),(5, 38),(5, 14),(5, 50),
(6, 7),(6,24),(6,40),(6,56),
(7, 8),(7, 9), (7, 22), (7,44),(7,55),
(8,15),(8,44),(8,46),(8,57),
(9, 4),(9,38),(9,49),
(10,53),(10,57),(10,38),
(11,18),(11,20),(11,39),(11,43),
(12, 9),(12,44),(12,55),
(13, 7),(13,43),(13,38),
(14, 6),(14,13),(14,39),
(15,16),(15,23),(15,41),(15,60); 
 
-- ============================================================
-- 45. LINAJE_DATOS
-- ============================================================
INSERT INTO LINAJE_DATOS (id_activo_origen, id_activo_destino) VALUES
(76, 49), (77, 60), (78, 59), (79, 56),
(80, 53), (81, 57), (82, 52), (46, 62),
(47, 74), (48, 61), (49, 65), (50, 71),
(51, 62), (52, 64), (53, 67), (54, 71),
(55, 66), (55, 68), (56, 72), (57, 63),
(58, 62), (59, 70), (59, 73), (60, 65),
(61, 83), (61, 88), (62, 85), (74, 86),
(72, 87), (61, 84), (62, 1),  (62, 2),
(61, 3),  (74, 4),  (67, 6),  (72, 7),
(63, 8),  (68, 9),  (64, 10), (64, 11),
(74, 12), (62, 13), (61, 14), (69, 15),
(69, 16), (65, 33), (66, 37), (68, 44),
(70, 45), (75, 34), (83, 36), (84, 39),
(85, 19), (86, 35), (87, 24), (88, 27),
(89, 48), (90, 49), (1, 17),  (2, 17),
(26, 40), (28, 41), (1, 26), (3, 27),
(8, 28), (6, 29), (7, 30), 
(9, 31), (10, 32), (13, 33), (15, 34), (12, 35),
(61, 21),(74, 22),(64, 25);
 
-- ============================================================
-- 46. PROBLEMA
-- ============================================================
INSERT INTO PROBLEMA (id_problema, descripcion, fecha_origen, estado, id_fuente, id_activo) VALUES
(1,  'Datos duplicados en tabla de clientes',                       '2022-03-15','Resuelto',  2, 3),
(2,  'Valores nulos en campo ingreso_neto',                         '2022-07-22','Resuelto',  1, 1),
(3,  'Latencia excesiva en pipeline de ventas',                     '2022-11-10','Resuelto',  2, 6),
(4,  'Error de tipo de dato en columna fecha_transaccion',          '2023-01-05','Resuelto',  3, 8),
(5,  'Inconsistencia entre DWH Finanzas y sistema fuente',          '2023-02-18','Resuelto',  1, 2),
(6,  'Falla en carga incremental de inventario',                    '2023-04-30','Resuelto',  3, 9),
(7,  'Registros con NPS fuera de rango (-100 a 100)',               '2023-06-12','Resuelto',  6,24),
(8,  'Stock negativo en reporte de seguridad',                      '2023-07-25','No Resuelto',3, 9),
(9,  'Discrepancia en tasa de retención entre sistemas',            '2023-08-14','No Resuelto',5, 5),
(10, 'Timeout en query de tablero ejecutivo',                       '2023-09-01','No Resuelto',1,36),
(11, 'Datos de ausentismo no actualizados en DWH',                  '2023-10-03','No Resuelto',   4,10),
(12, 'Errores de encoding en carga de datos externos',              '2023-10-15','No Resuelto',  14, 6),
(13, 'Pipeline Kafka con mensajes perdidos',                        '2023-11-02','No Resuelto',   8,57),
(14, 'CAC duplicado por join incorrecto',                           '2023-11-20','No Resuelto',   2,13),
(15, 'LTV con cálculo erróneo por segmento',                        '2023-12-01','No Resuelto',   5,14),
(16, 'Tablero de costos con datos desactualizados',                 '2024-01-10','No Resuelto',   1,36),
(17, 'Proceso ETL de RRHH fallando los lunes',                      '2024-01-22','No Resuelto', 4,59),
(18, 'Forecast con outliers no filtrados',                          '2024-02-05','No Resuelto',2,58),
(19, 'Uptime registrado incorrectamente en fuente',                 '2024-02-20','No Resuelto',   8,44),
(20, 'Incidentes no reportados en tablero de riesgo',               '2024-03-01','No Resuelto',  15,41);
 
-- ============================================================
-- 47. PROBLEMA_RESUELTO
-- ============================================================
INSERT INTO PROBLEMA_RESUELTO (id_problema, fecha_resolucion, id_sujeto_resolutor, id_equipo_resolutor) VALUES
(1,'2022-04-10',1001, 8),
(2,'2022-08-15',1000, 8),
(3,'2022-12-05',1018, 8),
(4,'2023-02-20',1000, 8),   
(5,'2023-03-30',1010, 1),   
(6,'2023-06-15',1025, 14),   
(7,'2023-07-28',1022, 11);
 
-- ============================================================
-- REMEDIACIÓN DE SEGURIDAD
-- ============================================================
INSERT INTO ACCESO_FUENTE_DATOS (id_sujeto, id_fuente, fecha_desde, fecha_hasta, id_rol, id_perfil)
SELECT DISTINCT pe.id_sujeto, fio.id_fuente, m.fecha_ingreso, m.fecha_salida, 3, 2
FROM PERTENECE_A_EQUIPO pe
JOIN EQUIPO_TRABAJA_OBJETO eto ON pe.id_equipo = eto.id_equipo
JOIN FUENTE_IMPACTA_OBJETO fio ON eto.id_activo = fio.id_activo
JOIN MIEMBRO_UO m ON pe.id_sujeto = m.id_sujeto
LEFT JOIN ACCESO_FUENTE_DATOS afd ON pe.id_sujeto = afd.id_sujeto AND fio.id_fuente = afd.id_fuente
WHERE afd.id_sujeto IS NULL AND pe.fecha_hasta IS NULL;
UPDATE ACCESO_FUENTE_DATOS
SET fecha_hasta = CURRENT_DATE - 1
WHERE (id_sujeto, id_fuente) IN (
    SELECT afd.id_sujeto, afd.id_fuente
    FROM ACCESO_FUENTE_DATOS afd
    INNER JOIN MIEMBRO_UO m ON afd.id_sujeto = m.id_sujeto
    WHERE afd.fecha_hasta IS NULL AND afd.id_rol <> 1
      AND NOT EXISTS (
          SELECT 1
          FROM PERTENECE_A_EQUIPO pe
          INNER JOIN EQUIPO_TRABAJA_OBJETO eto ON pe.id_equipo = eto.id_equipo
          INNER JOIN FUENTE_IMPACTA_OBJETO fio ON eto.id_activo = fio.id_activo
          WHERE pe.id_sujeto = afd.id_sujeto
            AND fio.id_fuente = afd.id_fuente
            AND pe.fecha_hasta IS NULL
      )
);
COMMIT TRANSACTION;