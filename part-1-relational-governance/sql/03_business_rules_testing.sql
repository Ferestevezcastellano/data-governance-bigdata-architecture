-- =========================================================================
-- TESTING
-- OBJETIVO: Pruebas unitarias de integridad y Restricciones Adicionales (RA).
-- RESULTADO ESPERADO GLOBAL: 0 FILAS en todas las consultas.
-- =========================================================================

-- Test 1: RA1 & RA2. Consistencia temporal general y de permanencia.

SELECT 'MIEMBRO_UO' AS tabla,
    id_sujeto::TEXT AS id,
    fecha_ingreso AS desde,
    fecha_salida AS hasta
FROM MIEMBRO_UO
WHERE fecha_ingreso > fecha_salida
UNION ALL
SELECT 'ACCESO_FUENTE_DATOS',
    id_sujeto::TEXT,
    fecha_desde,
    fecha_hasta
FROM ACCESO_FUENTE_DATOS
WHERE fecha_desde > fecha_hasta
UNION ALL
SELECT 'PERTENECE_A_EQUIPO',
    id_sujeto::TEXT,
    fecha_desde,
    fecha_hasta
FROM PERTENECE_A_EQUIPO
WHERE fecha_desde > fecha_hasta
UNION ALL
SELECT 'DIRIGE_EQUIPO',
    id_sujeto::TEXT,
    fecha_desde,
    fecha_hasta
FROM DIRIGE_EQUIPO
WHERE fecha_desde > fecha_hasta
UNION ALL
SELECT 'Licencia',
    id_herramienta::TEXT,
    fecha_desde,
    fecha_hasta
FROM LICENCIA
WHERE fecha_desde > fecha_hasta;

-- Test 2.a: RA3. Contención temporal organizacional
SELECT pe.id_sujeto,
    pe.id_equipo,
    pe.fecha_desde AS inicio_equipo,
    pe.fecha_hasta AS fin_equipo,
    m.fecha_ingreso AS ingreso_org,
    m.fecha_salida AS salida_org,
    -- Clasificamos el tipo exacto de violación temporal para facilitar la corrección
    CASE
        WHEN pe.fecha_desde < m.fecha_ingreso THEN 'Inicio en equipo ANTES de ingreso a la organización'
        WHEN m.fecha_salida IS NOT NULL
        AND pe.fecha_hasta IS NOT NULL
        AND pe.fecha_hasta > m.fecha_salida THEN 'Fin en equipo DESPUÉS de baja en la organización'
        WHEN m.fecha_salida IS NOT NULL
        AND pe.fecha_hasta IS NULL THEN 'Equipo sin fecha de fin pero miembro tiene baja registrada'
    END AS motivo_violacion
FROM PERTENECE_A_EQUIPO pe
    INNER JOIN MIEMBRO_UO m ON pe.id_sujeto = m.id_sujeto
-- Buscamos cualquier escenario donde las fechas del equipo desborden las fechas de permanencia del empleado
WHERE pe.fecha_desde < m.fecha_ingreso
    OR (
        m.fecha_salida IS NOT NULL
        AND pe.fecha_hasta IS NOT NULL
        AND pe.fecha_hasta > m.fecha_salida
    )
    OR (
        m.fecha_salida IS NOT NULL
        AND pe.fecha_hasta IS NULL
    );
 
-- Test 2.b: RA3. Mismo control para DIRIGE_EQUIPO.

SELECT de.id_sujeto,
    de.id_equipo,
    de.fecha_desde AS inicio_liderazgo,
    de.fecha_hasta AS fin_liderazgo,
    m.fecha_ingreso AS ingreso_org,
    m.fecha_salida AS salida_org,
    CASE
        WHEN de.fecha_desde < m.fecha_ingreso THEN 'Liderazgo ANTES de ingreso a la organización'
        WHEN m.fecha_salida IS NOT NULL
        AND de.fecha_hasta IS NOT NULL
        AND de.fecha_hasta > m.fecha_salida THEN 'Liderazgo DESPUÉS de baja en la organización'
        WHEN m.fecha_salida IS NOT NULL
        AND de.fecha_hasta IS NULL THEN 'Liderazgo sin fecha de fin pero miembro tiene baja registrada'
    END AS motivo_violacion
FROM DIRIGE_EQUIPO de
    INNER JOIN MIEMBRO_UO m ON de.id_sujeto = m.id_sujeto
WHERE de.fecha_desde < m.fecha_ingreso
    OR (
        m.fecha_salida IS NOT NULL
        AND de.fecha_hasta IS NOT NULL
        AND de.fecha_hasta > m.fecha_salida
    )
    OR (
        m.fecha_salida IS NOT NULL
        AND de.fecha_hasta IS NULL
    );
    
-- Test 3.a: RA4. Solapamiento en PERTENECE_A_EQUIPO.

SELECT p1.id_sujeto,
    p1.id_equipo AS equipo_A,
    p1.fecha_desde AS inicio_A,
    COALESCE(p1.fecha_hasta, DATE '2099-12-31') AS fin_A,
    p2.id_equipo AS equipo_B,
    p2.fecha_desde AS inicio_B,
    COALESCE(p2.fecha_hasta, DATE '2099-12-31') AS fin_B
FROM PERTENECE_A_EQUIPO p1
    -- Self-Join: Cruzamos la tabla consigo misma para comparar registros del mismo sujeto
    INNER JOIN PERTENECE_A_EQUIPO p2 ON p1.id_sujeto = p2.id_sujeto
    -- p1.id < p2.id evita que comparemos el mismo registro consigo mismo o que salgan duplicados invertidos
    AND p1.id_equipo < p2.id_equipo
    -- Lógica de solapamiento de rangos: Inicio_A <= Fin_B y Fin_A >= Inicio_B
    -- COALESCE transforma los nulos (vigentes) en una fecha lejana para que el operador matemático funcione
    AND p1.fecha_desde <= COALESCE(p2.fecha_hasta, DATE '2099-12-31')
    AND COALESCE(p1.fecha_hasta, DATE '2099-12-31') >= p2.fecha_desde;
 
-- Test 3.b: RA4. Solapamiento en DIRIGE_EQUIPO.

SELECT d1.id_sujeto,
    d1.id_equipo AS equipo_A,
    d1.fecha_desde AS inicio_A,
    COALESCE(d1.fecha_hasta, DATE '2099-12-31') AS fin_A,
    d2.id_equipo AS equipo_B,
    d2.fecha_desde AS inicio_B,
    COALESCE(d2.fecha_hasta, DATE '2099-12-31') AS fin_B
FROM DIRIGE_EQUIPO d1
    INNER JOIN DIRIGE_EQUIPO d2 ON d1.id_sujeto = d2.id_sujeto
    AND d1.id_equipo < d2.id_equipo
    AND d1.fecha_desde <= COALESCE(d2.fecha_hasta, DATE '2099-12-31')
    AND COALESCE(d1.fecha_hasta, DATE '2099-12-31') >= d2.fecha_desde;
 
-- Test 3.c: RA14. Liderazgo sin pertenencia simultánea.

SELECT de.id_sujeto,
    de.id_equipo,
    de.fecha_desde AS inicio_liderazgo,
    COALESCE(de.fecha_hasta, DATE '2099-12-31') AS fin_liderazgo
FROM DIRIGE_EQUIPO de
-- Verificamos que NO EXISTA un registro de pertenencia que cubra completamente el período de liderazgo
WHERE NOT EXISTS (
        SELECT 1
        FROM PERTENECE_A_EQUIPO pe
        WHERE pe.id_sujeto = de.id_sujeto
            AND pe.id_equipo = de.id_equipo
            AND pe.fecha_desde <= COALESCE(de.fecha_hasta, DATE '2099-12-31')
            AND COALESCE(pe.fecha_hasta, DATE '2099-12-31') >= de.fecha_desde
    );

-- Test 4: RA5. Contención temporal de accesos para miembros UO. 

SELECT afd.id_sujeto,
    afd.id_fuente,
    afd.fecha_desde AS inicio_acceso,
    afd.fecha_hasta AS fin_acceso,
    m.fecha_ingreso AS ingreso_org,
    m.fecha_salida AS salida_org,
    CASE
        WHEN afd.fecha_desde < m.fecha_ingreso THEN 'Acceso comienza ANTES del ingreso a la organización'
        WHEN m.fecha_salida IS NOT NULL
        AND afd.fecha_hasta IS NOT NULL
        AND afd.fecha_hasta > m.fecha_salida THEN 'Acceso termina DESPUÉS de la baja en la organización'
        WHEN m.fecha_salida IS NOT NULL
        AND afd.fecha_hasta IS NULL THEN 'Acceso sin fecha de fin pero miembro tiene baja registrada'
    END AS motivo_violacion
FROM ACCESO_FUENTE_DATOS afd
    INNER JOIN MIEMBRO_UO m ON afd.id_sujeto = m.id_sujeto
WHERE afd.fecha_desde < m.fecha_ingreso
    OR (
        m.fecha_salida IS NOT NULL
        AND afd.fecha_hasta IS NOT NULL
        AND afd.fecha_hasta > m.fecha_salida
    )
    OR (
        m.fecha_salida IS NOT NULL
        AND afd.fecha_hasta IS NULL
    );

-- Test 5.a: RA6. Ciclo de vida de resolución de incidentes (Fechas).

SELECT
    p.id_problema,
    p.fecha_origen,
    pr.fecha_resolucion,
    pr.fecha_resolucion - p.fecha_origen AS dias_negativos
FROM PROBLEMA p
INNER JOIN PROBLEMA_RESUELTO pr ON p.id_problema = pr.id_problema
WHERE p.fecha_origen > pr.fecha_resolucion;

-- Test 5.b: RA6. El resolutor debe estar activo en la org en la fecha de resolución.

SELECT
    pr.id_problema,
    pr.id_sujeto_resolutor,
    pr.fecha_resolucion,
    m.fecha_ingreso,
    m.fecha_salida
FROM PROBLEMA_RESUELTO pr
INNER JOIN MIEMBRO_UO m ON pr.id_sujeto_resolutor = m.id_sujeto
WHERE pr.fecha_resolucion < m.fecha_ingreso
   OR (m.fecha_salida IS NOT NULL AND pr.fecha_resolucion > m.fecha_salida);

-- Test 6: RA7, RA8, RA9. Unicidad de identificadores organizacionales.

SELECT 'Email corporativo duplicado' AS tipo_error,
    email_corporativo AS valor
FROM MIEMBRO_UO
GROUP BY email_corporativo
HAVING COUNT(*) > 1 -- Agrupa y trae los que se repiten
UNION ALL
SELECT 'Email externo duplicado',
    email_contacto
FROM EXTERNO
GROUP BY email_contacto
HAVING COUNT(*) > 1
UNION ALL
SELECT 'CUIT duplicado',
    cuit
FROM ORGANIZACION
GROUP BY cuit
HAVING COUNT(*) > 1
UNION ALL
SELECT 'Teléfono de organización duplicado',
    telefono
FROM ORGANIZACION
WHERE telefono IS NOT NULL
GROUP BY telefono
HAVING COUNT(*) > 1;

-- Test 7: RA11. Fuga de privilegios vía pertenencia a equipo.

SELECT
    pe.id_sujeto,
    pe.id_equipo,
    eto.id_activo AS objeto_afectado,
    fio.id_fuente AS fuente_sin_acceso,
    fd.nombre AS nombre_fuente,
    a.nombre  AS nombre_objeto
FROM PERTENECE_A_EQUIPO pe
-- Reconstruimos la cadena transitiva: Sujeto -> Equipo -> Objeto -> Fuente
INNER JOIN EQUIPO_TRABAJA_OBJETO eto ON pe.id_equipo = eto.id_equipo
INNER JOIN FUENTE_IMPACTA_OBJETO fio ON eto.id_activo = fio.id_activo
INNER JOIN FUENTE_DE_DATOS fd ON fio.id_fuente = fd.id_fuente
INNER JOIN ACTIVO a ON eto.id_activo = a.id_activo
LEFT JOIN ACCESO_FUENTE_DATOS afd
    ON  pe.id_sujeto  = afd.id_sujeto
    AND fio.id_fuente = afd.id_fuente
    AND afd.fecha_desde <= CURRENT_DATE
    AND (afd.fecha_hasta IS NULL OR afd.fecha_hasta >= CURRENT_DATE)
-- Falla el test si el empleado está activo en el equipo PERO no le encontramos (NULL) un acceso formal a la fuente
WHERE pe.fecha_hasta IS NULL        
  AND afd.id_sujeto IS NULL;    

-- Test 8: RA15. Consistencia transitiva departamento-equipo-operación. 
SELECT eq.id_equipo,
    eq.nombre AS equipo,
    eq.id_departamento AS depto_equipo,
    d_eq.nombre AS nombre_depto_equipo,
    op.id_operacion,
    op.descripcion AS operacion,
    op.id_departamento AS depto_operacion,
    d_op.nombre AS nombre_depto_operacion,
    a.id_activo,
    a.nombre AS activo_vinculador
FROM EQUIPO_TRABAJA_OBJETO eto
    INNER JOIN EQUIPO eq ON eto.id_equipo = eq.id_equipo
    INNER JOIN DEPARTAMENTO d_eq ON eq.id_departamento = d_eq.id_departamento
    INNER JOIN OPERACION_VINCULADA_ACTIVO ova ON eto.id_activo = ova.id_activo
    INNER JOIN OPERACION op ON ova.id_operacion = op.id_operacion
    INNER JOIN DEPARTAMENTO d_op ON op.id_departamento = d_op.id_departamento
    INNER JOIN ACTIVO a ON eto.id_activo = a.id_activo
-- Falla si el departamento dueño de la operación no coincide con el departamento al que pertenece el equipo
WHERE eq.id_departamento <> op.id_departamento;

-- Test 9: RA16. Aciclicidad del grafo de linaje. 

WITH RECURSIVE Ciclos AS (
    -- Caso base: todos los arcos directos
    SELECT id_activo_origen,
        id_activo_destino,
        ARRAY [id_activo_origen] AS camino,
        FALSE AS tiene_ciclo
    FROM LINAJE_DATOS
    UNION ALL
    -- Paso recursivo: extender el camino sin repetir nodos visitados
    SELECT ld.id_activo_origen,
        ld.id_activo_destino,
        -- Añadimos el nuevo nodo al array (historial)
        c.camino || ld.id_activo_origen,
        -- Detectamos si el destino actual YA estaba en el historial (ciclo)
        ld.id_activo_destino = ANY(c.camino)
    FROM LINAJE_DATOS ld
        INNER JOIN Ciclos c ON ld.id_activo_origen = c.id_activo_destino
    -- Cláusula de poda: detiene la recursión si detecta loop, evitando colgar el motor SQL
    WHERE NOT (ld.id_activo_origen = ANY(c.camino)) 
)
SELECT DISTINCT id_activo_origen AS nodo_inicio,
    id_activo_destino AS nodo_ciclo_detectado,
    camino
FROM Ciclos
-- El test falla si encuentra al menos un ciclo verdadero
WHERE tiene_ciclo;

-- Test 10: RA17. Integridad referencial de agregación (Problema).
SELECT p.id_problema,
    p.id_fuente,
    p.id_activo,
    fd.nombre AS fuente,
    a.nombre AS activo
FROM PROBLEMA p
    LEFT JOIN FUENTE_IMPACTA_OBJETO fio ON p.id_fuente = fio.id_fuente
    AND p.id_activo = fio.id_activo
    LEFT JOIN FUENTE_DE_DATOS fd ON p.id_fuente = fd.id_fuente
    LEFT JOIN ACTIVO a ON p.id_activo = a.id_activo
-- Si la dependencia no existe en la realidad (NULL), el incidente es inválido
WHERE fio.id_fuente IS NULL;

-- Test 11: RA18 y RA19. Coherencia integral en la resolución de incidentes.

SELECT pr.id_problema,
    pr.id_sujeto_resolutor,
    pr.id_equipo_resolutor,
    pr.fecha_resolucion,
    p.id_fuente,
    fd.nombre AS fuente_del_problema,
    m.email_corporativo,
    -- Clasificamos dinámicamente cuál de las dos reglas de negocio se rompió
    CASE
        WHEN pe.id_sujeto IS NULL THEN 'Resolutor no pertenecia al equipo en la fecha de resolucion'
        WHEN afd.id_sujeto IS NULL THEN 'Resolutor no tenia acceso a la fuente en la fecha de resolucion'
    END AS motivo_violacion
FROM PROBLEMA_RESUELTO pr -- Traemos los datos del incidente y de la fuente afectada
    INNER JOIN PROBLEMA p ON pr.id_problema = p.id_problema
    INNER JOIN FUENTE_DE_DATOS fd ON p.id_fuente = fd.id_fuente
    INNER JOIN MIEMBRO_UO m ON pr.id_sujeto_resolutor = m.id_sujeto -- CONTROL 1 (RA18): Buscamos si el resolutor formaba parte del equipo asignado, EXACTAMENTE en esa fecha
    LEFT JOIN PERTENECE_A_EQUIPO pe ON pr.id_sujeto_resolutor = pe.id_sujeto
    AND pr.id_equipo_resolutor = pe.id_equipo
    AND pe.fecha_desde <= pr.fecha_resolucion
    AND (
        pe.fecha_hasta IS NULL
        OR pe.fecha_hasta >= pr.fecha_resolucion
    ) -- CONTROL 2 (RA19): Buscamos si el resolutor tenía permisos formales para entrar a esa base, EXACTAMENTE en esa fecha
    LEFT JOIN ACCESO_FUENTE_DATOS afd ON pr.id_sujeto_resolutor = afd.id_sujeto
    AND p.id_fuente = afd.id_fuente
    AND afd.fecha_desde <= pr.fecha_resolucion
    AND (
        afd.fecha_hasta IS NULL
        OR afd.fecha_hasta >= pr.fecha_resolucion
    ) -- El test falla y devuelve la fila si el empleado no pasa ALGUNO de los dos controles de auditoría
WHERE pe.id_sujeto IS NULL
    OR afd.id_sujeto IS NULL;

-- Test 12: RA20. Conectividad obligatoria de activos no-objeto.
SELECT a.id_activo,
    a.nombre,
    a.tipo_activo
FROM ACTIVO a
    LEFT JOIN LINAJE_DATOS lo ON a.id_activo = lo.id_activo_origen
    LEFT JOIN LINAJE_DATOS ld ON a.id_activo = ld.id_activo_destino
WHERE a.tipo_activo <> 'Objeto'
    -- Falla si no es ni origen ni destino (completamente desconectado)
    AND lo.id_activo_origen IS NULL
    AND ld.id_activo_destino IS NULL;

-- Test 13: RA21. Responsabilidad Operativa Obligatoria.
SELECT o.id_activo,
    a.nombre,
    o.tipo_objeto,
    a.tipo_activo,
    fv.nombre AS fase_vida
FROM OBJETO o
    INNER JOIN ACTIVO a ON o.id_activo = a.id_activo
    INNER JOIN FASE_VIDA_ACTIVO fv ON a.id_fase = fv.id_fase
    -- Buscamos si existe al menos un registro histórico/actual de un equipo gestionándolo
    LEFT JOIN EQUIPO_TRABAJA_OBJETO eto ON o.id_activo = eto.id_activo
WHERE eto.id_activo IS NULL;

-- Test 14: RA22. Coherencia de Sujetos.
SELECT s.id_sujeto,
    s.tipo_sujeto,
    s.formacion
FROM SUJETO s
WHERE s.tipo_sujeto = 'Organizacion'
  AND s.formacion <> 'No Profesional';

-- Test 15: RA23. Composición Mínima de Equipos. 

SELECT 
    e.id_equipo,
    e.nombre AS nombre_equipo,
    -- Identifica exactamente cuál es el problema para facilitar la gestión en RRHH
    CASE
        WHEN pe.id_equipo IS NULL AND de.id_equipo IS NULL THEN 'Falta miembro activo Y director activo'
        WHEN pe.id_equipo IS NULL THEN 'Falta miembro activo'
        WHEN de.id_equipo IS NULL THEN 'Falta director activo'
    END AS motivo_violacion
FROM EQUIPO e
    -- Subconsulta: Busca si el equipo tiene al menos un empleado vigente hoy
    LEFT JOIN (
        SELECT DISTINCT id_equipo 
        FROM PERTENECE_A_EQUIPO 
        WHERE fecha_hasta IS NULL OR fecha_hasta >= CURRENT_DATE
    ) pe ON e.id_equipo = pe.id_equipo
    -- Subconsulta: Busca si el equipo tiene un líder vigente hoy
    LEFT JOIN (
        SELECT DISTINCT id_equipo 
        FROM DIRIGE_EQUIPO 
        WHERE fecha_hasta IS NULL OR fecha_hasta >= CURRENT_DATE
    ) de ON e.id_equipo = de.id_equipo
WHERE pe.id_equipo IS NULL 
   OR de.id_equipo IS NULL;


-- Test 16: RA24. Propiedad Obligatoria de Datos 
SELECT 
    fd.id_fuente,
    fd.nombre AS fuente_huerfana,
    'Falta asignar un Data Owner' AS motivo_violacion
FROM FUENTE_DE_DATOS fd
    -- Usamos LEFT JOIN buscando específicamente si existe alguien con el Rol 1 (Data Owner) y acceso vigente
    LEFT JOIN ACCESO_FUENTE_DATOS afd 
        ON fd.id_fuente = afd.id_fuente 
        AND afd.id_rol = 1 
        AND (afd.fecha_hasta IS NULL OR afd.fecha_hasta >= CURRENT_DATE)
-- Falla si la fuente no cruzó con ningún usuario bajo esas condiciones (es decir, afd.id_sujeto es NULL)
WHERE afd.id_sujeto IS NULL;

-- Test 17: Uso Operativo Obligatorio de HERRAMIENTA.

SELECT h.id_herramienta,
    h.nombre,
    h.tipo_herramienta,
    pr.nombre AS proveedor
FROM HERRAMIENTA h
    INNER JOIN PROVEEDOR pr ON h.id_proveedor = pr.id_proveedor
    -- Buscamos interacciones operativas de la herramienta
    LEFT JOIN HERRAMIENTA_GESTIONA_ACTIVO hga ON h.id_herramienta = hga.id_herramienta
WHERE hga.id_activo IS NULL;

-- Test 18: Herencia Completa de UBICACION (Disjunta/Total).

SELECT u.id_ubicacion,
    CASE
        WHEN df.id_ubicacion IS NOT NULL THEN 'Direccion_Fisica'
        WHEN nr.id_ubicacion IS NOT NULL THEN 'Nube_en_región'
        WHEN ap.id_ubicacion IS NOT NULL THEN 'Aplicacion'
        ELSE 'SIN SUBTIPO'
    END AS subtipo_detectado
FROM UBICACION u
    -- Buscamos el registro hijo en todas las tablas posibles
    LEFT JOIN DIRECCION_FISICA df ON u.id_ubicacion = df.id_ubicacion
    LEFT JOIN NUBE_EN_REGION nr ON u.id_ubicacion = nr.id_ubicacion
    LEFT JOIN APLICACION ap ON u.id_ubicacion = ap.id_ubicacion
-- Falla si no lo encuentra en ninguna (Registro Huérfano en la tabla padre)
WHERE df.id_ubicacion IS NULL
    AND nr.id_ubicacion IS NULL
    AND ap.id_ubicacion IS NULL;

-- Test 19: Activos sin ninguna fuente que los alimente. 
SELECT a.id_activo,
    a.nombre,
    o.tipo_objeto,
    a.tipo_activo
FROM ACTIVO a
    INNER JOIN OBJETO o ON a.id_activo = o.id_activo
    LEFT JOIN FUENTE_IMPACTA_OBJETO fio ON a.id_activo = fio.id_activo
    LEFT JOIN LINAJE_DATOS ld ON a.id_activo = ld.id_activo_destino
-- Falla si el objeto está suspendido en el aire (sin orígenes directos ni indirectos)
WHERE fio.id_activo IS NULL
    AND ld.id_activo_destino IS NULL;

-- Test 20: Consistencia de discriminador vs tabla hija (HERRAMIENTA).
SELECT h.id_herramienta,
    h.nombre,
    h.tipo_herramienta AS tipo_declarado,
    -- Determinamos el tipo real en base a en qué tabla física lo encontramos
    CASE
        WHEN s.id_herramienta IS NOT NULL THEN 'Software'
        WHEN l.id_herramienta IS NOT NULL THEN 'Licencia'
        WHEN ho.id_herramienta IS NOT NULL THEN 'Herramienta Open Source'
        ELSE 'SIN SUBTIPO'
    END AS tipo_real
FROM HERRAMIENTA h
    LEFT JOIN SOFTWARE s ON h.id_herramienta = s.id_herramienta
    LEFT JOIN LICENCIA l ON h.id_herramienta = l.id_herramienta
    LEFT JOIN HERRAMIENTA_OPEN_SOURCE ho ON h.id_herramienta = ho.id_herramienta
-- Falla si el string tipificado en el padre no matchea con la ubicación física del registro hijo
WHERE h.tipo_herramienta <> CASE
        WHEN s.id_herramienta IS NOT NULL THEN 'Software'
        WHEN l.id_herramienta IS NOT NULL THEN 'Licencia'
        WHEN ho.id_herramienta IS NOT NULL THEN 'Herramienta Open Source'
        ELSE 'SIN SUBTIPO'
    END;

-- Test 21: Herramientas sin subtipo físico (Participación Total HERRAMIENTA).

SELECT h.id_herramienta,
    h.nombre,
    h.tipo_herramienta
FROM HERRAMIENTA h
    LEFT JOIN SOFTWARE s ON h.id_herramienta = s.id_herramienta
    LEFT JOIN LICENCIA l ON h.id_herramienta = l.id_herramienta
    LEFT JOIN HERRAMIENTA_OPEN_SOURCE ho ON h.id_herramienta = ho.id_herramienta
WHERE s.id_herramienta IS NULL
    AND l.id_herramienta IS NULL
    AND ho.id_herramienta IS NULL;

-- Test 22: Herencia Completa de SUJETO (Participación Total de superclase).

SELECT s.id_sujeto,
    s.tipo_sujeto,
    CASE
        WHEN m.id_sujeto IS NOT NULL THEN 'MIEMBRO_UO'
        WHEN e.id_sujeto IS NOT NULL THEN 'Externo'
        WHEN o.id_sujeto IS NOT NULL THEN 'Organizacion'
        ELSE 'SIN SUBTIPO'
    END AS subtipo_real
FROM SUJETO s
    LEFT JOIN MIEMBRO_UO m ON s.id_sujeto = m.id_sujeto
    LEFT JOIN EXTERNO e ON s.id_sujeto = e.id_sujeto
    LEFT JOIN ORGANIZACION o ON s.id_sujeto = o.id_sujeto
WHERE m.id_sujeto IS NULL
    AND e.id_sujeto IS NULL
    AND o.id_sujeto IS NULL;

-- Test 23: Consistencia de discriminador de ACTIVO frente a la subclase OBJETO.

SELECT a.id_activo, a.nombre, a.tipo_activo
FROM ACTIVO a 
    LEFT JOIN OBJETO o ON a.id_activo = o.id_activo
-- Verifica las dos violaciones lógicas: Dice ser Objeto y no está, o NO dice ser Objeto pero sí está guardado en la tabla hija
WHERE (a.tipo_activo = 'Objeto' AND o.id_activo IS NULL)
   OR (a.tipo_activo <> 'Objeto' AND o.id_activo IS NOT NULL);

-- Test 24: Consistencia de discriminador vs tabla hija (OBJETO).
SELECT o.id_activo, o.tipo_objeto AS tipo_declarado,
    CASE WHEN r.id_activo IS NOT NULL THEN 'Reporte'
         WHEN t.id_activo IS NOT NULL THEN 'Tablero'
         WHEN p.id_activo IS NOT NULL THEN 'Proceso' ELSE 'SIN SUBTIPO' END AS tipo_real
FROM OBJETO o
    LEFT JOIN REPORTE r ON o.id_activo = r.id_activo
    LEFT JOIN TABLERO t ON o.id_activo = t.id_activo
    LEFT JOIN PROCESO p ON o.id_activo = p.id_activo
WHERE o.tipo_objeto <> CASE WHEN r.id_activo IS NOT NULL THEN 'Reporte'
         WHEN t.id_activo IS NOT NULL THEN 'Tablero'
         WHEN p.id_activo IS NOT NULL THEN 'Proceso' ELSE 'SIN SUBTIPO' END;

-- Test 25: Coherencia de Estado Lógico vs Registro Físico de Resolución.

SELECT p.id_problema, p.descripcion, p.estado
FROM PROBLEMA p 
    LEFT JOIN PROBLEMA_RESUELTO pr ON p.id_problema = pr.id_problema
-- Falla si la bandera está en verde pero no existe la evidencia física de la solución
WHERE p.estado = 'Resuelto' AND pr.id_problema IS NULL;


-- Test 26: Participación Total de OBJETO en FUENTE_IMPACTA_OBJETO. Todo objeto final (Reporte/Tablero/Proceso) debe estar 
-- conectado directamente a al menos una fuente de datos, según lo define el modelo.
SELECT 
    o.id_activo,
    a.nombre AS objeto_huerfano,
    o.tipo_objeto,
    'Falta conexión a Fuente de Datos' AS motivo_violacion
FROM OBJETO o
    INNER JOIN ACTIVO a ON o.id_activo = a.id_activo
    LEFT JOIN FUENTE_IMPACTA_OBJETO fio ON o.id_activo = fio.id_activo
-- Falla si el objeto no tiene ningún registro que lo vincule a una fuente
WHERE fio.id_fuente IS NULL;

-- Test 27: Participación Total de EQUIPO en EQUIPO_TRABAJA_OBJETO. Todo equipo registrado debe operar o consumir al menos un activo.
SELECT e.id_equipo,
    e.nombre AS equipo_sin_activos
FROM EQUIPO e
    LEFT JOIN EQUIPO_TRABAJA_OBJETO eto ON e.id_equipo = eto.id_equipo
WHERE eto.id_equipo IS NULL;

-- Test 28: Participación Total de OPERACION en OPERACION_VINCULADA_ACTIVO. Toda operación de negocio definida debe estar soportada por al menos un activo de datos.
SELECT op.id_operacion,
    op.descripcion AS operacion_sin_activos
FROM OPERACION op
    LEFT JOIN OPERACION_VINCULADA_ACTIVO ova ON op.id_operacion = ova.id_operacion
WHERE ova.id_operacion IS NULL;

-- Test 29: Participación Total de ACTIVO en OPERACION_VINCULADA_ACTIVO. Evita "Activos sin Valor de Negocio".
SELECT a.id_activo,
    a.nombre AS objeto_sin_operacion
FROM ACTIVO a
    LEFT JOIN OPERACION_VINCULADA_ACTIVO ova ON a.id_activo = ova.id_activo
WHERE ova.id_activo IS NULL;

-- Test 30: Participación Total de NUBE_EN_REGION (Validación de Nube aislada).
SELECT u.id_ubicacion,
    'Ubicacion tipo Nube sin region asignada' AS motivo_violacion
FROM UBICACION u
    LEFT JOIN NUBE_EN_REGION nr ON u.id_ubicacion = nr.id_ubicacion
WHERE u.tipo_ubicacion = 'Nube'
    AND nr.id_ubicacion IS NULL;

-- Test 31: Participación Total de ROL en ACCESO_FUENTE_DATOS. Todo rol de gobernanza definido en el catálogo debe estar asignado a al menos un usuario activo.
SELECT r.id_rol,
    r.nombre AS rol_no_utilizado
FROM ROL r
    LEFT JOIN ACCESO_FUENTE_DATOS afd ON r.id_rol = afd.id_rol
    AND (
        afd.fecha_hasta IS NULL
        OR afd.fecha_hasta >= CURRENT_DATE
    )
WHERE afd.id_rol IS NULL;

-- Test 32: Participación Total de ACTIVO en HERRAMIENTA_GESTIONA_ACTIVO. Todo activo debe tener una herramienta tecnológica asociada para su gestión/consumo.
SELECT a.id_activo,
    a.nombre AS objeto_sin_herramienta
FROM ACTIVO a LEFT JOIN HERRAMIENTA_GESTIONA_ACTIVO hga ON a.id_activo = hga.id_activo
WHERE hga.id_activo IS NULL;
