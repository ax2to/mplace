#!/usr/bin/env bash
set -euo pipefail

REPO_SLUG="${REPO_SLUG:-}"
if [[ -z "${REPO_SLUG}" ]]; then
  remote_url="$(git remote get-url origin)"
  if [[ "$remote_url" =~ github.com[:/]([^/]+/[^/.]+)(\.git)?$ ]]; then
    REPO_SLUG="${BASH_REMATCH[1]}"
  else
    echo "No se pudo detectar REPO_SLUG. Exporta REPO_SLUG=owner/repo"
    exit 1
  fi
fi

if [[ -z "${GITHUB_TOKEN:-}" ]]; then
  echo "Falta GITHUB_TOKEN en el entorno."
  echo "Ejemplo: export GITHUB_TOKEN=ghp_xxx"
  exit 1
fi

api="https://api.github.com/repos/${REPO_SLUG}"
out_file="docs/SEGUIMIENTO-ISSUES.md"
mkdir -p docs

labels=(
  "didactico|c5def5"
  "seguridad|d73a4a"
  "backend|0e8a16"
  "frontend|1d76db"
  "docs|5319e7"
  "good first issue|7057ff"
  "nivel:basico|fbca04"
  "nivel:intermedio|b60205"
)

create_label() {
  local name="$1"
  local color="$2"
  local code
  code="$(curl -s -o /tmp/label_resp.json -w "%{http_code}" \
    -H "Authorization: Bearer ${GITHUB_TOKEN}" \
    -H "Accept: application/vnd.github+json" \
    "${api}/labels/${name// /%20}")"

  if [[ "$code" == "200" ]]; then
    echo "label ok: $name"
    return
  fi

  curl -sS -X POST \
    -H "Authorization: Bearer ${GITHUB_TOKEN}" \
    -H "Accept: application/vnd.github+json" \
    "${api}/labels" \
    -d "$(printf '{"name":"%s","color":"%s"}' "$name" "$color")" >/dev/null
  echo "label created: $name"
}

for item in "${labels[@]}"; do
  name="${item%%|*}"
  color="${item##*|}"
  create_label "$name" "$color"
done

create_issue() {
  local title="$1"
  local labels_csv="$2"
  local body="$3"

  IFS=',' read -r -a labels_arr <<< "$labels_csv"
  labels_json="["
  for i in "${!labels_arr[@]}"; do
    l="${labels_arr[$i]}"
    labels_json+="\"${l}\""
    if [[ "$i" -lt $((${#labels_arr[@]} - 1)) ]]; then
      labels_json+=","
    fi
  done
  labels_json+="]"

  payload="$(printf '{"title":"%s","body":"%s","labels":%s}' \
    "$(echo "$title" | sed 's/"/\\"/g')" \
    "$(echo "$body" | sed ':a;N;$!ba;s/\n/\\n/g' | sed 's/"/\\"/g')" \
    "$labels_json")"

  resp="$(curl -sS -X POST \
    -H "Authorization: Bearer ${GITHUB_TOKEN}" \
    -H "Accept: application/vnd.github+json" \
    "${api}/issues" \
    -d "$payload")"

  number="$(echo "$resp" | sed -n 's/.*"number": \([0-9][0-9]*\).*/\1/p' | head -n1)"
  url="$(echo "$resp" | sed -n 's/.*"html_url": "\([^"]*\)".*/\1/p' | head -n1)"

  if [[ -z "$number" || -z "$url" ]]; then
    echo "Error creando issue: $title"
    echo "$resp"
    exit 1
  fi

  echo "$number|$title|$url"
}

issue1_body=$(cat <<'EOT'
## Contexto para principiantes
La busqueda actual construye SQL uniendo texto directo del usuario.

## Problema actual
Esto puede permitir SQL Injection.

## Objetivo de aprendizaje
Aprender consultas parametrizadas para seguridad basica.

## Cambio tecnico esperado
Reemplazar interpolacion por placeholders en busqueda.

## Pasos guiados
1. Ubicar consulta de busqueda en `backend/index.js`.
2. Cambiar la consulta para usar parametros.
3. Verificar que busqueda sigue funcionando.

## Criterios de aceptacion
- [ ] No hay concatenacion directa en SQL de busqueda.
- [ ] La busqueda devuelve resultados esperados.
- [ ] Se documenta por que mejora seguridad.

## Checklist de validacion
- [ ] Probado con termino normal.
- [ ] Probado con comillas y simbolos.
- [ ] Backend responde sin errores.

## Pistas (hint) opcionales
Usa `WHERE title LIKE ? OR description LIKE ?`.

## Definicion de terminado (DoD)
- [ ] Cambio implementado
- [ ] PR con `Closes #N`
- [ ] Review realizado
EOT
)

issue2_body=$(cat <<'EOT'
## Contexto para principiantes
Credenciales hardcodeadas hacen dificil compartir y son inseguras.

## Problema actual
`backend/config.js` contiene usuario/password en texto plano.

## Objetivo de aprendizaje
Aprender configuracion por variables de entorno.

## Cambio tecnico esperado
Mover credenciales de DB a `.env` con fallback seguro para local.

## Pasos guiados
1. Leer config actual de BD.
2. Cargar variables de entorno en backend.
3. Documentar ejemplo en README/docs.

## Criterios de aceptacion
- [ ] No hay credenciales reales en repo.
- [ ] Backend levanta con `.env`.
- [ ] Guía de setup actualizada.

## Checklist de validacion
- [ ] Conexion OK con variables configuradas.
- [ ] Error claro si faltan variables.
- [ ] Docs reflejan nuevo flujo.

## Pistas (hint) opcionales
Define `DB_HOST`, `DB_USER`, `DB_PASSWORD`, `DB_NAME`.

## Definicion de terminado (DoD)
- [ ] Cambio implementado
- [ ] PR con `Closes #N`
- [ ] Review realizado
EOT
)

issue3_body=$(cat <<'EOT'
## Contexto para principiantes
Guardar passwords en texto plano es una mala practica critica.

## Problema actual
El login compara password directa desde DB.

## Objetivo de aprendizaje
Aprender hash de passwords y verificacion segura.

## Cambio tecnico esperado
Usar hash (ej. bcrypt) para almacenar y comparar passwords.

## Pasos guiados
1. Instalar libreria de hash.
2. Preparar hash para usuario de prueba.
3. Cambiar login para comparar hash.

## Criterios de aceptacion
- [ ] Password no se guarda en texto plano.
- [ ] Login exitoso con password correcta.
- [ ] Login falla con password incorrecta.

## Checklist de validacion
- [ ] Caso correcto/incorrecto probado.
- [ ] Sin regresion de endpoint `/api/login`.
- [ ] Documentacion actualizada.

## Pistas (hint) opcionales
`bcrypt.compare()` para validar.

## Definicion de terminado (DoD)
- [ ] Cambio implementado
- [ ] PR con `Closes #N`
- [ ] Review realizado
EOT
)

issue4_body=$(cat <<'EOT'
## Contexto para principiantes
Scripts de npm simplifican comandos y reducen errores.

## Problema actual
No existe `start` en `backend/package.json`.

## Objetivo de aprendizaje
Aprender estandarizar arranque con scripts.

## Cambio tecnico esperado
Agregar `"start": "node index.js"`.

## Pasos guiados
1. Abrir `backend/package.json`.
2. Agregar script start.
3. Probar `npm start`.

## Criterios de aceptacion
- [ ] `npm start` levanta backend.
- [ ] Mensaje de puerto 3100 aparece.
- [ ] Sin romper scripts existentes.

## Checklist de validacion
- [ ] Comando funciona en entorno limpio.
- [ ] README menciona comando.
- [ ] Cambio pequeño y enfocado.

## Pistas (hint) opcionales
Mantener script `test` actual.

## Definicion de terminado (DoD)
- [ ] Cambio implementado
- [ ] PR con `Closes #N`
- [ ] Review realizado
EOT
)

issue5_body=$(cat <<'EOT'
## Contexto para principiantes
La documentación debe coincidir con el setup real del proyecto.

## Problema actual
Puede haber desfase entre guía y script SQL.

## Objetivo de aprendizaje
Aprender a mantener docs y setup consistentes.

## Cambio tecnico esperado
Validar y alinear README + guías + `backend/sql/setup.sql`.

## Pasos guiados
1. Comparar pasos de docs con script SQL.
2. Corregir diferencias de comandos o datos.
3. Verificar onboarding completo.

## Criterios de aceptacion
- [ ] Docs y SQL no se contradicen.
- [ ] Flujo nuevo funciona en limpio.
- [ ] Se mantiene lenguaje para principiantes.

## Checklist de validacion
- [ ] Se ejecuta setup sin pasos ocultos.
- [ ] Usuario demo documentado coincide.
- [ ] Rutas y comandos correctos.

## Pistas (hint) opcionales
Hacer una prueba de cero como estudiante.

## Definicion de terminado (DoD)
- [ ] Cambio implementado
- [ ] PR con `Closes #N`
- [ ] Review realizado
EOT
)

issue6_body=$(cat <<'EOT'
## Contexto para principiantes
Variables globales aumentan acoplamiento y confusión.

## Problema actual
`getApiItemData` depende de `productId` global.

## Objetivo de aprendizaje
Aprender paso explícito de parámetros entre funciones.

## Cambio tecnico esperado
Cambiar firma a `getApiItemData(productId)`.

## Pasos guiados
1. Ubicar llamada desde detalle.
2. Pasar `productId` como argumento.
3. Probar detalle de producto.

## Criterios de aceptacion
- [ ] Ya no depende de variable global.
- [ ] Vista detalle funciona igual.
- [ ] Código más fácil de seguir.

## Checklist de validacion
- [ ] Carga de detalle correcta.
- [ ] No hay errores en consola.
- [ ] Cambio aislado a frontend.

## Pistas (hint) opcionales
Ajustar solo firma + llamada.

## Definicion de terminado (DoD)
- [ ] Cambio implementado
- [ ] PR con `Closes #N`
- [ ] Review realizado
EOT
)

tmp="$(mktemp)"
{
  echo "# Seguimiento de Issues Didacticos"
  echo
  echo "| Issue # | Titulo | Rama | URL | Estado |"
  echo "|---|---|---|---|---|"

  i1="$(create_issue "Seguridad: evitar SQL Injection en busqueda de productos" "didactico,seguridad,backend,nivel:intermedio" "$issue1_body")"
  i2="$(create_issue "Seguridad: mover credenciales de BD a variables de entorno" "didactico,seguridad,backend,nivel:intermedio" "$issue2_body")"
  i3="$(create_issue "Seguridad: reemplazar passwords en texto plano por hash" "didactico,seguridad,backend,nivel:intermedio" "$issue3_body")"
  i4="$(create_issue "DX: agregar script start en backend/package.json" "didactico,backend,nivel:basico,good first issue" "$issue4_body")"
  i5="$(create_issue "Docs: estandarizar guia de setup y esquema SQL" "didactico,docs,nivel:basico,good first issue" "$issue5_body")"
  i6="$(create_issue "Frontend: eliminar acoplamiento a variable global productId" "didactico,frontend,nivel:basico,good first issue" "$issue6_body")"

  for row in "$i1|fix/sql-injection-busqueda" "$i2|fix/credenciales-env-backend" "$i3|fix/hash-password-login" "$i4|chore/script-start-backend" "$i5|docs/setup-schema-consistente" "$i6|fix/product-detail-parametro"; do
    num="$(echo "$row" | cut -d'|' -f1)"
    title="$(echo "$row" | cut -d'|' -f2)"
    url="$(echo "$row" | cut -d'|' -f3)"
    branch="$(echo "$row" | cut -d'|' -f4)"
    echo "| #${num} | ${title} | ${branch} | ${url} | Abierto |"
  done
} > "$tmp"

mv "$tmp" "$out_file"

echo "Issues creados y resumen guardado en $out_file"
