# REVISION DEL PROYECTO (ENFOQUE EDUCATIVO)

Esta revision prioriza riesgos y claridad para contexto de aprendizaje.
No se aplican cambios de codigo en este documento.

## Hallazgos priorizados

### 1) ALTO - Riesgo de SQL Injection en busqueda
- Archivo: `/home/alan/projects/mplace/backend/index.js:27`
- Impacto: un texto malicioso podria alterar la consulta SQL.
- Por que importa para principiantes: enseña una practica insegura si se copia tal cual.
- Recomendacion siguiente: usar consultas parametrizadas (`?`) tambien para busqueda.

### 2) ALTO - Credenciales de base de datos hardcodeadas
- Archivo: `/home/alan/projects/mplace/backend/config.js:3`
- Impacto: exponer usuario y password en repositorio.
- Por que importa para principiantes: normaliza una mala practica de seguridad.
- Recomendacion siguiente: mover credenciales a variables de entorno (`.env`) y documentar ejemplo seguro.

### 3) ALTO - Password en texto plano
- Archivo: `/home/alan/projects/mplace/backend/index.js:77`
- Impacto: contraseñas sin hash son inseguras.
- Por que importa para principiantes: crea una base incorrecta para autenticacion real.
- Recomendacion siguiente: usar hash (por ejemplo `bcrypt`) y comparar hash en login.

### 4) MEDIO - Falta script de inicio en package.json
- Archivo: `/home/alan/projects/mplace/backend/package.json:6`
- Impacto: onboarding mas dificil para novatos.
- Por que importa para principiantes: comandos no estandar generan confusion.
- Recomendacion siguiente: agregar `"start": "node index.js"`.

### 5) MEDIO - Faltaba documentacion de schema/setup
- Archivo: `/home/alan/projects/mplace/README.md:1`
- Impacto: arranque bloqueado al no conocer tablas/datos necesarios.
- Por que importa para principiantes: primer intento falla y baja motivacion.
- Recomendacion siguiente: mantener actualizado `backend/sql/setup.sql` y guias paso a paso.

### 6) MEDIO - Acoplamiento a variable global en detalle
- Archivo: `/home/alan/projects/mplace/frontend/main.js:91`
- Impacto: `getApiItemData` usa `productId` global, dificultando mantenimiento.
- Por que importa para principiantes: confunde sobre alcance de variables.
- Recomendacion siguiente: pasar `productId` por parametro a `getApiItemData(productId)`.

## Riesgo residual
Aunque es un proyecto didactico, los puntos de seguridad deben explicarse explicitamente como "no apto para produccion".
