## ACTIVIDAD PRÁCTICA: ANÁLISIS Y MEJORA DE INTERFACES MÓVILES
Tema: Construcción de interfaces móviles
Contenidos: Layouts y adaptación de pantalla

- Propósito de la actividad
En el desarrollo de aplicaciones móviles no basta con construir interfaces que funcionen
correctamente. También es necesario tomar decisiones técnicas que permitan organizar
adecuadamente los elementos visuales y adaptar la interfaz a diferentes condiciones de
uso.

## 2. Desafío
¿Las interfaces actuales del Chat Académico están correctamente construidas para
adaptarse a diferentes tamaños y condiciones de pantalla?
Las interfaces de una aplicación móvil deben organizar sus elementos considerando el
espacio disponible, las características de los componentes y las condiciones de uso.
Una pantalla que funciona correctamente en un dispositivo no necesariamente tendrá el
mismo comportamiento en otro.

A partir del código fuente proporcionado, cada equipo deberá analizar una pantalla de la
aplicación y responder:
- ¿Las  decisiones  utilizadas  para  organizar  los  elementos  de  la  interfaz  son
adecuadas?
- ¿Qué alternativas de implementación existen?
- ¿Cómo se comporta la interfaz cuando cambian las dimensiones o condiciones
de pantalla?
- ¿Qué decisiones deberían mantenerse y cuáles podrían mejorarse?



- Actividad 1: Análisis de layouts
Objetivo: Evaluar las decisiones empleadas para organizar los elementos de una interfaz
mediante Jetpack Compose.
## Desarrollo
Paso 1. Examinar el código
Seleccionen una pantalla existente  del  proyecto Chat Académico e  identifiquen cómo
están organizados sus elementos visuales.
Presten  especial  atención  a  los  layouts  (Column,  Row,  Box,  entre  otros)  y  a  los
modificadores   utilizados   para   determinar   tamaños,   posiciones,   alineaciones   y
distribución del espacio.

Paso 2. Investigar y comparar alternativas
Seleccionen  una  decisión  técnica  relacionada  con  la  organización  de  los  elementos  y
analicen:
- ¿Por qué resulta apropiado utilizar ese layout o modificador?
- ¿Qué otra alternativa podría emplearse?
- ¿Qué ventajas y limitaciones presenta cada alternativa?

Paso 3. Evaluar la implementación
Determinen si la decisión actual es apropiada o si conviene modificarla.
En  caso  de  identificar  una  mejora,  impleméntenla  y  comprueben  que  la  pantalla
mantiene su funcionalidad.




- Actividad 2: Adaptación de pantalla
Objetivo: Evaluar  la  capacidad  de  una  interfaz  para  adaptarse  a  distintos  tamaños  de
pantalla  y  orientaciones,  identificando  las  decisiones  técnicas  que  determinan  su
comportamiento.
Paso 1. Configurar los escenarios de prueba
Cada equipo deberá ejecutar la pantalla seleccionada en tres tamaños de dispositivo,
utilizando el emulador de Android Studio u otro emulador.
Se utilizarán las siguientes referencias o equivalentes:
Tamaño Configuración de pantalla referencial aprox. Propósito
Pequeño 720×1280, 320 dpi Evaluar la interfaz con espacio
limitado.
Mediano 1080×2400, 420 dpi Evaluar el comportamiento en una
pantalla habitual.
Grande 1440×3120, 560 dpi Evaluar el aprovechamiento de un
espacio mayor.

Cada configuración deberá probarse en dos orientaciones:
## • Vertical (portrait).
## • Horizontal (landscape).

En total, deberán realizarse seis escenarios de prueba.
## Tamaño Vertical Horizontal
## Pequeño Prueba 1 Prueba 2
## Mediano Prueba 3 Prueba 4
## Grande Prueba 5 Prueba 6



Paso 2. Evaluar el comportamiento de la interfaz
En cada escenario, observen:
- Distribución: ¿Los elementos se organizan adecuadamente dentro del espacio
disponible?
- Contenido: ¿Los textos, imágenes y controles se visualizan correctamente?
- Espacio: ¿Existen    elementos    desbordados,    superpuestos    o    espacios
desaprovechados?
- Interacción: ¿Los  botones,  campos  de  texto  y  demás  controles  siguen  siendo
accesibles?
- Desplazamiento: ¿Es  posible  acceder  al  contenido  cuando  supera  el  espacio
visible?
- Orientación: ¿El  cambio  entre  vertical  y  horizontal  afecta  negativamente  la
organización o usabilidad?
Registren los resultados mediante capturas de pantalla y observaciones breves.

Paso 3. Analizar las decisiones de adaptación
A  partir  de  los  resultados,  seleccionen una  decisión  técnica  relacionada  con  la
adaptación de la interfaz.
Investiguen y respondan:
- ¿Qué  elemento  o  decisión  de  implementación  determina  el  comportamiento
observado?
- ¿Qué alternativas ofrece Jetpack Compose para manejar esa situación?
- ¿Qué ventajas y limitaciones tienen esas alternativas?
- ¿Cuál resulta más apropiada para las necesidades de la pantalla seleccionada y
por qué?



## 5. Entregable
Cada equipo presentará un documento breve que contenga:
Sección Contenido requerido
## 1. Pantalla
seleccionada
Nombre y captura de la pantalla analizada.
- Análisis de layouts Fragmento de código, decisión técnica estudiada, alternativa considerada y
justificación.
- Pruebas de
adaptación
Capturas de las seis configuraciones (tres tamaños × dos orientaciones).
- Análisis de
adaptación
Problemas identificados, alternativas consideradas y justificación de la
decisión técnica.
- Evidencias de
mejora
Código y capturas comparativas antes/después, si se realizaron
modificaciones.
- Conclusiones Principales aprendizajes sobre los criterios para construir interfaces
móviles.

- Presentación y defensa
Cada  equipo  dispondrá  de 5  minutos para  presentar  las  dos  decisiones  técnicas
analizadas y los principales resultados de las pruebas.
La  presentación  permitirá  responder  algunas  preguntas  sobre  el  uso  de  layouts  y
adaptación de pantalla:
## Ejemplos:
- ¿Por  qué  su  interfaz  funciona  correctamente  en  orientación  vertical,  pero
presenta dificultades en horizontal?
- ¿Qué decisión técnica explica la diferencia de comportamiento entre un teléfono
pequeño y una tableta?
- ¿Por qué utilizaron un tamaño fijo en lugar de uno adaptable?
- ¿Qué cambiarían si la aplicación tuviera que funcionar en una ventana de ancho
reducido?
- ¿Por qué consideran que su alternativa es más adecuada que la descartada?
