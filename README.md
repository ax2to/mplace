# MPLACE - Empieza Aqui

## 1) Que es este proyecto
MPLACE es un proyecto de ejemplo para aprender desarrollo web desde cero.

Piensalo como una mini tienda online educativa:
- Una parte muestra productos en el navegador (frontend).
- Otra parte entrega los datos (backend).
- Una base de datos guarda productos y usuarios.

Este proyecto esta hecho para aprender, no para produccion real.

## 2) Que aprenderas
Con este proyecto podras practicar:
- Como se conecta una pagina web con un servidor.
- Como leer datos desde MySQL.
- Como hacer busqueda de productos.
- Como probar un login simple.
- Como cambiar textos, estilos y datos para experimentar.

## 3) Requisitos
Necesitas instalar:
- Node.js LTS (incluye `npm`)
- MySQL 8+ (o compatible)
- Un navegador web (Chrome, Edge o Firefox)

Comandos para verificar:

### Windows (PowerShell)
```powershell
node -v
npm -v
mysql --version
```

### macOS / Linux (Terminal)
```bash
node -v
npm -v
mysql --version
```

Si uno de estos comandos falla, instala primero esa herramienta y vuelve a intentar.

## 4) Instalacion paso a paso
### Paso A - Clonar o abrir el proyecto
Ubicate en la carpeta del proyecto:

```bash
cd /ruta/a/mplace
```

### Paso B - Instalar dependencias del backend
```bash
cd backend
npm install
```

### Paso C - Crear base de datos y tablas
Usa el script incluido:

```bash
mysql -u root -p < sql/setup.sql
```

Si usas otro usuario distinto de `root`, cambia el comando por tu usuario.

Este script crea:
- Base de datos: `mplace_app`
- Tabla de productos: `products` (con 3 registros demo)
- Tabla de usuarios: `users` (con 1 usuario demo)

### Paso D - Revisar credenciales de conexion
Este proyecto lee credenciales desde:
- `backend/config.js`

Asegurate de que `user`, `password` y `database` coincidan con tu MySQL local.

## 5) Primer arranque (backend + frontend)
### Terminal 1: levantar backend
Desde `backend/`:

```bash
node index.js
```

Si todo va bien, veras:
`Example app listening on port 3100`

### Terminal 2: servir frontend localmente
Desde la carpeta raiz del proyecto (`mplace/`), usa una opcion:

Opcion recomendada (Node):
```bash
npx serve .
```

Opcion alternativa (Python):
```bash
python -m http.server 5500
```

Luego abre en tu navegador:
- `http://localhost:3000/frontend/index.html` (si usaste `npx serve`)
- o `http://localhost:5500/frontend/index.html` (si usaste Python)

Importante: no abras `frontend/index.html` con `file://`.

## 6) Verificacion rapida (si ves esto, esta bien)
Checklist rapido:
1. Abres `frontend/index.html` en `http://localhost`.
2. Ves tarjetas de productos con imagen, titulo y precio.
3. La busqueda responde cuando presionas Enter.
4. Login abre desde `frontend/login.html`.
5. Con usuario de prueba, redirige a `frontend/admin/index.html`.

Credenciales demo esperadas (creadas por `backend/sql/setup.sql`):
- Email: `demo@mplace.local`
- Password: `1234`

Si algo falla, revisa la guia de solucion de problemas en `docs/SOLUCION-PROBLEMAS.md`.

## 7) Enlaces a guias detalladas en /docs
- Guia principal para principiantes: `docs/GUIA-INICIO.md`
- Guia para profesores: `docs/GUIA-PROFESORES.md`
- Solucion de problemas: `docs/SOLUCION-PROBLEMAS.md`
- Glosario basico: `docs/GLOSARIO.md`
- Revision tecnica del proyecto: `docs/REVISION-PROYECTO.md`
