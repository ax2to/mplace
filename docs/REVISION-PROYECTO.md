# REVISION DEL PROYECTO (ENFOQUE EDUCATIVO)

Esta revision prioriza riesgos y claridad para contexto de aprendizaje.
No se aplican cambios de codigo en este documento.

## Tabla de seguimiento didactico

| Hallazgo | Issue | Rama | PR | Estado |
|---|---|---|---|---|
| SQL Injection en busqueda | [#1](https://github.com/ax2to/mplace/issues/1) | [fix/sql-injection-busqueda](https://github.com/ax2to/mplace/tree/fix/sql-injection-busqueda) | Pendiente | Issue creado, rama remota creada |
| Credenciales hardcodeadas | [#2](https://github.com/ax2to/mplace/issues/2) | [fix/credenciales-env-backend](https://github.com/ax2to/mplace/tree/fix/credenciales-env-backend) | Pendiente | Issue creado, rama remota creada |
| Password en texto plano | [#3](https://github.com/ax2to/mplace/issues/3) | [fix/hash-password-login](https://github.com/ax2to/mplace/tree/fix/hash-password-login) | Pendiente | Issue creado, rama remota creada |
| Falta script `start` | [#4](https://github.com/ax2to/mplace/issues/4) | [chore/script-start-backend](https://github.com/ax2to/mplace/tree/chore/script-start-backend) | Pendiente | Issue creado, rama remota creada |
| Consistencia docs + setup SQL | [#5](https://github.com/ax2to/mplace/issues/5) | [docs/setup-schema-consistente](https://github.com/ax2to/mplace/tree/docs/setup-schema-consistente) | Pendiente | Issue creado, rama remota creada |
| Acoplamiento `productId` global | [#6](https://github.com/ax2to/mplace/issues/6) | [fix/product-detail-parametro](https://github.com/ax2to/mplace/tree/fix/product-detail-parametro) | Pendiente | Issue creado, rama remota creada |

## Hallazgos priorizados

### 1) ALTO - Riesgo de SQL Injection en busqueda
- Archivo: `backend/index.js:27`
- Impacto: un texto malicioso podria alterar la consulta SQL.
- Por que importa para principiantes: enseña una practica insegura si se copia tal cual.
- Recomendacion siguiente: usar consultas parametrizadas (`?`) tambien para busqueda.

### 2) ALTO - Credenciales de base de datos hardcodeadas
- Archivo: `backend/config.js:3`
- Impacto: exponer usuario y password en repositorio.
- Por que importa para principiantes: normaliza una mala practica de seguridad.
- Recomendacion siguiente: mover credenciales a variables de entorno (`.env`) y documentar ejemplo seguro.

### 3) ALTO - Password en texto plano
- Archivo: `backend/index.js:77`
- Impacto: contraseñas sin hash son inseguras.
- Por que importa para principiantes: crea una base incorrecta para autenticacion real.
- Recomendacion siguiente: usar hash (por ejemplo `bcrypt`) y comparar hash en login.

### 4) MEDIO - Falta script de inicio en package.json
- Archivo: `backend/package.json:6`
- Impacto: onboarding mas dificil para novatos.
- Por que importa para principiantes: comandos no estandar generan confusion.
- Recomendacion siguiente: agregar `"start": "node index.js"`.

### 5) MEDIO - Faltaba documentacion de schema/setup
- Archivo: `README.md:1`
- Impacto: arranque bloqueado al no conocer tablas/datos necesarios.
- Por que importa para principiantes: primer intento falla y baja motivacion.
- Recomendacion siguiente: mantener actualizado `backend/sql/setup.sql` y guias paso a paso.

### 6) MEDIO - Acoplamiento a variable global en detalle
- Archivo: `frontend/main.js:91`
- Impacto: `getApiItemData` usa `productId` global, dificultando mantenimiento.
- Por que importa para principiantes: confunde sobre alcance de variables.
- Recomendacion siguiente: pasar `productId` por parametro a `getApiItemData(productId)`.

## Riesgo residual
Aunque es un proyecto didactico, los puntos de seguridad deben explicarse explicitamente como "no apto para produccion".
