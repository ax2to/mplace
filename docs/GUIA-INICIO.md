# GUIA DE INICIO (PARA PRINCIPIANTES)

Esta guia esta escrita para personas sin experiencia tecnica.
Sigue cada paso en orden.

## Paso 1 - Abrir la carpeta correcta
Accion:
- Abre tu terminal en la carpeta del proyecto `mplace`.

Resultado esperado:
- Puedes ver carpetas como `backend` y `frontend`.

## Paso 2 - Instalar backend
Accion:
```bash
cd backend
npm install
```

Resultado esperado:
- El comando termina sin errores.

## Paso 3 - Preparar base de datos
Accion:
- Ejecuta el script SQL incluido:

```bash
mysql -u root -p < sql/setup.sql
```

Resultado esperado:
- Se crea la base `mplace_app` con tablas `products` y `users`.
- Se insertan 3 productos demo y 1 usuario demo.

## Paso 4 - Configurar conexion del backend
Accion:
- Entra a `backend/` y copia el ejemplo:

```bash
cp .env.example .env
```

- Abre `.env` y completa `DB_HOST`, `DB_USER`, `DB_PASSWORD`, `DB_NAME`.

Resultado esperado:
- Credenciales correctas para tu maquina sin exponer secretos en el codigo.

## Paso 5 - Iniciar backend
Accion:
```bash
node index.js
```

Resultado esperado:
- Muestra: `Example app listening on port 3100`

## Paso 6 - Iniciar frontend (servidor local)
Accion recomendada:
- En otra terminal, en la carpeta raiz `mplace`:

```bash
npx serve .
```

Accion alternativa:
```bash
python -m http.server 5500
```

Resultado esperado:
- Tienes una URL local para abrir en navegador.

## Paso 7 - Abrir la app
Accion:
- En navegador abre:
  - `http://localhost:3000/frontend/index.html` (si usaste `serve`)
  - `http://localhost:5500/frontend/index.html` (si usaste Python)

Resultado esperado:
- Ves lista de productos.

## Paso 8 - Probar navegacion basica
Accion:
- En inicio: prueba la busqueda y presiona Enter.
- Abre login: `frontend/login.html`.
- Intenta entrar con usuario de prueba.

Resultado esperado:
- Si login es correcto, redirige a `frontend/admin/index.html`.

## Usuario de prueba (creado por setup.sql)
- Email: `demo@mplace.local`
- Password: `1234`

Si cambiaste o borraste datos por error, puedes ejecutar otra vez:

```bash
mysql -u root -p < sql/setup.sql
```

## Si algo no aparece
1. Verifica que backend siga encendido en puerto 3100.
2. Verifica que abriste `http://localhost/...` y no `file://`.
3. Revisa `docs/SOLUCION-PROBLEMAS.md`.
4. Si sigue igual, repite desde el Paso 3 (base de datos).
