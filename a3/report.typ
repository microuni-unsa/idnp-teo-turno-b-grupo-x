#import "template.typ": project

#show: doc => project(
  title: [
    ACTIVIDAD EN CLASE 03: ESTADO Y RECOMPOSICIÓN
  ],
  authors: (
    "JARA MAMANI, MARIEL ALISSON",
    "MESTAS ZEGARRA, CHRISTIAN RAUL",
    "QUISPE CONDORI, ALVARO RAUL",
    "SEQUEIROS CONDORI, LUIS GUSTAVO",
  ),
  course: "INTRODUCCIÓN AL DESARROLLO DE NUEVAS PLATAFORMAS",
  group: "TURNO B",
  teacher: "ERNESTO MAURO SUAREZ LOPEZ",
  doc,
)

= Descripción del Aplicativo

El aplicativo implementado corresponde a un sistema de venta de entradas de cine. La solución aborda la recomposición reactiva de la interfaz ante eventos del usuario como la modificación de entradas, adición de productos extras y aplicación de cupones de descuento.

= Capturas y Evidencias de Implementación

#block(breakable: false)[
  == Entorno de Desarrollo y Vista General

  En la @fig-ide-general se aprecia la vista integral de Android Studio con el código fuente del proyecto y la interfaz de usuario ejecutándose en el emulador móvil.

  #figure(
    image("img/01_interfaz_ide.jpeg", width: 78%),
    caption: [Entorno de desarrollo Android Studio con la interfaz inicial del aplicativo],
  ) <fig-ide-general>
]

#block(breakable: false)[
  == Configuración de la Actividad Principal

  En la @fig-main-activity se muestra la clase `MainActivity`, donde se habilita el diseño de borde a borde y se define el contenedor de contenido con el tema del proyecto y la invocación del composable raíz `CineApp()`.

  #figure(
    image("img/02_main_activity.jpeg", width: 58%),
    caption: [Clase `MainActivity` y punto de entrada de la composición],
  ) <fig-main-activity>
]

#block(breakable: false)[
  == Modelo de Datos para Opciones Adicionales

  La @fig-extra-option ilustra la definición de la clase de datos `ExtraOption`, utilizada para estructurar los elementos adicionales con identificador, nombre y precio unitario.

  #figure(
    image("img/03_modelo_datos.jpeg", width: 55%),
    caption: [Modelo de datos `ExtraOption` para la gestión de productos],
  ) <fig-extra-option>
]

#block(breakable: false)[
  == Catálogo de Opciones y Estado de Selección

  En la @fig-bebidas-options se observa la definición del catálogo de bebidas y el manejo del estado reactivo de selección, empleando `remember` y `mutableStateMapOf` para conservar las selecciones durante las fases de recomposición.

  #figure(
    image("img/04_opciones_bebidas.jpeg", width: 70%),
    caption: [Definición de opciones de bebidas y estado mutable mediante `mutableStateMapOf`],
  ) <fig-bebidas-options>
]

#block(breakable: false)[
  == Declaración del Estado de la Interfaz

  La @fig-estado-interfaz expone la inicialización de los estados mutables de la interfaz en `CineApp()`, incluyendo el contador de entradas, las opciones de canchitas y bebidas seleccionadas, y el cupón de descuento.

  #figure(
    image("img/05_estado_interfaz.jpeg", width: 72%),
    caption: [Definición de variables de estado con `remember` y `mutableStateOf`],
  ) <fig-estado-interfaz>
]

#block(breakable: false)[
  == Lógica de Cálculos Reactivos en Memoria

  En la @fig-calculos-memoria se detalla la lógica de cálculo en memoria para los subtotales de canchita y bebidas. El sistema calcula dinámicamente el subtotal general, el descuento aplicable y el importe total en respuesta a cualquier cambio de estado.

  #figure(
    image("img/06_calculos_memoria.jpeg", width: 68%),
    caption: [Cálculo reactivo en memoria de subtotales, descuentos y total a pagar],
  ) <fig-calculos-memoria>
]

#block(breakable: false)[
  == Ejecución y Recomposición Dinámica en Móvil

  La @fig-ejecucion-movil evidencia el aplicativo en funcionamiento interactivo sobre el dispositivo móvil, demostrando el recálculo automático del resumen de compra tras la selección de elementos adicionales.

  #figure(
    image("img/09_ejecucion_movil.jpeg", width: 40%),
    caption: [Ejecución en dispositivo móvil reflejando la actualización del estado y recomposición],
  ) <fig-ejecucion-movil>
]
