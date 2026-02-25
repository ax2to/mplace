# SOLUCION DE PROBLEMAS

Usa esta tabla cuando algo no funcione.

| Sintoma | Causa probable | Como solucionarlo (paso a paso) | Como verificar |
|---|---|---|---|
| No carga productos | Backend apagado o error de conexion API | 1) Entra a `backend/`. 2) Ejecuta `node index.js`. 3) Confirma mensaje de puerto 3100. | Abre `http://localhost:3100/api/products` y debe mostrar JSON. |
| Error de conexion MySQL | Credenciales incorrectas en `backend/config.js` o MySQL apagado | 1) Inicia servicio MySQL. 2) Revisa `host/user/password/database` en `backend/config.js`. 3) Reejecuta `mysql -u root -p < sql/setup.sql` si faltan tablas. | Backend inicia sin errores y `/api/products` responde. |
| Pantalla en blanco en frontend | Frontend abierto con `file://` o servidor local no iniciado | 1) En carpeta raiz ejecuta `npx serve .` o `python -m http.server 5500`. 2) Abre URL `http://localhost:3000/...` o `http://localhost:5500/...`. | Se ven tarjetas de productos en `frontend/index.html`. |
| Login siempre falla | Usuario no existe en DB o credenciales mal escritas | 1) Verifica que corriste `setup.sql`. 2) Usa usuario demo (`demo@mplace.local` / `1234`). 3) Revisa que backend este activo. | Al enviar formulario, redirige a `frontend/admin/index.html`. |

## Comprobaciones rapidas utiles
- Probar backend directo: `http://localhost:3100/api/products`
- Probar frontend inicio: `http://localhost:3000/frontend/index.html` o `http://localhost:5500/frontend/index.html`
- Probar login: `http://localhost:3000/frontend/login.html` o `http://localhost:5500/frontend/login.html`

## Cuando pedir ayuda
Pide apoyo si:
1. Ya repetiste los pasos y sigue el error.
2. El terminal muestra errores que no entiendes.
3. No puedes conectar MySQL aunque las credenciales parecen correctas.
