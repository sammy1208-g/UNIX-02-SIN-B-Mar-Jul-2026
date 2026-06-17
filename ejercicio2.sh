#!/bin/bash
# =============================================================================
# calificar_rama.sh
#
# Califica una rama de un repositorio Git del 0 al 100 en base a 3 criterios:
#
#   1. HORARIO DE CLASE    (33 pts) - commits hechos lunes/miercoles 7-9am
#   2. IDIOMA EN INGLES    (33 pts) - mensajes de commit escritos en ingles
#   3. CALIDAD DEL MENSAJE (34 pts) - mensajes descriptivos, no genericos
#
# USO:
#   bash calificar_rama.sh <nombre_rama>
#
# Debes ejecutarlo DENTRO de la carpeta del repositorio clonado.
# =============================================================================

set -uo pipefail

# ---------------------------------------------------------------------------
# 0. VALIDACIONES INICIALES
# ---------------------------------------------------------------------------

if [ $# -lt 1 ]; then
    echo "Uso: bash calificar_rama.sh <nombre_rama>"
    echo "Ejemplo: bash calificar_rama.sh linux_cisco_2"
    exit 1
fi

RAMA="$1"

if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "ERROR: No estas dentro de un repositorio git."
    echo "Ve a la carpeta del repo clonado y vuelve a correr el script."
    exit 1
fi

if ! git show-ref --verify --quiet "refs/heads/$RAMA" && \
   ! git show-ref --verify --quiet "refs/remotes/origin/$RAMA"; then
    echo "ERROR: La rama '$RAMA' no existe localmente ni en origin."
    echo "Ramas disponibles:"
    git branch -a
    exit 1
fi

REF="$RAMA"
if ! git show-ref --verify --quiet "refs/heads/$RAMA"; then
    REF="origin/$RAMA"
fi

echo "============================================================"
echo " CALIFICANDO RAMA: $RAMA"
echo "============================================================"
echo ""

# ---------------------------------------------------------------------------
# 1. EXTRAER COMMITS DE LA RAMA
# ---------------------------------------------------------------------------
# Cada commit se imprime como:
#   <hash40hex>|<fecha YYYY-MM-DD>|<dia ISO 1-7>|<hora HH:MM>|<subject>
#   <body linea 1>
#   <body linea 2>
#   ...
#   ~~~END~~~
#
# La linea de metadata se identifica de forma inequivoca buscando un hash
# de 40 caracteres hexadecimales al inicio de linea (mucho mas confiable
# que contar separadores "|", que tambien pueden aparecer en el texto).

LOG_FILE=$(mktemp)
git log "$REF" \
    --date=format:'%Y-%m-%d|%u|%H:%M' \
    --pretty=format:'%H|%ad|%s%n%b%n~~~END~~~' \
    > "$LOG_FILE"

TOTAL_COMMITS=$(grep -cE '^[0-9a-f]{40}\|' "$LOG_FILE")

if [ "$TOTAL_COMMITS" -eq 0 ]; then
    echo "ERROR: La rama '$RAMA' no tiene commits."
    rm -f "$LOG_FILE"
    exit 1
fi

echo "Total de commits encontrados: $TOTAL_COMMITS"
echo ""

# Archivo auxiliar: una linea por commit con metadata (hash|fecha|dia|hora|subject)
META_FILE=$(mktemp)
grep -E '^[0-9a-f]{40}\|' "$LOG_FILE" > "$META_FILE"

# ---------------------------------------------------------------------------
# 2. CRITERIO 1: HORARIO DE CLASE (33 pts)
# ---------------------------------------------------------------------------
# Puntaje por commit:
#   - Lunes o Miercoles, 07:00-08:59  -> 1.0 (puntaje completo)
#   - Lunes o Miercoles, otra hora    -> 0.5 (dia correcto, hora no)
#   - Otro dia, 07:00-08:59           -> 0.3 (hora correcta, dia no)
#   - Otro dia, fuera de horario      -> 0.0
#
# %u en git: 1=Lunes ... 7=Domingo

dentro_horario_y_dia=0
solo_dia_correcto=0
solo_hora_correcta=0
fuera_total=0

while IFS='|' read -r hash fecha dia_semana hora resto; do
    [ -z "$hash" ] && continue

    hora_num=$(echo "$hora" | cut -d':' -f1 | sed 's/^0*//')
    [ -z "$hora_num" ] && hora_num=0

    es_dia_clase=false
    if [ "$dia_semana" = "1" ] || [ "$dia_semana" = "3" ]; then
        es_dia_clase=true
    fi

    es_hora_clase=false
    if [ "$hora_num" -ge 7 ] && [ "$hora_num" -lt 9 ]; then
        es_hora_clase=true
    fi

    if $es_dia_clase && $es_hora_clase; then
        dentro_horario_y_dia=$((dentro_horario_y_dia + 1))
    elif $es_dia_clase; then
        solo_dia_correcto=$((solo_dia_correcto + 1))
    elif $es_hora_clase; then
        solo_hora_correcta=$((solo_hora_correcta + 1))
    else
        fuera_total=$((fuera_total + 1))
    fi
done < "$META_FILE"

puntaje_horario_crudo=$(awk -v a="$dentro_horario_y_dia" -v b="$solo_dia_correcto" -v c="$solo_hora_correcta" -v total="$TOTAL_COMMITS" \
    'BEGIN { printf "%.2f", ((a*1.0 + b*0.5 + c*0.3) / total) * 100 }')

PUNTOS_HORARIO=$(awk -v p="$puntaje_horario_crudo" 'BEGIN { printf "%.2f", (p/100)*33 }')

echo "------------------------------------------------------------"
echo "CRITERIO 1: Horario de clase (33 pts)"
echo "------------------------------------------------------------"
echo "  Commits Lunes/Miercoles 7-9am      : $dentro_horario_y_dia"
echo "  Commits Lunes/Miercoles otra hora  : $solo_dia_correcto"
echo "  Commits otro dia pero 7-9am        : $solo_hora_correcta"
echo "  Commits fuera de horario y dia     : $fuera_total"
echo "  -> Puntos obtenidos: $PUNTOS_HORARIO / 33"
echo ""

# ---------------------------------------------------------------------------
# 3. CRITERIO 2: IDIOMA EN INGLES (33 pts)
# ---------------------------------------------------------------------------
# Heuristica basada en palabras frecuentes en mensajes de commit, sin
# dependencias externas (no requiere internet ni paquetes adicionales).

ES_PALABRAS='\b(el|la|los|las|de|del|que|para|con|por|una|uno|se|en|agregar|agrega|agregue|cambio|cambios|corrige|corregido|arreglo|arregla|elimina|elimino|actualiza|actualizo|nuevo|nueva|funcion|archivo|prueba|pruebas|error|solucion|implementa|implemento|documentacion|comentarios|ajuste|ajustes|version|codigo)\b'

EN_PALABRAS='\b(the|and|for|with|add|added|adds|fix|fixed|fixes|update|updated|updates|remove|removed|removes|implement|implemented|implements|new|test|tests|file|function|error|bug|feature|refactor|refactored|change|changed|documentation|comment|comments|initial|create|created|creates|improve|improved|setup|script)\b'

mensajes_ingles=0
mensajes_espanol=0
mensajes_indefinido=0

while IFS='|' read -r hash fecha dia_semana hora subject; do
    [ -z "$hash" ] && continue
    subject_lower=$(echo "$subject" | tr '[:upper:]' '[:lower:]')

    es_count=$(echo "$subject_lower" | grep -oiE "$ES_PALABRAS" | wc -l)
    en_count=$(echo "$subject_lower" | grep -oiE "$EN_PALABRAS" | wc -l)

    if [ "$en_count" -gt "$es_count" ]; then
        mensajes_ingles=$((mensajes_ingles + 1))
    elif [ "$es_count" -gt "$en_count" ]; then
        mensajes_espanol=$((mensajes_espanol + 1))
    else
        mensajes_indefinido=$((mensajes_indefinido + 1))
    fi
done < "$META_FILE"

PUNTAJE_IDIOMA_CRUDO=$(awk -v ing="$mensajes_ingles" -v ind="$mensajes_indefinido" -v total="$TOTAL_COMMITS" \
    'BEGIN { printf "%.2f", ((ing + ind*0.5) / total) * 100 }')

PUNTOS_IDIOMA=$(awk -v p="$PUNTAJE_IDIOMA_CRUDO" 'BEGIN { printf "%.2f", (p/100)*33 }')

echo "------------------------------------------------------------"
echo "CRITERIO 2: Idioma en ingles (33 pts)"
echo "------------------------------------------------------------"
echo "  Commits en ingles       : $mensajes_ingles"
echo "  Commits en espanol      : $mensajes_espanol"
echo "  Commits indefinidos     : $mensajes_indefinido"
echo "  -> Puntos obtenidos: $PUNTOS_IDIOMA / 33"
echo ""

# ---------------------------------------------------------------------------
# 4. CRITERIO 3: CALIDAD DE LOS MENSAJES (34 pts)
# ---------------------------------------------------------------------------
# Puntaje por commit:
#   - Subject >= 6 palabras Y tiene body  -> 1.0  (alta calidad)
#   - Subject >= 6 palabras SIN body      -> 0.8  (alta calidad)
#   - Subject 3-5 palabras                -> 0.5  (calidad media)
#   - Subject generico o <= 2 palabras    -> 0.0  (baja calidad)

GENERICOS='^(fix|fixed|wip|update|updated|updates|test|tests|cambios|cambio|prueba|pruebas|commit|temp|asdf|sin mensaje|\.\.\.|x|ok|done|listo)$'

alta_calidad=0
media_calidad=0
baja_calidad=0

# Necesitamos saber, por cada commit, si tiene body (lineas no vacias entre
# el subject y el ~~~END~~~). Recorremos LOG_FILE completo en una sola pasada.
current_subject=""
current_has_body=0
commit_started=0

while IFS= read -r linea; do
    if [[ "$linea" =~ ^[0-9a-f]{40}\| ]]; then
        # Si habia un commit anterior pendiente de evaluar, lo evaluamos primero
        if [ "$commit_started" -eq 1 ]; then
            num_palabras=$(echo "$current_subject" | wc -w)
            subject_lower=$(echo "$current_subject" | tr '[:upper:]' '[:lower:]' | xargs)

            if echo "$subject_lower" | grep -qE "$GENERICOS"; then
                baja_calidad=$((baja_calidad + 1))
            elif [ "$num_palabras" -ge 6 ]; then
                alta_calidad=$((alta_calidad + 1))
            elif [ "$num_palabras" -ge 3 ]; then
                media_calidad=$((media_calidad + 1))
            else
                baja_calidad=$((baja_calidad + 1))
            fi
        fi

        # Iniciar nuevo commit
        current_subject=$(echo "$linea" | cut -d'|' -f5-)
        current_has_body=0
        commit_started=1
        continue
    fi

    if [[ "$linea" == "~~~END~~~" ]]; then
        continue
    fi

    if [ -n "$linea" ]; then
        current_has_body=1
    fi
done < "$LOG_FILE"

# Evaluar el ultimo commit acumulado (el bucle no lo procesa porque no hay
# una linea de hash siguiente que lo dispare)
if [ "$commit_started" -eq 1 ]; then
    num_palabras=$(echo "$current_subject" | wc -w)
    subject_lower=$(echo "$current_subject" | tr '[:upper:]' '[:lower:]' | xargs)

    if echo "$subject_lower" | grep -qE "$GENERICOS"; then
        baja_calidad=$((baja_calidad + 1))
    elif [ "$num_palabras" -ge 6 ]; then
        alta_calidad=$((alta_calidad + 1))
    elif [ "$num_palabras" -ge 3 ]; then
        media_calidad=$((media_calidad + 1))
    else
        baja_calidad=$((baja_calidad + 1))
    fi
fi

PUNTAJE_CALIDAD_CRUDO=$(awk -v alta="$alta_calidad" -v media="$media_calidad" -v total="$TOTAL_COMMITS" \
    'BEGIN { printf "%.2f", ((alta*1.0 + media*0.5) / total) * 100 }')

PUNTOS_CALIDAD=$(awk -v p="$PUNTAJE_CALIDAD_CRUDO" 'BEGIN { printf "%.2f", (p/100)*34 }')

echo "------------------------------------------------------------"
echo "CRITERIO 3: Calidad de los mensajes (34 pts)"
echo "------------------------------------------------------------"
echo "  Mensajes de alta calidad (>=6 palabras)  : $alta_calidad"
echo "  Mensajes de calidad media (3-5 palabras) : $media_calidad"
echo "  Mensajes genericos o muy cortos          : $baja_calidad"
echo "  -> Puntos obtenidos: $PUNTOS_CALIDAD / 34"
echo ""

# ---------------------------------------------------------------------------
# 5. PUNTAJE FINAL
# ---------------------------------------------------------------------------

PUNTAJE_FINAL=$(awk -v a="$PUNTOS_HORARIO" -v b="$PUNTOS_IDIOMA" -v c="$PUNTOS_CALIDAD" \
    'BEGIN { printf "%.2f", a+b+c }')

echo "============================================================"
echo " RESUMEN FINAL - RAMA: $RAMA"
echo "============================================================"
printf "  %-38s %6s / 33\n" "Horario de clase:" "$PUNTOS_HORARIO"
printf "  %-38s %6s / 33\n" "Idioma (ingles):" "$PUNTOS_IDIOMA"
printf "  %-38s %6s / 34\n" "Calidad de comentarios:" "$PUNTOS_CALIDAD"
echo "------------------------------------------------------------"
printf "  CALIFICACION TOTAL:                   %6s / 100\n" "$PUNTAJE_FINAL"
echo "============================================================"

rm -f "$LOG_FILE" "$META_FILE"