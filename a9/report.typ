#import "/components/@unsareport/standard-report/lib.typ": standard-report

#show: standard-report.with(
  pretitle: "ACTIVIDAD PRÁCTICA",
  title: [ANÁLISIS Y MEJORA DE INTERFACES MÓVILES],
  course: "INTRODUCCIÓN AL DESARROLLO DE NUEVAS PLATAFORMAS",
  group: "TURNO B",
  teacher: "ERNESTO MAURO SUAREZ LOPEZ",
  activity_code: "A9",
  authors: (
    "JARA MAMANI, MARIEL ALISSON",
    "MESTAS ZEGARRA, CHRISTIAN RAUL",
    "QUISPE CONDORI, ALVARO RAUL",
    "SEQUEIROS CONDORI, LUIS GUSTAVO",
  ),
)

// Estilo editorial cálido para bloques de código, tomado de cas-teo a5/a6
#show raw.where(block: true): it => block(
  fill: rgb("#FAF7F2"),
  inset: (x: 10pt, y: 8.5pt),
  radius: 5pt,
  stroke: 0.6pt + rgb("#E3DCD1"),
  width: 100%,
  breakable: false,
  above: 0.9em,
  below: 0.9em,
  [
    #set text(size: 7.6pt, font: "DejaVu Sans Mono", fill: rgb("#1A1A1A"))
    #it
  ]
)

= Pantalla seleccionada

El análisis se concentra en una única pantalla del Chat Académico de la aplicación AlertaUNI. Se trata del hilo de conversación implementado en los composables PostCommentScreen y CommentScreenLayout, definidos en screen/post/PostCommentScreen.kt. La pantalla presenta el anuncio seleccionado en la cabecera, la lista de comentarios en el cuerpo y el campo de entrada con el botón de envío en la parte inferior.

La captura base fue obtenida en un dispositivo físico Xiaomi con resolución de 1080×2400 y densidad de 440 dpi, donde dpi denota puntos por pulgada, condición equivalente al tamaño mediano de la guía. La captura corresponde a la orientación vertical con el anuncio post_id 3 y dos comentarios visibles. En la @fig-base se observa la composición completa: cabecera con el buscador, lista con espacio vacío superior y campo Mensaje accesible junto al botón de envío.

#block(breakable: false)[
  #figure(
    image("img/captura_base.png", height: 62mm),
    caption: [Pantalla de conversación en dispositivo mediano vertical con dos comentarios],
  ) <fig-base>
]

Las vistas complementarias de la @fig-base-1 y la @fig-base-2 registran el mismo hilo con mayor densidad de mensajes. Ambas confirman que la estructura de tres bloques se mantiene estable cuando el contenido crece: la cabecera permanece fija, la lista absorbe el espacio intermedio y el campo de entrada conserva su altura.

#block(breakable: false)[
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    align: horizon,
    align(center)[#figure(
      image("img/captura_base_1.jpg", height: 58mm),
      caption: [Hilo de conversación con lista extendida en orientación vertical],
    ) <fig-base-1>],
    align(center)[#figure(
      image("img/captura_base_2.jpg", height: 58mm),
      caption: [Detalle de burbujas con autor, contenido y fecha en vertical],
    ) <fig-base-2>],
  )
]

= Análisis de layouts

La jerarquía real de la pantalla responde a un Column raíz con fillMaxSize que apila tres elementos. El primero es el componente SearchBoxComponent con el usuario y el título. El segundo es un LazyColumn con weight 1f y reverseLayout activado. El tercero es la zona de entrada, resuelta con un TextField cuyo botón de envío vive dentro del parámetro trailingIcon. Cada burbuja se compone de un Box a ancho completo que alinea un Surface redondeado con una Column interna de autor, contenido y fecha.

== Decisión técnica estudiada

La decisión central consiste en resolver la lista con LazyColumn, weight 1f y reverseLayout dentro del Column, en lugar de asignar alturas fijas en dp, donde dp denota píxel independiente de densidad, a la lista y al campo. El modificador weight reparte el alto sobrante una vez medidas la cabecera y la zona de entrada, por lo que la lista ocupa todo el espacio intermedio sin constantes por pantalla. La virtualización de LazyColumn compone únicamente los elementos visibles, condición que mantiene el desplazamiento fluido cuando el hilo crece. El indicador reverseLayout ancla los mensajes recientes junto al campo de entrada y reproduce el comportamiento esperado de un chat sin gestión manual del desplazamiento.

El siguiente fragmento resume la estructura evaluada. La lista delega su altura al peso y el campo conserva su altura intrínseca limitada por maxLines.

```kotlin
Column(modifier = Modifier.fillMaxSize()) {
    SearchBoxComponent(username, title)
    LazyColumn(
        modifier = Modifier.fillMaxWidth().weight(1f),
        reverseLayout = true
    ) {
        items(reversed, key = { it.id }) { MessageBubble(it) }
    }
    TextField(value = input, onValueChange = { input = it }, maxLines = 4)
}
```

La captura base respalda la lectura. La lista exhibe aproximadamente un 60 por ciento de vacío superior con solo dos elementos, señal de que el contenedor se estira por el peso mientras el contenido queda anclado abajo por el orden invertido. Las burbujas resultan legibles y el campo Mensaje permanece alcanzable.

== Alternativa considerada

La alternativa analizada combina Column con verticalScroll y alturas fijas en dp para la lista y el campo. Dicha variante compone todos los elementos en memoria desde el primer encuadre, por lo que el costo de medición crece con la longitud del hilo y el desplazamiento presenta tirones en listas medianas. Cada cambio de tamaño u orientación exige una constante distinta, de modo que el mantenimiento se multiplica por configuración. El orden de chat debe emularse con inversión manual de la colección y desplazamiento programático al final. La ausencia de imePadding agrava el cuadro, pues el teclado compite con un campo de altura rígida y produce solape en horizontal.

La variante con ConstraintLayout y barrera fue descartada por replicar la función del peso con mayor complejidad de grafo. La altura fija en dp fue descartada por contravenir de forma directa la consigna de la guía, que exige evitar constantes por pantalla.

== Veredicto

La estructura con peso ponderado se mantiene por ser funcionalmente correcta y adaptable sin constantes por dispositivo. La corrección se limita al borde observado: normalizar el modificador a fillMaxWidth con weight, aplicar imePadding, acotar el contenido con contentPadding y trasladar el estado y los colores a mecanismos resistentes a rotación y tema. La decisión estructural no requiere sustitución.

= Pruebas de adaptación

La pantalla fue ejecutada en tres configuraciones de emulador con dos orientaciones cada una, según la matriz de la guía. El dispositivo pequeño opera a 720×1280 con 320 dpi, el mediano a 1080×2400 con 420 dpi y el grande a 1440×3120 con 560 dpi. El hilo de prueba contiene diez burbujas fijas más un mensaje de envío local que confirma la interacción. Las capturas conservan visible la fila de entrada en los seis escenarios para permitir la comparación de la distribución.

== Dispositivo pequeño

En la @fig-p1 el conjunto de cabecera, lista e entrada se apila sin solape en vertical. Los textos, autores y fechas permanecen legibles y la burbuja extensa se envuelve sin desborde. En la @fig-p2 la rotación a horizontal reduce el alto visible y la lista se compacta, aunque conserva la organización y la accesibilidad del campo. El desplazamiento recorre el hilo completo en ambas direcciones.

#block(breakable: false)[
  #grid(
    columns: (1fr, 2fr),
    gutter: 1em,
    align: horizon,
    align(center)[#figure(
      image("img/p1_small_portrait.png", height: 55mm),
      caption: [Dispositivo pequeño en vertical con lista y campo apilados sin solape],
    ) <fig-p1>],
    align(center)[#figure(
      image("img/p2_small_landscape.png", width: 90%),
      caption: [Dispositivo pequeño en horizontal con lista compactada y campo visible],
    ) <fig-p2>],
  )
]

== Dispositivo mediano

La @fig-p3 corresponde a la pantalla habitual de teléfono en vertical y exhibe una distribución equilibrada sin áreas muertas groseras. La @fig-p4 muestra la misma configuración en horizontal: el alto útil disminuye, la lista cede el espacio y la entrada mantiene su altura intrínseca. En ningún caso se registran elementos desbordados ni superpuestos.

#block(breakable: false)[
  #grid(
    columns: (1fr, 2fr),
    gutter: 1em,
    align: horizon,
    align(center)[#figure(
      image("img/p3_medium_portrait.png", height: 55mm),
      caption: [Dispositivo mediano en vertical con burbujas y controles legibles],
    ) <fig-p3>],
    align(center)[#figure(
      image("img/p4_medium_landscape.png", width: 90%),
      caption: [Dispositivo mediano en horizontal con organización intacta],
    ) <fig-p4>],
  )
]

== Dispositivo grande

La @fig-p5 confirma que el aumento de densidad no altera la estructura en vertical y el espacio se aprovecha sin superposiciones. La @fig-p6 evidencia el mismo comportamiento en horizontal con textos legibles y controles alcanzables. El peso ponderado explica la estabilidad: el paso de 720 a 3120 píxeles modifica únicamente la densidad y el aire, no la jerarquía.

#block(breakable: false)[
  #grid(
    columns: (1fr, 2fr),
    gutter: 1em,
    align: horizon,
    align(center)[#figure(
      image("img/p5_large_portrait.png", height: 55mm),
      caption: [Dispositivo grande en vertical con buen aprovechamiento del espacio],
    ) <fig-p5>],
    align(center)[#figure(
      image("img/p6_large_landscape.png", width: 90%),
      caption: [Dispositivo grande en horizontal sin pérdida de organización],
    ) <fig-p6>],
  )
]

= Análisis de adaptación

Los seis escenarios conservan la organización con el teclado oculto. La evaluación con teclado visible, barra de navegación presente y mensajes extensos revela tres limitaciones: la pantalla fue probada de forma aislada sin la barra de navegación inferior, el teclado fue suprimido del encuadre y las burbujas largas no fueron medidas. Cuando se restituyen esas condiciones, emergen el colapso en horizontal, la pérdida de identidad de burbuja y la fragilidad ante rotación y tema oscuro.

== Decisión determinante

El elemento que condiciona la adaptación es la ausencia de cota superior de ancho en el Surface de MessageBubble. El contenedor crece con el tamaño intrínseco del texto sin límite, de modo que un mensaje de dos oraciones alcanza el 97 por ciento del ancho en vertical y toca ambos bordes. La distinción visual entre emisor y receptor desaparece y la burbuja degenera en un bloque de pared a pared. En horizontal el defecto se amplifica: el Box se ensancha hasta 2400 o 3120 píxeles y la burbuja admite renglones de más de 120 caracteres, longitud que vulnera la medida de 45 a 75 caracteres recomendada por Material Design y fatiga la lectura.

El fragmento original ilustra la causa. El Surface carece de restricción y el texto impone el ancho.

```kotlin
Box(
    modifier = Modifier.fillMaxWidth(),
    contentAlignment = align
) {
    Surface(
        shape = RoundedCornerShape(16.dp),
        color = fixed
    ) {
        Column(modifier = Modifier.padding(12.dp)) {
            Text(text = content)
        }
    }
}
```

A esta causa se suman tres decisiones que comprometen el viewport. El modificador imePadding figura importado pero nunca aplicado, por lo que el teclado tapa el campo en horizontal. El estado del campo usa remember sin resguardo, de modo que la rotación destruye la actividad y borra el texto escrito. Los colores de burbuja son constantes fijas con texto heredado del tema, combinación que produce texto blanco sobre fondo blanco en modo oscuro.

== Alternativas consideradas

Jetpack Compose ofrece cuatro mecanismos para acotar el contenedor. El acotamiento fijo con widthIn establece un techo absoluto en dp que envuelve el texto al alcanzar el límite en cualquier orientación. El ancho proporcional con fracción reserva un margen lateral constante, aunque en pantallas anchas el porcentaje resultante sigue admitiendo líneas excesivas. La clasificación por WindowSizeClass reorganiza la pantalla completa en panel único o doble según los umbrales Compact, Medium y Expanded, solución potente pero que exige refactorizar la navegación. La subcomposición con BoxWithConstraints calcula el ancho por condición en tiempo de renderizado, aunque introduce una fase adicional de medición que degrada el desplazamiento dentro de una lista virtualizada.

#figure(
  table(
    columns: (3cm, 4.6cm, 4.6cm),
    [Opción], [Ventaja], [Limitación],
    [widthIn], [Medición nativa sin subcomposición y longitud de línea óptima.], [En carriles menores a 320 dp requiere margen de seguridad.],
    [Fracción], [Garantiza margen lateral visible en vertical.], [El 80 por ciento en horizontal supera 1150 dp y mantiene líneas largas.],
    [WindowSizeClass], [Estándar oficial para plegables y tabletas.], [Exige migrar a panel doble y reescribir navegación.],
    [BoxWithConstraints], [Lógica condicional por píxel.], [Penaliza el desplazamiento con subcomposición y microtirones.],
  ),
  caption: [Comparativa de alternativas para el dimensionamiento de burbujas],
) <tab-alternativas>

== Decisión adoptada

La solución adoptada combina la restricción acotada con adaptaciones del viewport. El Surface incorpora widthIn con un máximo de 300 dp, valor que preserva la identidad de burbuja en vertical y frena el ensanchamiento en horizontal con líneas de 50 a 65 caracteres. El Column raíz aplica imePadding para ceder espacio ante el teclado. El campo migra a rememberSaveable para sobrevivir a la rotación. La barra de pestañas se oculta de forma condicional al ingresar al chat para devolver el alto útil a la lista. La @tab-alternativas sintetiza por qué esta estrategia híbrida supera a las descartadas en eficiencia y mantenibilidad.

= Evidencias de mejora

La intervención conserva la lógica y la apariencia del Chat Académico y corrige de raíz los defectos de layout, arquitectura y adaptabilidad. El Row envolvente fue eliminado porque el botón de envío reside en el trailingIcon del TextField y el contenedor añadía un nivel innecesario al árbol. El modificador de la lista fue normalizado a fillMaxWidth con weight y contentPadding. La inversión de la colección fue memorizada con remember y la identificación de elementos migró a claves estables. La recolección de flujos adoptó collectAsState en lugar del LaunchedEffect manual.

== Corrección de layouts

El siguiente fragmento concentra los cambios en el viewport y el estado. La lista reparte el espacio sin redundancia, el teclado desplaza la interfaz y el texto escrito persiste ante la rotación.

```kotlin
var inputText by rememberSaveable { mutableStateOf("") }
val reversed = remember(comments) { comments.reversed() }
Column(modifier = Modifier.fillMaxSize().imePadding()) {
    SearchBoxComponent(username, title)
    LazyColumn(
        modifier = Modifier.fillMaxWidth().weight(1f),
        contentPadding = PaddingValues(horizontal = 8.dp, vertical = 8.dp),
        reverseLayout = true
    ) {
        items(reversed, key = { it.id }) { MessageBubble(it) }
    }
}
```

La burbuja incorpora el tope de ancho y los tokens dinámicos de color. El máximo de 300 dp evita el contacto simultáneo con ambos bordes y los colores del esquema garantizan contraste en modo claro y oscuro.

```kotlin
val bubble = if (mine) scheme.primaryContainer else scheme.surfaceVariant
Surface(
    modifier = Modifier.widthIn(max = 300.dp),
    color = bubble
) {
    Column(modifier = Modifier.padding(12.dp)) {
        Text(text = content)
    }
}
```

== Corrección de navegación

La ejecución de la aplicación completa reveló que la pantalla de comentarios residía dentro del Scaffold principal y arrastraba la barra inferior con las pestañas principales. Dicha barra sustrae aproximadamente 80 dp de altura y, sumada a la cabecera en horizontal, reduce la lista a una franja mínima. La corrección condiciona la barra al destino actual y la oculta en el chat, criterio coherente con las pautas que reservan la navegación raíz a los destinos principales.

```kotlin
bottomBar = {
    if (!currentDestination.startsWith(RouteScreen.Comment.route)) {
        NavigationBar { /* destinos principales */ }
    }
}
```

== Comparativa visual antes y después

La @fig-antes registra el defecto en horizontal con la implementación original: la barra inferior permanece fija bajo el campo y la lista colapsa a una franja mínima. La @fig-despues-h muestra el mismo encuadre corregido con la barra oculta, las burbujas acotadas y el campo accesible. La @fig-despues-v confirma el resultado en vertical con proporciones equilibradas, contraste garantizado por tokens del tema y persistencia del texto.

#block(breakable: false)[
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    align: top,
    align(center)[#figure(
      image("img/antes_horizontal.jpeg", width: 100%),
      caption: [Estado previo en horizontal con barra inferior fija y lista colapsada],
    ) <fig-antes>],
    align(center)[#figure(
      image("img/despues_horizontal.jpeg", width: 100%),
      caption: [Estado corregido en horizontal con barra oculta y burbujas acotadas],
    ) <fig-despues-h>],
  )
]

#block(breakable: false)[
  #figure(
    image("img/despues_vertical.jpeg", height: 62mm),
    caption: [Estado corregido en vertical con proporciones balanceadas],
  ) <fig-despues-v>
]

= Conclusiones

El reparto ponderado con weight supera a la medición manual con dp porque distribuye el alto sobrante sin constantes por pantalla y absorbe los cambios de tamaño y orientación sin ramas condicionales. La virtualización con LazyColumn y orden invertido supera al desplazamiento general porque compone solo lo visible y preserva el orden de chat de forma nativa. El acotamiento con widthIn supera a la fracción y a la subcomposición porque garantiza la medida tipográfica con costo de medición nativo. El teclado se gestiona con imePadding, el texto en curso con rememberSaveable y el contraste con tokens del tema. La barra de navegación se reserva a los destinos raíz y se oculta en el detalle para restituir el alto útil. La proyección a tabletas conserva estas reglas dentro del panel de detalle y reserva WindowSizeClass para la migración a doble panel.
