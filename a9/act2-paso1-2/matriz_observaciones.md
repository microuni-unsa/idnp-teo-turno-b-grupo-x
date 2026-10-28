# Matriz de observaciones — Pantalla de Conversación (A9, Actividad 2)

Pantalla: `PostCommentScreen` / `CommentScreenLayout` (ruta `comment/{postId}`). Datos fijos
temporales de 10 burbujas + 1 mensaje de prueba enviado ("hola prueba") para probar el
comportamiento total; sin login ni backend (bypass temporal revertido tras las capturas).

| AVD | Serial | Geometría | Puerto |
|---|---|---|---|
| a9_small | emulator-5554 | 720×1280, 320 dpi | 5554 |
| a9_medium | emulator-5556 | 1080×2400, 420 dpi | 5556 |
| a9_large | emulator-5558 | 1440×3120, 560 dpi | 5558 |

App: `com.erns.alertauni`, `versionCode 1.0`. Fecha: 2026-10-24.
Desvíos: teclado virtual (LatinIME) deshabilitado por adb para las capturas, pues Gboard se
reabría solo y tapaba la fila de input; el campo `Mensaje` + botón `Enviar` quedan visibles en
las 6 pruebas. El mensaje "hola prueba" (burbuja "Tú/Ahora") confirma el envío local.

| Prueba | Distribución | Contenido | Espacio | Interacción | Desplazamiento | Orientación |
|---|---|---|---|---|---|---|
| P1 small portrait (`p1_small_portrait.png`) | Header, lista de burbujas e input apilados sin solape. OK | Textos, autores, fechas y controles legibles; burbuja larga (Luis) envuelta. OK | Sin desbordes ni superposiciones; sin áreas muertas groseras. OK | Campo `Mensaje` y `Enviar` visibles y alcanzables. OK | Swipe recorre todo el hilo en ambas direcciones. OK | Base portrait small; sin degradación (referencia de P2). OK |
| P2 small landscape (`p2_small_landscape.png`) | Header, lista e input apilados sin solape; lista más baja pero usable. OK | Textos y controles legibles; burbujas envueltas sin truncar. OK | Sin desbordes ni superposiciones; lista ocupa el alto disponible. OK | Campo `Mensaje` y `Enviar` visibles y alcanzables. OK | Swipe recorre todo el hilo en ambas direcciones. OK | Respecto a P1 solo reduce alto visible; organización y usabilidad intactas. OK |
| P3 medium portrait (`p3_medium_portrait.png`) | Header, lista e input bien distribuidos sin solape. OK | Todo el contenido legible; ambas variantes de burbuja correctas. OK | Sin desbordes ni superposiciones; buen uso del espacio. OK | Campo `Mensaje` y `Enviar` visibles y alcanzables. OK | Swipe recorre todo el hilo en ambas direcciones. OK | Base portrait medium; sin degradación (referencia de P4). OK |
| P4 medium landscape (`p4_medium_landscape.png`) | Header, lista e input apilados sin solape. OK | Textos y controles legibles sin truncar. OK | Sin desbordes ni superposiciones. OK | Campo `Mensaje` y `Enviar` visibles y alcanzables. OK | Swipe recorre todo el hilo en ambas direcciones. OK | Respecto a P3 solo reduce alto visible; sin pérdida de organización. OK |
| P5 large portrait (`p5_large_portrait.png`) | Header, lista e input bien distribuidos sin solape. OK | Todo el contenido legible a mayor densidad. OK | Sin desbordes ni superposiciones; espacio bien aprovechado. OK | Campo `Mensaje` y `Enviar` visibles y alcanzables. OK | Swipe recorre todo el hilo en ambas direcciones. OK | Base portrait large; sin degradación (referencia de P6). OK |
| P6 large landscape (`p6_large_landscape.png`) | Header, lista e input apilados sin solape. OK | Textos y controles legibles sin truncar. OK | Sin desbordes ni superposiciones. OK | Campo `Mensaje` y `Enviar` visibles y alcanzables. OK | Swipe recorre todo el hilo en ambas direcciones. OK | Respecto a P5 solo reduce alto visible; sin pérdida de organización. OK |
