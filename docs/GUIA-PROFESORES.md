# GUIA PARA PROFESORES

Guia para una clase de 45 a 90 minutos usando MPLACE como proyecto de iniciacion web.

## Objetivo de la clase
Que el estudiante entienda, de forma visual:
- Que es frontend.
- Que es backend.
- Como ambos se conectan a una base de datos.

## Duracion sugerida
- Version corta: 45 minutos
- Version completa: 90 minutos

## Estructura sugerida (90 min)
1. 10 min - Presentacion de conceptos simples (frontend/backend/base de datos)
2. 15 min - Encender proyecto en vivo
3. 15 min - Demostracion de lista y busqueda
4. 15 min - Demostracion de login y panel admin
5. 25 min - Actividades guiadas por estudiantes
6. 10 min - Cierre y dudas

## Script de demo en clase
1. Correr backend (`node index.js`) y mostrar mensaje de puerto 3100.
2. Abrir `frontend/index.html` y explicar que los datos vienen del backend.
3. Buscar un producto para mostrar filtro.
4. Abrir `frontend/login.html` y hacer login de prueba.
5. Mostrar llegada a `frontend/admin/index.html`.

## Actividades seguras para estudiantes
1. Cambiar textos visibles
- Editar titulos o labels en archivos HTML.
- Objetivo: perder miedo a tocar codigo.

2. Agregar un producto en base de datos
- Insertar una fila en tabla `products`.
- Recargar inicio y verificar si aparece.

3. Modificar color de tarjetas
- Editar `frontend/main.css` en seccion `.cards .card`.
- Objetivo: entender relacion CSS -> interfaz.

## Recomendaciones didacticas
- Usar lenguaje cotidiano, no tecnico.
- Validar cada paso con una prueba visual.
- Trabajar en parejas (una persona escribe, otra verifica).
- Reforzar que equivocarse es parte normal del proceso.

## Evaluacion rapida sugerida
Checklist final:
- Puede explicar que hace frontend y backend.
- Puede arrancar el proyecto con ayuda minima.
- Puede hacer un cambio pequeno y verlo en pantalla.
