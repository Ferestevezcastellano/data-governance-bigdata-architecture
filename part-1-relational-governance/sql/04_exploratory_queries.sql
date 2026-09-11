-- =========================================================================
-- QUERIES EXPLORATORIAS
-- OBJETIVO: Vistas analíticas y auditoría de gobierno de datos. Además, se analizan algunas RA
-- RESULTADO ESPERADO: Tablas de datos para interpretación
-- =========================================================================

-- Querie 1: RA 10.Auditoría Semántica de Funciones y Perfiles.

SELECT m.email_corporativo,
    pt.nombre AS puesto_rrhh,
    r.nombre AS rol_gobernanza,
    p.nombre AS perfil_acceso,
    fd.nombre AS fuente_accedida,
    fd.tipo_fuente
FROM MIEMBRO_UO m
    -- Obtenemos el cargo formal en RRHH
    INNER JOIN PUESTO_TRABAJO pt ON m.id_puesto_trabajo = pt.id_puesto_trabajo
    -- Buscamos los accesos efectivos que tiene el sujeto
    INNER JOIN ACCESO_FUENTE_DATOS afd ON m.id_sujeto = afd.id_sujeto
    -- Recuperamos el rol funcional (ej. Data Steward) y el perfil técnico (ej. Solo Lectura)
    INNER JOIN ROL r ON afd.id_rol = r.id_rol
    INNER JOIN PERFIL p ON afd.id_perfil = p.id_perfil
    -- Traemos el nombre de la fuente a la que accede
    INNER JOIN FUENTE_DE_DATOS fd ON afd.id_fuente = fd.id_fuente
-- Filtramos únicamente los accesos que actualmente están vigentes (sin fecha de fin)
WHERE afd.fecha_hasta IS NULL
ORDER BY pt.nombre, r.nombre;

-- Querie 2: RA12 y RA13. Compatibilidad operativa de herramientas y objetos.

SELECT o.tipo_objeto,
    a.tipo_activo,
    h.nombre AS herramienta,
    h.tipo_herramienta AS subtipo_herramienta,
    pr.nombre AS proveedor,
    op.descripcion AS operacion_vinculada,
    d.nombre AS departamento_operacion
FROM OBJETO o
    INNER JOIN ACTIVO a ON o.id_activo = a.id_activo
    -- LEFT JOIN progresivos: Trazamos la ruta desde el Activo hacia la Herramienta, y luego hacia la Operación
    -- Usamos LEFT para no perder objetos que aún no tengan herramientas u operaciones documentadas
    LEFT JOIN HERRAMIENTA_GESTIONA_ACTIVO hga ON o.id_activo = hga.id_activo
    LEFT JOIN HERRAMIENTA h ON hga.id_herramienta = h.id_herramienta
    LEFT JOIN PROVEEDOR pr ON h.id_proveedor = pr.id_proveedor
    LEFT JOIN OPERACION_VINCULADA_ACTIVO ova ON o.id_activo = ova.id_activo
    LEFT JOIN OPERACION op ON ova.id_operacion = op.id_operacion
    LEFT JOIN DEPARTAMENTO d ON op.id_departamento = d.id_departamento
ORDER BY o.tipo_objeto, h.nombre;

-- Querie 3: Muestra qué perfiles estan asociados a cada rol en distintas fuentes de datos.

SELECT
    r.nombre AS rol,
    p.nombre AS perfil,
    COUNT(*) AS cantidad_
FROM ACCESO_FUENTE_DATOS a
    INNER JOIN ROL r ON a.id_rol = r.id_rol
    INNER JOIN PERFIL p ON p.id_perfil = a.id_perfil
GROUP BY r.nombre, p.nombre
ORDER BY r.nombre;

-- Querie 4: Auditoría de Accesos Externos Activos a Bases Relacionales.

SELECT ext.email_contacto,
    fd.nombre AS fuente_afectada,
    fd.tipo_fuente,
    fd.modelo AS motor_bd,
    r.nombre AS rol,
    p.nombre AS perfil,
    afd.fecha_desde AS desde,
    afd.fecha_hasta AS hasta
FROM EXTERNO ext
    -- Conectamos al consultor externo con sus permisos vigentes
    INNER JOIN ACCESO_FUENTE_DATOS afd ON ext.id_sujeto = afd.id_sujeto
    INNER JOIN FUENTE_DE_DATOS fd ON afd.id_fuente = fd.id_fuente
    INNER JOIN ROL r ON afd.id_rol = r.id_rol
    INNER JOIN PERFIL p ON afd.id_perfil = p.id_perfil
-- Filtramos por el tipo de tecnología crítica ('Relacional')
WHERE fd.tipo_fuente = 'Relacional'
    -- Aseguramos que el acceso sea actual (nulo o en el futuro)
    AND (
        afd.fecha_hasta IS NULL
        OR afd.fecha_hasta >= CURRENT_DATE
    )
ORDER BY ext.email_contacto;

-- Querie 5: Análisis de Linaje Recursivo. Simula la caída del ETL Financiero ID=47.

WITH RECURSIVE Trazabilidad AS (
    -- CASO BASE: Buscamos qué impacta directamente el Activo ID=47
    SELECT id_activo_origen,
        id_activo_destino,
        1 AS nivel_profundidad
    FROM LINAJE_DATOS
    WHERE id_activo_origen = 47
    
    UNION ALL
    
    -- PASO RECURSIVO: Buscamos qué impactan los activos destino que encontramos en el paso anterior
    SELECT ld.id_activo_origen,
        ld.id_activo_destino,
        -- Incrementamos el nivel de profundidad en cada iteración
        t.nivel_profundidad + 1
    FROM LINAJE_DATOS ld
        INNER JOIN Trazabilidad t ON ld.id_activo_origen = t.id_activo_destino
)

SELECT DISTINCT t.nivel_profundidad,
    a.nombre AS activo_afectado,
    a.tipo_activo,
    df.nombre AS concepto_negocio
FROM Trazabilidad t
    JOIN ACTIVO a ON t.id_activo_destino = a.id_activo
    JOIN DEFINICION_FUNCIONAL df ON a.id_definicion = df.id_definicion
ORDER BY t.nivel_profundidad, a.tipo_activo;

-- Querie 6: Linaje inverso: ¿de dónde viene un tablero clave? (Panel ID=26).

WITH RECURSIVE Upstream AS (
    -- CASO BASE: Empezamos desde el destino final (el Tablero ID=26)
    SELECT id_activo_origen,
        id_activo_destino,
        1 AS nivel
    FROM LINAJE_DATOS
    WHERE id_activo_destino = 26
    
    UNION ALL
    
    -- PASO RECURSIVO: Ahora unimos el ORIGEN del linaje con el DESTINO del paso previo (caminamos hacia atrás)
    SELECT ld.id_activo_origen,
        ld.id_activo_destino,
        u.nivel + 1
    FROM LINAJE_DATOS ld
        INNER JOIN Upstream u ON ld.id_activo_destino = u.id_activo_origen
)
SELECT DISTINCT u.nivel AS pasos_desde_origen,
    a.id_activo,
    a.nombre AS activo_origen,
    a.tipo_activo,
    df.nombre AS concepto
FROM Upstream u
    INNER JOIN ACTIVO a ON u.id_activo_origen = a.id_activo
    INNER JOIN DEFINICION_FUNCIONAL df ON a.id_definicion = df.id_definicion
-- Ordenamos descendentemente para ver desde la fuente primaria hasta el reporte
ORDER BY u.nivel DESC, a.tipo_activo;

-- Querie 7: Problemas abiertos sobre fuentes/objetos de alto impacto. 

SELECT p.id_problema,
    p.descripcion,
    p.fecha_origen,
    p.estado,
    -- Calculamos la antigüedad del problema restando la fecha de origen al día actual
    CURRENT_DATE - p.fecha_origen AS dias_abierto,
    fd.nombre AS fuente_afectada,
    fd.tipo_fuente,
    a.nombre AS objeto_afectado,
    o.tipo_objeto
FROM PROBLEMA p
    INNER JOIN FUENTE_DE_DATOS fd ON p.id_fuente = fd.id_fuente
    INNER JOIN ACTIVO a ON p.id_activo = a.id_activo
    INNER JOIN OBJETO o ON p.id_activo = o.id_activo
    -- Usamos LEFT JOIN contra la tabla de resoluciones para detectar los no resueltos (NULL)
    LEFT JOIN PROBLEMA_RESUELTO pr ON p.id_problema = pr.id_problema
-- Buscamos los que no tienen registro físico de resolución y cuyo estado lógico indique lo mismo
WHERE pr.id_problema IS NULL
    AND p.estado <> 'Resuelto'
    -- Filtramos para enfocar la atención en activos críticos de consumo final
    AND fd.tipo_fuente = 'Relacional'               
    AND o.tipo_objeto IN ('Reporte', 'Tablero')
ORDER BY dias_abierto DESC;

-- Querie 8: Rendimiento de Equipos. Ranking de eficiencia en resolución de problemas.

SELECT eq.nombre AS equipo_resolutor,
    COUNT(pr.id_problema) AS incidentes_resueltos,
    -- Promediamos la diferencia de días entre la resolución y el origen del incidente
    ROUND(AVG(pr.fecha_resolucion - p.fecha_origen), 1) AS dias_promedio_resolucion
FROM EQUIPO eq
    JOIN PROBLEMA_RESUELTO pr ON eq.id_equipo = pr.id_equipo_resolutor
    JOIN PROBLEMA p ON pr.id_problema = p.id_problema
GROUP BY eq.nombre
-- Premiamos volumen de resolución y velocidad (menor tiempo promedio)
ORDER BY incidentes_resueltos DESC,
    dias_promedio_resolucion ASC;

-- Querie 9: Distribución física de servidores.

SELECT pa.nombre AS pais,
    prov.nombre AS provincia,
    COUNT(fue.id_fuente) AS cantidad_fuentes_fisicas
FROM PAIS pa
    -- Construimos la jerarquía completa desde País hasta la Dirección Física
    JOIN PROVINCIA prov ON pa.id_pais = prov.id_pais
    JOIN LOCALIDAD loc ON prov.id_provincia = loc.id_provincia
    JOIN CALLE c ON loc.id_localidad = c.id_localidad
    JOIN DIRECCION_FISICA df ON c.id_calle = df.id_calle
    JOIN FUENTE_UBICADA_EN fue ON df.id_ubicacion = fue.id_ubicacion
GROUP BY pa.nombre,
    prov.nombre
ORDER BY cantidad_fuentes_fisicas DESC;

-- Querie 10: Distribución de nubes por región.

SELECT r.nombre AS region_cloud,
    COUNT(DISTINCT fue.id_fuente) AS cantidad_fuentes,
    STRING_AGG(
        fd.nombre,
        ', '
        ORDER BY fd.nombre
    ) AS fuentes
FROM FUENTE_UBICADA_EN fue -- Trazamos la ruta hacia la nube saltando a través de la entidad superclase UBICACION
    INNER JOIN UBICACION u ON fue.id_ubicacion = u.id_ubicacion
    INNER JOIN NUBE_EN_REGION nr ON u.id_ubicacion = nr.id_ubicacion
    INNER JOIN REGION r ON nr.id_region = r.id_region
    INNER JOIN FUENTE_DE_DATOS fd ON fue.id_fuente = fd.id_fuente
GROUP BY r.nombre
ORDER BY cantidad_fuentes DESC;

-- Querie 11: Auditoría de Estado de Licencias. 

SELECT h.nombre AS herramienta,
    pr.nombre AS proveedor,
    l.fecha_desde,
    l.fecha_hasta,
    -- Clasificamos el estado de la licencia comparando la fecha de fin con el sistema operativo
    CASE
        WHEN l.fecha_hasta IS NULL THEN 'Licencia Perpetua'
        WHEN l.fecha_hasta < CURRENT_DATE THEN 'Vencida'
        ELSE 'Licencia Activa'
    END AS estado_licencia
FROM HERRAMIENTA h
    JOIN PROVEEDOR pr ON h.id_proveedor = pr.id_proveedor
    JOIN LICENCIA l ON h.id_herramienta = l.id_herramienta
ORDER BY l.fecha_hasta ASC;

-- Querie 12: Mapa completo de responsabilidad de activos. 

SELECT a.id_activo,
    a.nombre AS activo,
    o.tipo_objeto,
    a.tipo_activo,
    fv.nombre AS fase,
    eq.nombre AS equipo_responsable,
    d.nombre AS departamento,
    m_dir.email_corporativo AS lider_equipo,
    fd.nombre AS fuente_origen,
    fd.tipo_fuente
FROM ACTIVO a
    INNER JOIN OBJETO o ON a.id_activo = o.id_activo
    INNER JOIN FASE_VIDA_ACTIVO fv ON a.id_fase = fv.id_fase
    -- LEFT JOINS para traer información de equipos y responsables sin perder objetos
    LEFT JOIN EQUIPO_TRABAJA_OBJETO eto ON a.id_activo = eto.id_activo
    LEFT JOIN EQUIPO eq ON eto.id_equipo = eq.id_equipo
    LEFT JOIN DEPARTAMENTO d ON eq.id_departamento = d.id_departamento
    -- Buscamos al líder actual (sin fecha de baja) del equipo
    LEFT JOIN DIRIGE_EQUIPO de ON eq.id_equipo = de.id_equipo
        AND de.fecha_hasta IS NULL
    LEFT JOIN MIEMBRO_UO m_dir ON de.id_sujeto = m_dir.id_sujeto
    -- Recuperamos la fuente que alimenta físicamente a este objeto
    LEFT JOIN FUENTE_IMPACTA_OBJETO fio ON a.id_activo = fio.id_activo
    LEFT JOIN FUENTE_DE_DATOS fd ON fio.id_fuente = fd.id_fuente
ORDER BY d.nombre,
    eq.nombre,
    a.tipo_activo;

-- Querie 13: Glosario de negocio y cobertura en el catálogo. 

SELECT df.id_definicion,
    df.nombre AS termino_glosario,
    COUNT(a.id_activo) AS cantidad_activos,
    -- Agrupamos los tipos de activos encontrados en una lista unificada
    STRING_AGG(DISTINCT a.tipo_activo, ', ') AS tipos_activo_usados
FROM DEFINICION_FUNCIONAL df
    -- Usamos LEFT JOIN para ver incluso los términos del glosario que están "huérfanos" (0 activos)
    LEFT JOIN ACTIVO a ON df.id_definicion = a.id_definicion
GROUP BY df.id_definicion,
    df.nombre
ORDER BY cantidad_activos ASC;

-- Querie 14: Análisis de gobernanza por departamento. 

SELECT d.nombre AS departamento,
    COUNT(DISTINCT eq.id_equipo) AS equipos,
    COUNT(DISTINCT eto.id_activo) AS objetos_gestionados,
    COUNT(DISTINCT hga.id_herramienta) AS herramientas_distintas,
    -- Usamos la cláusula FILTER de PostgreSQL para contar solo los problemas sin resolver
    COUNT(DISTINCT p.id_problema) FILTER (
        WHERE p.estado <> 'Resuelto'
    ) AS problemas_abiertos,
    COUNT(DISTINCT pr.id_problema) AS problemas_resueltos
FROM DEPARTAMENTO d
    LEFT JOIN EQUIPO eq ON eq.id_departamento = d.id_departamento
    LEFT JOIN EQUIPO_TRABAJA_OBJETO eto ON eto.id_equipo = eq.id_equipo
    LEFT JOIN HERRAMIENTA_GESTIONA_ACTIVO hga ON hga.id_activo = eto.id_activo
    -- Cruzamos problemas usando tanto el objeto afectado como la responsabilidad del equipo resolutor
    LEFT JOIN PROBLEMA_RESUELTO pr ON pr.id_equipo_resolutor = eq.id_equipo
    LEFT JOIN PROBLEMA p ON p.id_activo = eto.id_activo
GROUP BY d.nombre
ORDER BY objetos_gestionados DESC;

-- Querie 15: Ciclo de vida de los activos: distribución por fase y tipo.
 
SELECT
    a.tipo_activo,
    fv.nombre AS fase_vida,
    COUNT(*) AS cantidad,
    -- Calculamos la proporción porcentual utilizando Funciones de Ventana (Window Functions).
    -- Calcula el total por "tipo_activo" y saca el porcentaje que representa cada "fase_vida".
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY a.tipo_activo), 1) AS pct_dentro_tipo
FROM ACTIVO a
    INNER JOIN FASE_VIDA_ACTIVO fv ON a.id_fase = fv.id_fase
GROUP BY fv.nombre, a.tipo_activo
ORDER BY a.tipo_activo, fv.nombre;

-- Querie 16: Rotación histórica de miembros por equipo.
 
SELECT eq.nombre AS equipo,
    d.nombre AS departamento,
    COUNT(DISTINCT pe.id_sujeto) AS miembros_historicos,
    COUNT(
        DISTINCT CASE
            WHEN pe.fecha_hasta IS NULL THEN pe.id_sujeto
        END
    ) AS miembros_activos,
    COUNT(
        DISTINCT CASE
            WHEN pe.fecha_hasta IS NOT NULL THEN pe.id_sujeto
        END
    ) AS miembros_que_salieron,
    -- Cálculo de rotación: (Salidas / Total Histórico) * 100, evitando división por cero con NULLIF
    ROUND(
        COUNT(
            DISTINCT CASE
                WHEN pe.fecha_hasta IS NOT NULL THEN pe.id_sujeto
            END
        ) * 100.0 / NULLIF(COUNT(DISTINCT pe.id_sujeto), 0),
        1
    ) AS pct_rotacion
FROM EQUIPO eq
    INNER JOIN DEPARTAMENTO d ON eq.id_departamento = d.id_departamento
    LEFT JOIN PERTENECE_A_EQUIPO pe ON eq.id_equipo = pe.id_equipo
GROUP BY eq.nombre,
    d.nombre
ORDER BY pct_rotacion DESC NULLS LAST,
    miembros_historicos DESC;
 
-- Querie 17: Accesos vigentes mas longevos sin revision.
 
SELECT -- COALESCE trae el primer valor no nulo, unificando los emails corporativos y externos
    COALESCE(m.email_corporativo, e.email_contacto) AS sujeto,
    s.tipo_sujeto,
    fd.nombre AS fuente,
    r.nombre AS rol,
    p.nombre AS perfil,
    afd.fecha_desde,
    -- DATE_PART con AGE calcula con precisión cuántos años exactos lleva el permiso vivo
    DATE_PART('year', AGE(CURRENT_DATE, afd.fecha_desde)) AS anios_activo,
    -- Y cuántos meses sobrantes tiene (ej: 2 años y 4 meses)
    DATE_PART('month', AGE(CURRENT_DATE, afd.fecha_desde)) AS meses_adicionales
FROM ACCESO_FUENTE_DATOS afd
    INNER JOIN SUJETO s ON afd.id_sujeto = s.id_sujeto
    INNER JOIN FUENTE_DE_DATOS fd ON afd.id_fuente = fd.id_fuente
    INNER JOIN ROL r ON afd.id_rol = r.id_rol
    INNER JOIN PERFIL p ON afd.id_perfil = p.id_perfil
    LEFT JOIN MIEMBRO_UO m ON afd.id_sujeto = m.id_sujeto
    LEFT JOIN EXTERNO e ON afd.id_sujeto = e.id_sujeto
WHERE afd.fecha_hasta IS NULL
ORDER BY afd.fecha_desde ASC
LIMIT 30;

-- Querie 18: Permisos efectivos por tipo de fuente de datos.
 
SELECT fd.tipo_fuente,
    pe.nombre AS permiso,
    -- Contamos cuántos usuarios únicos tienen este permiso efectivo
    COUNT(DISTINCT afd.id_sujeto) AS sujetos_con_permiso
FROM FUENTE_DE_DATOS fd -- Trazamos la ruta: Fuente -> Acceso -> Perfil -> Matriz de Permisos -> Permiso Específico
    INNER JOIN ACCESO_FUENTE_DATOS afd ON fd.id_fuente = afd.id_fuente
    INNER JOIN PERFIL p ON afd.id_perfil = p.id_perfil
    INNER JOIN PERFIL_TIENE_PERMISO ptp ON p.id_perfil = ptp.id_perfil
    INNER JOIN PERMISO pe ON ptp.id_permiso = pe.id_permiso
WHERE (
        afd.fecha_hasta IS NULL
        OR afd.fecha_hasta >= CURRENT_DATE
    )
GROUP BY fd.tipo_fuente,
    pe.nombre
ORDER BY fd.tipo_fuente,
    sujetos_con_permiso DESC;

-- Querie 19: Identifica el catálogo de las fuentes.

SELECT fd.id_fuente,
    fd.nombre AS fuente_de_datos,
    fd.tipo_fuente,
    fd.modelo AS motor,
    -- Agrupamos las interacciones físicas y lógicas
    COUNT(DISTINCT fio.id_activo) AS cantidad_objetos_impactados,
    COUNT(DISTINCT afd.id_sujeto) AS cantidad_usuarios_con_acceso,
    -- Clasificamos el nivel de riesgo de la fuente analizando sus métricas operativas
    CASE
        WHEN COUNT(DISTINCT fio.id_activo) = 0 AND COUNT(DISTINCT afd.id_sujeto) = 0 
            THEN 'Riesgo Alto: Fuente aislada (Sin objetos ni accesos)'
        WHEN COUNT(DISTINCT fio.id_activo) = 0 
            THEN 'Advertencia: Tiene accesos pero no impacta objetos operativos'
        WHEN COUNT(DISTINCT afd.id_sujeto) = 0 
            THEN 'Advertencia: Alimenta objetos pero nadie tiene acceso formal'
        ELSE 'Saludable: Gobernanza completa'
    END AS estado_gobernanza
FROM FUENTE_DE_DATOS fd
    -- Buscamos el impacto físico de la base
    LEFT JOIN FUENTE_IMPACTA_OBJETO fio ON fd.id_fuente = fio.id_fuente
    -- Buscamos usuarios vigentes con acceso a la base
    LEFT JOIN ACCESO_FUENTE_DATOS afd ON fd.id_fuente = afd.id_fuente 
        AND (afd.fecha_hasta IS NULL OR afd.fecha_hasta >= CURRENT_DATE)
GROUP BY fd.id_fuente, fd.nombre, fd.tipo_fuente, fd.modelo
ORDER BY estado_gobernanza, fd.nombre;

-- Querie 20: Identifica personal técnico sin equipo y clasifica el riesgo según su antigüedad.

SELECT m.id_sujeto,
    m.email_corporativo,
    pt.nombre AS puesto,
    m.fecha_ingreso,
    -- Calculamos los días que lleva la persona en la UO
    CURRENT_DATE - m.fecha_ingreso AS dias_en_la_empresa,
    -- Generamos una alerta basada en los días sin equipo asignado
    CASE
        WHEN CURRENT_DATE - m.fecha_ingreso <= 30 THEN 'Normal: En proceso de Onboarding'
        WHEN CURRENT_DATE - m.fecha_ingreso <= 90 THEN 'Alerta: Asignación demorada'
        ELSE 'Riesgo Crítico: Shadow IT o empleado fantasma'
    END AS nivel_de_riesgo
FROM MIEMBRO_UO m
    INNER JOIN PUESTO_TRABAJO pt ON m.id_puesto_trabajo = pt.id_puesto_trabajo
    -- Buscamos si tiene alguna membresía de equipo actualmente abierta (sin fecha fin)
    LEFT JOIN PERTENECE_A_EQUIPO pe ON m.id_sujeto = pe.id_sujeto 
        AND pe.fecha_hasta IS NULL
-- Filtramos: Solo empleados activos (no echados) que NO tienen equipo (pe.id_sujeto IS NULL)
WHERE m.fecha_salida IS NULL
    AND pe.id_sujeto IS NULL
ORDER BY dias_en_la_empresa DESC;

-- En este caso, por cómo están los registros, no hay casos de personal técnico sin equipo

-- Querie 21: Análisis de Impacto Operativo. Simula una contingencia en infraestructura para ver qué áreas de negocio se detienen.

SELECT
    fd.nombre AS fuente_origen,
    d.nombre AS departamento_afectado,
    op.descripcion AS operacion_en_riesgo,
    COUNT(DISTINCT a.id_activo) AS activos_comprometidos
-- Se vinculan las fuentes de datos con los activos y operaciones asociadas para identificar el impacto potencial sobre cada departamento.
FROM FUENTE_DE_DATOS fd
INNER JOIN FUENTE_IMPACTA_OBJETO fio 
    ON fd.id_fuente = fio.id_fuente
INNER JOIN ACTIVO a 
    ON fio.id_activo = a.id_activo
INNER JOIN OPERACION_VINCULADA_ACTIVO ova 
    ON a.id_activo = ova.id_activo
INNER JOIN OPERACION op 
    ON ova.id_operacion = op.id_operacion
INNER JOIN DEPARTAMENTO d 
    ON op.id_departamento = d.id_departamento
GROUP BY
    fd.nombre,
    d.nombre,
    op.descripcion
-- Se ordena priorizando las fuentes con mayor cantidad de activos comprometidos.
ORDER BY
    activos_comprometidos DESC,
    fuente_origen;