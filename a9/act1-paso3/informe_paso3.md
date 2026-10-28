# Ficha de análisis de layouts y arquitectura — Conversación del Chat Académico

## Contexto y antecedentes del equipo

En las entregas previas de esta actividad, las revisiones del equipo tuvieron limitaciones que pasaron por alto problemas críticos de la interfaz:
* **El análisis inicial de Mariel (`a9/act1-paso1-2/ficha_layouts.md`):** Resultó excesivamente permisivo con el estado del proyecto. Su veredicto de *"MANTENER con mejora mínima"* se basó en una única captura vertical, con textos cortos y sin teclado, describiendo además de forma errónea la jerarquía de componentes (asumió un `Row` con botón que no existe en el código real).
* **Las pruebas de adaptación de Crico (`a9/act2-paso1-2/matriz_observaciones.md`):** No evaluaron el flujo real de la aplicación. Ejecutaron la pantalla de forma aislada, omitiendo la barra de navegación inferior (`NavigationBar`) que en la app real permanece visible y devora el espacio en horizontal. Además, desactivaron deliberadamente el teclado virtual por ADB para evitar que tapara el campo de entrada, ocultando el colapso del layout.

El presente informe profundiza de forma rigurosa y crítica sobre el código real, detectando fallos estructurales tanto de diseño visual como de arquitectura en Jetpack Compose, y presentando la solución definitiva.

---

## 1. Identificación y estructura actual (Paso 1)

* **Pantalla analizada:** `PostCommentScreen` / `CommentScreenLayout` ([`PostCommentScreen.kt`](file:///home/alvaro9rqc/1_Pacha/1-unsa/8_S/idnp/theoretical/Project-Group-B2/AlertaUNI/app/src/main/java/com/erns/alertauni/screen/post/PostCommentScreen.kt)).
* **Árbol de componentes real en código:**
  * `Column(Modifier.fillMaxSize())`
    * `SearchBoxComponent` (Cabecera fija con usuario y título)
    * `LazyColumn(Modifier.fillMaxSize().padding(horizontal = 8.dp).weight(1f), reverseLayout = true)`
      * `MessageBubble`: `Box(Modifier.fillMaxWidth(), contentAlignment = CenterStart/CenterEnd)`
        * `Surface(RoundedCornerShape(16.dp), color, shadowElevation)`
          * `Column(Modifier.padding(12.dp))`
            * `Text(authorName)` *(solo si no es propio)*
            * `Text(content)`
            * `Text(publishedDate)`
    * `Row(Modifier.fillMaxWidth().padding(vertical = 8.dp), verticalAlignment = CenterVertically)`
      * `TextField(Modifier.fillMaxWidth().padding(8.dp), maxLines = 5, trailingIcon = { IconButton(Send) })`

---

## 2. Evaluación de decisiones actuales y comportamiento adaptativo

### A. Qué funciona (Decisiones a mantener)

* **Uso de `weight(1f)` en lugar de alturas fijas en dp:** Permitir que la `LazyColumn` absorba la altura restante dentro del `Column` es la decisión correcta para que la interfaz se acomode dinámicamente a pantallas de diferente tamaño.
* **`reverseLayout = true`:** Orienta la lista de manera natural para un chat, anclando los mensajes más recientes en la parte inferior junto a la barra de entrada de texto.

---

### B. Fallos de adaptabilidad, layout y arquitectura detectados (Decisiones a corregir)

#### 1. Redundancia en el contenedor inferior (`Row` innecesario)
El botón de envío no es un elemento hermano del campo de texto, sino que está implementado dentro del parámetro `trailingIcon` del propio `TextField`. Al ocupar el `TextField` ya el 100% del ancho (`Modifier.fillMaxWidth()`), el `Row` que lo envuelve es código redundante que suma un nivel innecesario al árbol de composición.

#### 2. Conflicto de modificadores en `LazyColumn` (`fillMaxSize` vs `weight`)
El modificador `.fillMaxSize().weight(1f)` es contradictorio dentro de un `Column`. `fillMaxSize()` solicita forzar toda la altura disponible del padre, mientras que `weight(1f)` reparte el espacio sobrante. En Compose `weight` sobreescribe la restricción vertical por orden de precedencia, pero lo correcto y semántico es `Modifier.fillMaxWidth().weight(1f)`.

#### 3. Burbujas sin restricción de ancho máximo (`MessageBubble`)
El contenedor `Surface` de la burbuja no tiene ningún límite superior de ancho (ni `widthIn(max = ...)` ni porcentaje). 
* **En vertical:** Un mensaje de longitud media (como el de Luis Quispe) ocupa hasta el 97% del ancho total de la pantalla, tocando ambos bordes y perdiendo la identidad visual de burbuja alineada (emisor vs. receptor).
* **En horizontal / Tablets:** El texto se estira en líneas kilométricas (más de 1500 píxeles), violando los principios básicos de legibilidad tipográfica.

#### 4. Solapamiento con el teclado y colapso en horizontal (Landscape)
* El modificador `imePadding()` está importado en la cabecera del archivo pero nunca fue aplicado.
* En modo horizontal, la pantalla cuenta con muy poco alto disponible. Si sumamos la cabecera fija, el teclado abierto y el `TextField` (que puede crecer hasta 5 líneas), la lista de mensajes se reduce a prácticamente **0 dp**, impidiendo que el usuario pueda leer el contexto de la conversación mientras escribe.
* A esto se suma que en la app completa la barra de pestañas (`NavigationBar`) permanece indebidamente activa en pantallas de detalle, quitando aún más altura.

#### 5. Pérdida del texto escrito al rotar la pantalla
La variable `inputText` utiliza `remember { mutableStateOf("") }`. Al rotar el teléfono entre vertical y horizontal, el sistema operativo destruye y recrea la `Activity`. Como `remember` no persiste ante cambios de configuración, el mensaje que el usuario estaba escribiendo se borra automáticamente. Debe utilizarse `rememberSaveable`.

#### 6. Incompatibilidad con Modo Oscuro (Falta de contraste)
Los colores de las burbujas están definidos como constantes fijas (`Color(0xFFDCF8C6)`, `Color.White`, `Color.Red`). En las burbujas ajenas, el fondo es `Color.White`, pero el texto `Text(message.content)` no tiene color asignado, heredando el color del tema. En Modo Oscuro, el tema provee texto blanco, produciendo **texto blanco sobre fondo blanco (completamente invisible)**.

#### 7. Degradación de rendimiento silenciosa en recomposición
* **Instanciación constante de listas:** La función `comments.reversed()` se ejecuta directamente en el cuerpo del composable. Cada tecla que el usuario pulsa en el campo de texto altera `inputText`, desencadenando una recomposición que crea un objeto `ArrayList` nuevo invertido en la memoria RAM, sin reutilizar el anterior.
* **Ausencia de `key` en `items()`:** Al no especificar `key = { it.id }`, Compose identifica los elementos por índice posicional. Cuando se añade un nuevo mensaje, Compose no puede identificar qué elemento cambió y recompone todas las burbujas visibles en lugar de solo la recién agregada.
* **Recolección manual de Flow:** En `PostCommentScreen` se implementó un `LaunchedEffect` manual para copiar el valor de `viewModel.username` a un `remember`, lo cual es un antipatrón en Compose existiendo `collectAsState()`.

---

## 3. Comparativa de alternativas técnicas (Paso 2)

| Criterio | Decisión Original | Alternativa Descartada (`Column` + `verticalScroll` + alturas fijas) | Propuesta Optimizada (Refinamiento + Diseño Adaptativo) |
| :--- | :--- | :--- | :--- |
| **Distribución de espacio** | `LazyColumn` con `fillMaxSize()` y `weight(1f)`. | Alturas fijas en `dp` para lista y caja de texto. | `LazyColumn` con `fillMaxWidth()` + `weight(1f)` + `contentPadding`. |
| **Rendimiento en listas** | Virtualiza vistas, pero recalcula `comments.reversed()` con cada tecla pulsada y no tiene `key`. | Compone todos los elementos en memoria a la vez; genera jank en listas medianas o largas. | Virtualiza con `LazyColumn`, asigna `key = { it.id }` y memoriza la inversión mediante `remember(comments)`. |
| **Adaptabilidad y Rotación** | Pierde el texto escrito al girar; burbujas sin tope de ancho; sin soporte de teclado (`imePadding`). | Se desborda o solapa al cambiar de orientación; el scroll general compite con el scroll del campo. | Preserva estado con `rememberSaveable`; limita ancho con `widthIn(max = 300.dp)`; añade `imePadding()`. |
| **Tema y contraste** | Colores hardcodeados (`Color.White`); rompe completamente en Modo Oscuro. | Igual de frágil si no consume tokens de `MaterialTheme`. | Usa tokens dinámicos (`MaterialTheme.colorScheme`), garantizando contraste en modo Claro y Oscuro. |

---

## 4. Propuesta de implementación corregida (Paso 3)

El siguiente código para [`PostCommentScreen.kt`](file:///home/alvaro9rqc/1_Pacha/1-unsa/8_S/idnp/theoretical/Project-Group-B2/AlertaUNI/app/src/main/java/com/erns/alertauni/screen/post/PostCommentScreen.kt) mantiene la lógica y apariencia esperada del Chat Académico, pero resuelve de raíz todos los problemas detectados de layout, arquitectura, adaptabilidad y rendimiento:

```kotlin
package com.erns.alertauni.screen.post

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.imePadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.widthIn
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.outlined.Send
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.material3.TextFieldDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.hilt.navigation.compose.hiltViewModel
import com.erns.alertauni.data.model.CommentEntity
import com.erns.alertauni.screen.common.SearchBoxComponent

@Composable
fun PostCommentScreen(
    viewModel: PostCommentViewModel = hiltViewModel(),
) {
    // Recolección idiomática y directa de Flows sin LaunchedEffect manual
    val comments by viewModel.comments.collectAsState()
    val username by viewModel.username.collectAsState(initial = "")

    CommentScreenLayout(
        username = username,
        title = "Comentarios",
        comments = comments,
        onClickAddComment = viewModel::sendComment
    )
}

@Composable
fun CommentScreenLayout(
    username: String,
    title: String,
    comments: List<CommentEntity>,
    onClickAddComment: (String) -> Unit
) {
    // 1. rememberSaveable: sobrevive a la rotación de pantalla
    var inputText by rememberSaveable { mutableStateOf("") }
    
    // 2. Memorización: invierte la lista solo cuando 'comments' cambia, no con cada tecla
    val reversedComments = remember(comments) { comments.reversed() }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .imePadding() // 3. Desplaza la UI hacia arriba cuando el teclado se despliega
    ) {
        SearchBoxComponent(username, title)

        LazyColumn(
            modifier = Modifier
                .fillMaxWidth()
                .weight(1f), // 4. Reparto correcto del espacio sin redundancia de fillMaxSize
            contentPadding = PaddingValues(horizontal = 8.dp, vertical = 8.dp),
            reverseLayout = true
        ) {
            items(
                items = reversedComments,
                key = { it.id } // 5. Clave única para evitar recomposiciones masivas
            ) { message ->
                MessageBubble(message)
            }
        }

        // 6. TextField directo: se eliminó el Row envolvente innecesario
        TextField(
            value = inputText,
            onValueChange = { inputText = it },
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 8.dp, vertical = 8.dp),
            shape = RoundedCornerShape(28.dp),
            colors = TextFieldDefaults.colors(
                focusedContainerColor = MaterialTheme.colorScheme.surfaceVariant.copy(alpha = 0.5f),
                unfocusedContainerColor = MaterialTheme.colorScheme.surfaceVariant.copy(alpha = 0.5f),
                disabledContainerColor = Color.Transparent,
                focusedIndicatorColor = Color.Transparent,
                unfocusedIndicatorColor = Color.Transparent,
                disabledIndicatorColor = Color.Transparent
            ),
            placeholder = {
                Text(
                    text = "Mensaje",
                    color = MaterialTheme.colorScheme.onSurfaceVariant.copy(alpha = 0.6f)
                )
            },
            trailingIcon = {
                IconButton(
                    onClick = {
                        if (inputText.isNotBlank()) {
                            onClickAddComment(inputText)
                            inputText = ""
                        }
                    }
                ) {
                    Icon(
                        imageVector = Icons.AutoMirrored.Outlined.Send,
                        contentDescription = "Enviar",
                        tint = if (inputText.isNotBlank()) MaterialTheme.colorScheme.primary else Color.Gray
                    )
                }
            },
            maxLines = 4 // Control del alto máximo para proteger el espacio en horizontal
        )
    }
}

@Composable
fun MessageBubble(message: CommentEntity) {
    // 7. Colores dependientes del tema (garantizan legibilidad en Modo Claro y Oscuro)
    val bubbleColor = if (message.isMine) {
        MaterialTheme.colorScheme.primaryContainer
    } else {
        MaterialTheme.colorScheme.surfaceVariant
    }

    val contentColor = if (message.isMine) {
        MaterialTheme.colorScheme.onPrimaryContainer
    } else {
        MaterialTheme.colorScheme.onSurfaceVariant
    }

    Box(
        modifier = Modifier
            .fillMaxWidth()
            .padding(vertical = 4.dp),
        contentAlignment = if (message.isMine) Alignment.CenterEnd else Alignment.CenterStart
    ) {
        Surface(
            // 8. widthIn(max = 300.dp): evita que la burbuja ocupe el 100% en pantallas anchas
            modifier = Modifier.widthIn(max = 300.dp),
            shape = RoundedCornerShape(16.dp),
            color = bubbleColor,
            shadowElevation = 2.dp
        ) {
            Column(
                modifier = Modifier.padding(12.dp)
            ) {
                if (!message.isMine) {
                    Text(
                        text = message.authorName,
                        color = MaterialTheme.colorScheme.primary,
                        fontSize = 12.sp
                    )
                }
                Text(
                    text = message.content,
                    color = contentColor,
                    textAlign = TextAlign.Start
                )
                Text(
                    text = message.publishedDate,
                    style = MaterialTheme.typography.bodySmall,
                    color = contentColor.copy(alpha = 0.7f),
                    modifier = Modifier.align(Alignment.End)
                )
            }
        }
    }
}
```

---

## 5. Modificación estructural en la navegación y evidencias comparativas

### A. Ocultamiento contextual de `NavigationBar` en navegación real

Al ejecutar la aplicación completa se descubrió un defecto adicional de arquitectura: en [`MainAppNavigation.kt`](file:///home/alvaro9rqc/1_Pacha/1-unsa/8_S/idnp/theoretical/Project-Group-B2/AlertaUNI/app/src/main/java/com/erns/alertauni/navigation/MainAppNavigation.kt#L122-L140), la pantalla de comentarios (`RouteScreen.Comment`) reside dentro del `Scaffold` principal de `MainMenuScreen`. Esto provocaba que la barra inferior de navegación con las pestañas *Posts*, *Contactos* y *Cursos* quedara fija en el chat, ocupando ~80 dp de altura vertical.

En orientación horizontal, esta barra inferior sumada a la cabecera dejaba a la lista de mensajes con apenas 1 línea visible. Se corrigió condicionando la presencia de la `bottomBar`:

```kotlin
bottomBar = {
    // Si estamos en la pantalla de comentarios, ocultamos la barra de pestañas
    if (currentDestination?.startsWith(RouteScreen.Comment.route) != true) {
        NavigationBar {
            // ... items de navegación principal
        }
    }
}
```

Con esto, el chat recupera todo el espacio vertical de la pantalla respetando las pautas de UX donde las pantallas secundarias y de chat no arrastran la barra de navegación raíz.

### B. Evidencias fotográficas comparativas

En esta misma carpeta se adjuntan las capturas reales obtenidas del dispositivo físico que evidencian el antes y el después:

1. **`screen-shot.jpeg` (Problema previo):** Muestra el colapso en horizontal con la implementación original. La barra inferior de pestañas (`NavigationBar`) queda fija debajo del campo de texto, robando espacio vital y reduciendo la lista de comentarios a una franja minúscula.
2. **`corregido-1.jpeg` (Resultado optimizado en Horizontal):** Se aprecia la pantalla en Landscape con las correcciones activas:
   * La barra inferior está oculta, devolviendo el espacio a los mensajes.
   * Las burbujas de texto respetan el límite de `widthIn(max = 300.dp)`, evitando líneas infinitas y preservando la diferenciación visual entre interlocutores.
   * El campo de entrada conserva su accesibilidad y dimensiones adecuadas.
3. **`corregido-2-vertical.jpeg` (Resultado optimizado en Vertical):** Muestra la interfaz en Portrait con proporciones balanceadas, soporte de contraste garantizado mediante tokens de `MaterialTheme` y persistencia de texto con `rememberSaveable`.
