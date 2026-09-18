# Actividad 03: Estado y Recomposición

## Autores

- Jara Mamani, Mariel Alisson
- Mestas Zegarra, Christian Raul
- Quispe Condori, Alvaro Raul
- Sequeiros Condori, Luis Gustavo

Curso: Introducción al Desarrollo de Nuevas Plataformas - Turno B.
Docente: Ernesto Mauro Suarez Lopez.

## Código

- `app/.../MainActivity.kt`: todo el código de la pantalla:
  - `MainActivity`: clase de la actividad principal, donde se habilita el diseño de borde a borde y se define el contenedor de contenido con el tema del proyecto y la invocación del composable raíz `CineApp()`.
  - `ExtraOption`: modelo de datos para las opciones de extras, estructura cada producto adicional con identificador, nombre y precio unitario.
  - `CineApp()`: composable raíz de la pantalla. Declara el estado mutable de la interfaz, contador de entradas, canchitas y bebidas seleccionadas, cupón de descuento y diálogo de compra. Expone además la lógica de cálculos reactivos en memoria, el sistema calcula dinámicamente el subtotal general, el descuento aplicable y el importe total en respuesta a cualquier cambio de estado. La estructura es un `Scaffold` con `TopAppBar` y una `Column` desplazable de cuatro secciones, tarjeta de entradas, tarjeta de extras, tarjeta de resumen de la compra y botón de comprar con diálogo de confirmación.
