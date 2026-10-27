# Ficha de análisis de layouts — Pantalla única del equipo

## 1. Decisión congelada

**Pantalla única: Conversación del Chat Académico** = `PostCommentScreen` /
`CommentScreenLayout` de AlertaUNI (anuncio "Lab setup question" → Comentarios:
lista de mensajes + campo `Mensaje` + botón Enviar). Congelada para todo el
equipo; ningún otro miembro edita `a9/analisis_layouts/`.

- Código: `Project-Group-B2/.../screen/post/PostCommentScreen.kt:66-184`
  (ver `fragmento_layout.kt`, copia exacta de layouts y `Modifier`).
- Captura base: `captura_base.png` — Xiaomi físico 1080×2400, 440 dpi
  (tamaño **mediano** guía), **vertical**, anuncio `post_id=3` con 2 comentarios.
- Árbol: `Column(fillMaxSize) { SearchBoxComponent + LazyColumn(weight 1f,
  reverseLayout) + Row(fillMaxWidth, TextField + IconButton Send) }`;
  burbuja: `Box(fillMaxWidth, align CenterStart/End) > Surface > Column`.

## 2. Decisión técnica estudiada

**Lista con `LazyColumn + weight(1f) + reverseLayout` dentro de `Column`,**
en vez de alturas fijas en dp para lista y campo.

- ¿Por qué apropiado? `weight(1f)` reparte el alto sobrante: la lista ocupa
  todo menos cabecera y campo, sin medir a mano; `LazyColumn` compone solo lo
  visible (lista larga sin costo); `reverseLayout` deja lo nuevo abajo como un
  chat; el campo conserva su altura intrínseca (`maxLines=5`) y el ✈️ nunca se
  recorta. En la captura base (mediano vertical) funciona: burbujas legibles,
  campo y Enviar accesibles.
- Evidencia en captura: lista con ~60 % vacío arriba — el `weight` estira el
  contenedor aunque haya 2 ítems (contenedor lleno, contenido arriba-vacío por
  el `reverseLayout`).

## 3. Comparativa con alternativa concreta

| | Actual: `LazyColumn(weight 1f)` | Alternativa: `Column + verticalScroll` + alturas fijas |
|---|---|---|
| Scroll/listas largas | Virtualizada, barata | Compone todo: jank con N grande |
| Alturas | Reparto automático, sin dp mágicos | Frágil: cada tamaño/orientación pide otro dp |
| Rotación / teclado | El campo conserva altura, la lista cede | El campo fijo + `verticalScroll` compiten; riesgo de solape sin `imePadding` (importado en el archivo pero sin usar) |
| Orden chat | `reverseLayout` nativo | Manual (`reversed()` + scroll al final a mano) |
| Costo | Medición ponderada, predecible | Medición simple pero mantenimiento por configuración |

Alternativas descartadas: `ConstraintLayout` con barrera (misma función que el
`weight` con más XML mental); altura fija en dp (rompe en landscape/pequeño,
es lo que la guía pide evitar).

## 4. Veredicto: MANTENER con mejora mínima

**Mantener** `LazyColumn + weight(1f) + reverseLayout`: funcionalmente correcta
y adaptable sin constantes por pantalla. **Mejorar** solo el borde observado:
agregar `Modifier.imePadding()` al `Row` del campo (el import ya existe en el
archivo) para que el teclado no tape `Mensaje`/✈️ en horizontal, y `contentPadding`
en la lista para que el vacío del `weight` no se lea como error. Sin tocar la
decisión estructural.
