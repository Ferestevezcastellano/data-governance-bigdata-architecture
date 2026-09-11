# Enterprise Data Governance & Distributed Big Data Architecture

![SQL](https://img.shields.io/badge/Language-SQL%20%2F%20PostgreSQL-336791?style=flat&logo=postgresql&logoColor=white)
![Apache Spark](https://img.shields.io/badge/Big_Data-Apache%20Spark-E25A1C?style=flat&logo=apachespark&logoColor=white)
![PySpark](https://img.shields.io/badge/Framework-PySpark-3776AB?style=flat&logo=python&logoColor=white)
![Great Expectations](https://img.shields.io/badge/Data_Quality-Great%20Expectations-FF5A00?style=flat)
![MongoDB](https://img.shields.io/badge/NoSQL-MongoDB-47A248?style=flat&logo=mongodb&logoColor=white)

---

## Executive Summary

Este repositorio contiene el diseño, modelado e implementación integral de una **arquitectura corporativa de Gobierno y Calidad de Datos**, evolucionando desde un **Modelo Relacional normalizado (PostgreSQL)** hacia un **Pipeline Distribuido bajo patrón Medallion (Apache Spark, Great Expectations y MongoDB)**.

El proyecto simula el ciclo completo del dato en una organización:
1. **Gobierno Relacional (OLTP / Data Integrity):** Diseño de un modelo entidad-relación corporativo (25+ entidades), definición de DDL riguroso con restricciones de integridad y una suite de pruebas automatizadas en SQL para auditar 22 Reglas de Acción/Negocio (RA).
2. **Procesamiento Distribuido & Big Data (Medallion Pipeline):** Ingesta, limpieza y transformación masiva de datos mediante **Apache Spark** (Spark SQL y RDDs), incorporación de **Data Quality Gates** con **Great Expectations** y persistencia políglota para almacenamiento semiestructurado en **MongoDB**.

---

## Arquitectura de la Solución

```mermaid
flowchart TD
    subgraph Parte 1: Gobierno Relacional
        A[Requerimientos de Negocio] --> B[Diseño DER / Modelo Relacional\n+25 Tablas]
        B --> C[DDL PostgreSQL\nConstraints & Triggers]
        C --> D[DML: Inserción de Datos]
        D --> E[Testing Suite SQL\n37 Tests de Integridad & 22 Reglas de Negocio]
        D --> F[Consultas Analíticas & Exploratorias]
    end

    subgraph Parte 2: Arquitectura Distribuida Medallion
        G[Datos Crudos / Logs Masivos] --> H[Capa Bronze:\nAlmacenamiento e Ingesta]
        H --> I[PySpark MapReduce & Spark SQL:\nTransformación & Agregación]
        I --> J{Data Quality Gate\nGreat Expectations}
        J -- Pasa Validación --> K[Capa Gold:\nDatos Curados / Tablas Analíticas]
        J -- Falla Validación --> L[Dead Letter Queue / Alertas de Calidad]
        K --> M[Persistencia NoSQL / Políglota\nMongoDB BSON]
    end
