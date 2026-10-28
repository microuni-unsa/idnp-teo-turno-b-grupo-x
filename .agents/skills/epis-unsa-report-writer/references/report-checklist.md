# Checklist de Calidad para Informes de Laboratorio y Académicos (EPIS-UNSA)

Este instrumento de verificación permite a estudiantes, revisores y asistentes de IA comprobar sistemáticamente la calidad técnica, estilística y estructural de un informe universitario antes de su entrega.

---

## 1. Fase Previa: Entradas y Alineación con la Cátedra

- [ ] **Rúbrica Mapeada**: Se han identificado todos los criterios de evaluación especificados en la guía de laboratorio o enunciado del curso.
- [ ] **Objetivos Definidos**: El informe declara explícitamente los objetivos técnicos alcanzados durante el desarrollo de la práctica.
- [ ] **Evidencias Completas**: Se dispone de todas las capturas de terminal, mediciones métricas, diagramas y trazas requeridas por la guía.

---

## 2. Estructura Jerárquica y Organización

- [ ] **Límite de Profundidad (Máximo 3 Niveles)**:
  - Nivel 1 (`#` o `1.`): Macro-secciones (Introducción, Metodología, Procedimiento, Conclusiones).
  - Nivel 2 (`##` o `1.1.`): Actividades principales o módulos del sistema.
  - Nivel 3 (`###` o `1.1.1.`): Tareas puntuales o pasos técnicos específicos.
  - Ningún encabezado alcanza el 4to nivel (`####`).
- [ ] **Correspondencia con la Guía**: Las secciones del informe reflejan la secuencia de actividades planteada en la guía de práctica universitaria.
- [ ] **Párrafos de Enlace**: Cada sección y subsección inicia con al menos un párrafo explicativo antes de introducir listas, tablas o figuras.
- [ ] **Numeración Consistente**: No se mezclan numeraciones manuales con la numeración automática del procesador de texto o compilador.

---

## 3. Calidad de Contenido y Rigor Técnico

- [ ] **Argumentación de Causa y Efecto**: El informe no se limita a describir *qué* se hizo, sino *por qué* se eligió dicha técnica o solución y *qué resultados* produjo.
- [ ] **Sustento de Afirmaciones**: Toda afirmación sobre rendimiento, concurrencia o seguridad está respaldada por datos cuantitativos o referencias teóricas sólidas.
- [ ] **Análisis de Fallas y Mitigaciones**: Si surgieron errores durante la práctica, se explica la causa raíz técnica y la estrategia de solución aplicada.
- [ ] **Conclusiones Fundamentadas**: Las conclusiones sintetizan aprendizajes empíricos y no repiten la introducción o definiciones de libro de texto.

---

## 4. Estilo de Redacción y Prevención de Antipatrones

- [ ] **Erradicación del *Bullet Sprawl***:
  - Los procedimientos están redactados en párrafos fluidos y cohesionados.
  - No hay cadenas de viñetas anidadas con más de un nivel de subordinación.
  - Las listas se emplean únicamente para conjuntos cerrados o pasos cronológicos indispensables.
- [ ] **Supresión de Paréntesis Innecesarios**:
  - Los conceptos técnicos principales forman parte directa de la oración.
  - Se han eliminado paréntesis con aclaraciones superfluas o redundantes.
- [ ] **Tono Técnico y Voz Objetiva**:
  - Redacción en tercera persona o formas impersonales (*"Se implementó"*, *"El servicio procesa"*).
  - Ausencia de adjetivos publicitarios o coloquialismos (*"increíble"*, *"super rápido"*, *"altamente rentable"* sin métricas).
- [ ] **Sobriedad Tipográfica**:
  - Uso medido de la **negrita**, limitado a nombres de campos clave o términos en su primera mención.
  - No existen párrafos enteros en negrita o mayúsculas.

---

## 5. Gestión de Evidencias (Figuras, Tablas y Código)

- [ ] **Referencias Cruzadas Obligatorias**: Toda figura, tabla o listado está citado explícitamente en el cuerpo del texto previo a su aparición.
- [ ] **Leyendas Descriptivas**: Cada elemento visual cuenta con un pie de figura o título claro que resume su contenido.
- [ ] **Snippets Selectivos**:
  - Se incluyen únicamente fragmentos indispensables de código (máximo 15-25 líneas por fragmento).
  - No se insertan archivos de código completos ni código autogenerado/boilerplate.
  - El código de la aplicación completa se mantiene en su repositorio independiente.
- [ ] **Legibilidad de Capturas**: Las capturas de terminal o esquemas son perfectamente nítidas y legibles.

---

## 6. Verificación Final de Entrega

- [ ] **Ortografía y Gramática**: Revisión completa de acentuación técnica, puntuación y concordancia verbal en español.
- [ ] **Desacoplamiento Verificado**: El contenido es legible, coherente y comprensible independientemente del visor o conversor utilizado.
- [ ] **Cumplimiento de Plazos y Formato de Entrega**: Archivo exportado con la nomenclatura requerida por el docente de la cátedra.
