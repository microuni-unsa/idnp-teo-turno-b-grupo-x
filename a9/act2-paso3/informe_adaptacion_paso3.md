# Análisis de decisiones de adaptación de pantalla — Actividad 2 (Paso 3)

## 1. Contexto de los escenarios de prueba evaluados

En los pasos previos ([`act2-paso1-2/matriz_observaciones.md`](file:///home/alvaro9rqc/1_Pacha/1-unsa/8_S/idnp/theoretical/idnp-teo-turno-b-grupo-x/a9/act2-paso1-2/matriz_observaciones.md)), la pantalla de conversación del Chat Académico (`PostCommentScreen` / `CommentScreenLayout`) fue sometida a 6 escenarios de prueba:

* **P1 (Pequeño - Vertical, 720×1280):** Espacio reducido; el layout apilado encaja pero las burbujas largas ocupan casi todo el ancho.
* **P2 (Pequeño - Horizontal, 1280×720):** La altura útil cae drásticamente. Sin teclado la lectura es ajustada; con teclado o con la barra inferior activa, la lista de mensajes colapsa por completo.
* **P3 (Mediano - Vertical, 1080×2400):** Pantalla habitual de smartphone. El mensaje largo de Luis Quispe ocupa 1051 de 1080 píxeles (97.3% del ancho), perdiendo la alineación y convirtiéndose en un bloque plano de pared a pared.
* **P4 (Mediano - Horizontal, 2400×1080):** Las líneas de texto dentro de una burbuja se extienden a lo largo de más de 1500 píxeles continuos, generando fatiga visual extrema.
* **P5 (Grande - Vertical, 1440×3120):** Mayor densidad. Se repite el desborde lateral de las burbujas hacia los extremos opuestos.
* **P6 (Grande - Horizontal, 3120×1440):** El exceso de ancho desaprovechado se vuelve evidente: burbujas de texto kilométricas y vacíos laterales desproporcionados.

A partir de estas evidencias, seleccionamos la decisión técnica central que condiciona la adaptación: **la gestión del ancho máximo y dimensionamiento de las burbujas de contenido (`MessageBubble`) frente a la variabilidad de orientaciones y resoluciones.**

---

## 2. Elemento y decisión de implementación determinante

### ¿Qué decisión causó el comportamiento observado?

En el código original ([`act1-paso1-2/fragmento_layout.kt`](file:///home/alvaro9rqc/1_Pacha/1-unsa/8_S/idnp/theoretical/idnp-teo-turno-b-grupo-x/a9/act1-paso1-2/fragmento_layout.kt#L89-L123)), la burbuja de mensaje está implementada de la siguiente manera:

```kotlin
Box(
    modifier = Modifier
        .fillMaxWidth()
        .padding(vertical = 4.dp),
    contentAlignment = if (message.isMine) Alignment.CenterEnd else Alignment.CenterStart
) {
    Surface(
        shape = RoundedCornerShape(16.dp),
        color = ...
    ) {
        Column(modifier = Modifier.padding(12.dp)) {
            Text(text = message.content)
            // ...
        }
    }
}
```

La decisión causante del problema es la **ausencia total de una cota superior de ancho en el componente `Surface`**.

1. **En Vertical:** El `Surface` crece con el tamaño intrínseco del texto (*wrap content*). Para textos cortos se ve como una burbuja correcta; sin embargo, en cuanto el comentario tiene más de dos oraciones, el texto empuja el ancho hasta alcanzar el 100% de la pantalla (menos el padding lateral del `LazyColumn`). La burbuja toca simultáneamente ambos bordes, destruyendo la distinción visual de quién envió el mensaje (alineación izquierda vs. derecha).
2. **En Horizontal y Pantallas Grandes:** El contenedor `Box` se ensancha para abarcar los 2400 o 3120 píxeles del dispositivo. Sin restricción, la burbuja permite renglones de más de 120 caracteres por línea. Esto viola directamente las pautas ergonómicas de tipografía y lectura de Material Design, que establecen una longitud óptima de línea (*measure*) de **entre 45 y 75 caracteres** para evitar que la vista del usuario se fatigue al cambiar de renglón.

---

## 3. Alternativas que ofrece Jetpack Compose

Jetpack Compose cuenta con diversos mecanismos para resolver la adaptación de contenedores a cambios de dimensión:

### Alternativa 1: Acotamiento fijo mediante `Modifier.widthIn(max = 300.dp)`
Establece un techo máximo absoluto en densidad independiente (`dp`). Si el texto es breve, la burbuja solo ocupará lo que el texto mida; si el texto es largo, se envolverá en múltiples líneas al llegar a los 300 dp, tanto en vertical como en horizontal.

### Alternativa 2: Ancho proporcional fraccionario (`Modifier.fillMaxWidth(0.80f)` o porcentaje)
Asigna un porcentaje máximo del ancho disponible (por ejemplo, 75% u 80%). Garantiza que en cualquier pantalla siempre quede al menos un 20% de espacio vacío en el margen opuesto para evidenciar la alineación lateral del emisor.

### Alternativa 3: Diseño Adaptativo con `WindowSizeClass` (Compact, Medium, Expanded)
Utiliza la API oficial de Android (`androidx.compose.material3.windowsizeclass`) para clasificar el tamaño de la ventana según breakpoints estándar de Google:
* **Compact (< 600 dp - Teléfonos en vertical):** Lista de mensajes en columna única ocupando todo el ancho.
* **Medium (600–840 dp - Plegables o Landscape):** Ajuste de márgenes laterales automáticos (padding dinámico de 64 dp a los lados) para centrar la conversación.
* **Expanded (> 840 dp - Tablets / Tablets en horizontal):** Conversión a arquitectura de dos paneles (*List-Detail Pane*): la lista de anuncios a la izquierda y el hilo de comentarios a la derecha.

### Alternativa 4: Subcomposición dinámica con `BoxWithConstraints`
Envuelve la burbuja o la lista en un `BoxWithConstraints` y calcula mediante lógica condicional `if (maxWidth > 600.dp)` el ancho exacto que debe tener la burbuja en tiempo de renderizado.

---

## 4. Ventajas y limitaciones de las alternativas

| Alternativa | Ventajas | Limitaciones |
| :--- | :--- | :--- |
| **1. `Modifier.widthIn(max = 300.dp)`** | • Cero sobrecarga de cómputo (resuelto en fase de medición nativa).<br>• Garantiza longitud de línea óptima (~50-65 caracteres) en cualquier orientación y densidad.<br>• Mantiene el aspecto tradicional de burbuja de chat tipo mensajería instantánea. | • En pantallas extremadamente estrechas (< 320 dp de ancho útil) la burbuja ocupará casi todo el ancho, requiriendo un margen de seguridad mínimo. |
| **2. `fillMaxWidth(fraction = 0.80f)`** | • Garantiza que siempre exista un 20% libre para notar la alineación izquierda/derecha.<br>• Totalmente proporcional en teléfonos verticales de cualquier tamaño. | • En Landscape o Tablets (1440 dp de ancho), el 80% representa más de 1150 dp, por lo que las líneas siguen siendo excesivamente largas y difíciles de leer. |
| **3. `WindowSizeClass` (Material 3)** | • Es el estándar oficial recomendado por Google para aplicaciones modernas y dispositivos plegables.<br>• Permite cambiar la estructura entera de la pantalla (de panel único a panel doble maestro-detalle). | • Mayor complejidad de implementación.<br>• Requiere refactorizar la navegación de toda la app (`ListDetailPaneScaffold`) en lugar de limitarse al layout de la pantalla de chat. |
| **4. `BoxWithConstraints`** | • Permite lógica matemática condicional por pixel en tiempo de ejecución. | • **Penaliza el rendimiento:** Introduce una subcomposición que retrasa la fase de layout. Dentro de un `LazyColumn` virtualizado con scroll frecuente, puede provocar micro-tirones (*jank*). |

---

## 5. Decisión adoptada y justificación técnica

### Decisión más apropiada: Estrategia Híbrida (`widthIn(max = 300.dp)` + Adaptación de Viewport)

Para la pantalla de conversación del Chat Académico, la solución más sólida, eficiente y mantenible consiste en combinar:

1. **Restricción acotada con `Modifier.widthIn(max = 300.dp)` en `MessageBubble`:**
   * **Por qué es la mejor opción:** Resuelve de raíz los dos defectos más graves detectados en los 6 escenarios de prueba:
     * En **Vertical (P1, P3, P5)**, evita que los mensajes largos colapsen la pantalla en un rectángulo de borde a borde, preservando siempre la claridad de quién envía y quién recibe.
     * En **Horizontal (P2, P4, P6)**, frena el ensanchamiento desmedido del texto. Las líneas se mantienen entre 50 y 65 caracteres, alcanzando el estándar de confort de lectura de Material Design sin requerir una reestructuración compleja de toda la pantalla.
   * **Eficiencia:** A diferencia de `BoxWithConstraints`, `widthIn` opera como un modificador estándar de medición de Compose (sin subcomposiciones ni recreación de árboles sintácticos en el scroll).

2. **Adaptaciones complementarias del Viewport:**
   * **`Modifier.imePadding()` en el `Column` raíz:** Garantiza que al abrir el teclado en orientación horizontal, la interfaz ceda el espacio restante sin tapar el campo de texto ni el botón de enviar.
   * **`rememberSaveable` en `inputText`:** Evita la pérdida del mensaje al rotar entre los escenarios de prueba Vertical y Horizontal.
   * **Ocultamiento condicional de `NavigationBar` en [`MainAppNavigation.kt`](file:///home/alvaro9rqc/1_Pacha/1-unsa/8_S/idnp/theoretical/tasks/03-exam1/Project-Group-B2/AlertaUNI/app/src/main/java/com/erns/alertauni/navigation/MainAppNavigation.kt):** Oculta la barra de pestañas al entrar al chat para que en horizontal el `LazyColumn` disponga de toda la altura del dispositivo.

### Proyección a escala (Tablets y Grandes Pantallas)
Para una evolución futura a escala de tabletas completas (> 840 dp), la decisión técnica adecuada será complementar esta implementación con `WindowSizeClass` mediante un `ListDetailPaneScaffold`, donde la lista de anuncios se ubique en un panel lateral izquierdo (35% del ancho) y la conversación actual en el panel derecho (65% del ancho), manteniendo dentro de ese panel derecho la misma regla de burbujas acotadas con `widthIn(max = 300.dp)`.
