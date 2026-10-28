# Guion 5 min — A9 Chat Académico (PostCommentScreen)
Total: 300 s · 7 láminas · ritmo ~40 s por lámina (S4 mosaico: 60 s).

## S1 Portada (0:00–0:35, 35 s)
Somos A9. Pantalla única congelada: Conversación del Chat Académico, `PostCommentScreen / CommentScreenLayout`. Decisión central: `LazyColumn + weight(1f) + reverseLayout` dentro de `Column`. La probamos en 3 tamaños × 2 orientaciones: 6 de 6 OK. Hoy mostramos las dos decisiones y una mejora de 2 líneas. [Señalar captura_base.png a la derecha.]

## S2 Pantalla (0:35–1:15, 40 s)
Base Xiaomi 1080×2400, 440 dpi, mediano vertical, post_id=3 con 2 comentarios. Árbol: `Column(fillMaxSize)` con cabecera, `LazyColumn(weight 1f, reverseLayout)` y `Row` de Mensaje + Enviar (maxLines=5). Pista clave: ~60 % vacío arriba no es error: el weight estira el contenedor y el reverseLayout deja lo nuevo abajo como un chat.

## S3 Decisión layout (1:15–1:55, 40 s)
¿ Por qué LazyColumn + weight? Virtualiza (barata con N grande), reparte alto sin dp mágicos, la lista cede ante el teclado y el orden chat es nativo. Alternativa descartada: `Column + verticalScroll` con alturas fijas: compone todo (jank), pide un dp por configuración y exige scroll manual. Tampoco ConstraintLayout con barrera: mismo efecto que el weight con más complejidad. Veredicto: MANTENER.

## S4 Mosaico 6 (1:55–2:55, 60 s) — PRIORIZAR IMÁGENES
Recorrer el mosaico fila superior (portrait P1-P3-P5) e inferior (landscape P2-P4-P6). Small 720×1280, medium 1080×2400, large 1440×3120. En las 6: sin solapes, textos y burbujas legibles, Mensaje/Enviar visibles, swipe total en ambas direcciones. En landscape solo baja el alto visible; nada se pierde. Nota honesta: teclado LatinIME deshabilitado por adb porque Gboard se reabría y tapaba el input; el mensaje “hola prueba” prueba el envío local.

## S5 Decisión adaptación (2:55–3:35, 40 s)
¿Qué determina que no se rompa? `weight(1f)`: la lista ocupa todo menos cabecera y campo, así que el cambio portrait→landscape solo la encoge. Pequeño vs. grande solo cambia densidad/aire, no estructura. Alternativas: dp fijos (×6 mantenimiento), BoxWithConstraints con ramas (sobra para un chat lineal), WindowSizeClass a 2 paneles (para ancho reducido, no para este hilo). Elegimos reparto ponderado por 0 ramas y 0 dp mágicos.

## S6 Antes/después (3:35–4:20, 45 s)
La estructura estaba bien; el borde no. El archivo ya importaba `imePadding` pero no lo usaba: riesgo de que el teclado tape Mensaje/✈ en horizontal. Mejora: `.imePadding()` en el Row + `contentPadding` en la lista para que el vacío no se lea como error. Dos líneas, sin tocar la decisión. Funcionalidad intacta en las 6 pruebas. [Señalar código y fotos antes/después.]

## S7 Conclusiones (4:20–5:00, 40 s)
Tres criterios: 1) peso > dp: repartir, no medir a mano; 2) virtualizar el hilo: Lazy + reverseLayout para N grande; 3) atacar el borde, no la estructura: el teclado se cierra con imePadding. Pantalla MANTENIDA + mejora mínima, lista para preguntas.

### Reparto resumen
| Lámina | Tiempo | Acumulado |
|---|---|---|
| S1 Portada | 35 s | 0:35 |
| S2 Pantalla | 40 s | 1:15 |
| S3 Layout vs alt. | 40 s | 1:55 |
| S4 Mosaico 6 | 60 s | 2:55 |
| S5 Adaptación vs alt. | 40 s | 3:35 |
| S6 Antes/después | 45 s | 4:20 |
| S7 Conclusiones | 40 s | 5:00 |
