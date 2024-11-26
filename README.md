# Seminario: Bases de Datos Cardiovasculares

Este proyecto demuestra cómo trabajar con bases de datos locales utilizando R y PostgreSQL. Incluye ejemplos detallados de cómo crear, poblar y consultar tablas relacionadas con pacientes, diagnósticos médicos y tratamientos. Además, se presentan consultas que responden a preguntas específicas sobre los datos.

## Contenido

1. [Introducción](#introducción)
2. [Objetivos](#objetivos)
3. [Requisitos](#requisitos)
4. [Estructura de las Tablas](#estructura-de-las-tablas)
5. [Configuración](#configuración)
6. [Consultas Ejemplo](#consultas-ejemplo)

## Introducción

El proyecto utiliza un conjunto de datos sintéticos centrados en enfermedades cardiovasculares. Abarca tres tablas principales:

1. **Pacientes**: Información demográfica y clínica de los pacientes.
2. **Diagnósticos**: Detalles de enfermedades y su gravedad.
3. **Tratamientos**: Información sobre los tratamientos administrados.

El objetivo es analizar y responder preguntas clínicas clave usando consultas SQL.

## Objetivos

Este proyecto responde a las siguientes preguntas:

1. ¿Qué tratamiento tiene mayor éxito en pacientes con riesgo de muerte súbita?
2. ¿Qué pacientes tienen un diagnóstico de "Insuficiencia Cardíaca" con gravedad "Alta" y además son fumadores?
3. ¿Qué pacientes tienen un diagnóstico de gravedad "Crítica", un tratamiento quirúrgico y antecedentes familiares, en base a edad y género?
4. ¿Cuántos pacientes con un IMC mayor a 30 tienen diagnósticos con riesgo asociado de "Edema pulmonar"?

## Requisitos

### Software Necesario

- **R** (versión 4.0 o superior)
- **PostgreSQL** (versión 13 o superior)
- **RStudio** (opcional, para ejecutar el código en un entorno gráfico)

### Paquetes de R

- `DBI`
- `RPostgres`

## Estructura de las Tablas

### Tabla `pacientes`

Contiene información básica de los pacientes, como nombre, edad, género y factores de riesgo.  
**Columnas principales**:
- `ID_pacientes` (PRIMARY KEY)
- `Nombre`
- `Edad`
- `Género`
- `IMC`  
*(ver el código completo en el archivo `.Rmd` del proyecto).*

### Tabla `diagnosticos`

Describe los diagnósticos médicos asociados a los pacientes.  
**Columnas principales**:
- `ID_diagnostico` (PRIMARY KEY)
- `ID_Paciente` (FOREIGN KEY)
- `Gravedad`
- `Riesgo_asociado`

### Tabla `tratamientos`

Incluye información sobre los tratamientos administrados a los pacientes.  
**Columnas principales**:
- `ID_tratamiento` (PRIMARY KEY)
- `ID_Paciente` (FOREIGN KEY)
- `Tipo_tratamiento`

## Configuración

1. **Instalar PostgreSQL**  
   Descarga e instala PostgreSQL desde su [sitio oficial](https://www.postgresql.org/download/).

2. **Configurar la base de datos**  
   Crea una base de datos local llamada `postgres` y asegúrate de que el servidor esté en ejecución.

3. **Configurar R**  
   Instala los paquetes necesarios ejecutando:
   ```R
   install.packages(c("DBI", "RPostgres"))
