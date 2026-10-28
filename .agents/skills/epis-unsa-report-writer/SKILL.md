---
name: epis-unsa-report-writer
description: Guidelines, structure, and quality standards for drafting academic and laboratory reports for EPIS-UNSA (Escuela Profesional de Ingeniería de Sistemas). Focuses on technical writing, content clarity, structured reasoning, and anti-pattern correction across any document format (Markdown, Typst, LaTeX, DOCX). Use when writing, editing, structuring, or reviewing academic reports, university laboratory guides, or technical project documentation for EPIS-UNSA.
license: "MIT"
metadata:
  language: "es"
  organization: "EPIS-UNSA"
  author: "skills-dev"
  version: "1.1.0"
---

# EPIS-UNSA Academic & Technical Report Writer

Guía integral y estándares de redacción técnica para la elaboración, estructuración y revisión de informes académicos y de laboratorio en la Escuela Profesional de Ingeniería de Sistemas de la Universidad Nacional de San Agustín (EPIS-UNSA).

---

## 1. What This Skill Does (Propósito y Alcance)

Esta skill proporciona las directrices metodológicas, criterios de estilo y patrones de estructuración para producir informes técnicos de nivel universitario y profesional. Su objetivo central es garantizar que el contenido del informe refleje rigor analítico, claridad expositiva y sustentación técnica, **desacoplado de cualquier motor o formato de renderizado** (Typst, LaTeX, Markdown, OpenOffice o Microsoft Word).

### Objetivos Clave
- Establecer un estándar de redacción directo, sobrio y con rigor académico.
- Eliminar vicios comunes de redacción como la proliferación descontrolada de viñetas (*bullet sprawl*), el abuso de paréntesis y la adjetivación excesiva.
- Guiar la transición desde un borrador inicial enfocado en cubrir la rúbrica hacia un informe pulido, cohesivo y estructurado jerárquicamente hasta un máximo de tres niveles.
- Mantener la separación estricta entre el repositorio de código fuente del proyecto y los fragmentos ilustrativos (*snippets*) presentados en la memoria técnica.

---

## 2. When to Use and When Not to Use

### Cuándo Utilizar Esta Skill
- **Informes de Laboratorio Universitario**: Elaboración de guías prácticas y entregables de asignaturas de EPIS-UNSA (Sistemas Distribuidos, Ingeniería de Software, Bases de Datos, Redes, Arquitectura, Sistemas Operativos, etc.).
- **Memorias Técnicas de Proyectos**: Redacción de informes de fin de curso, diseño arquitectural, pruebas de integración y sustentaciones técnicas.
- **Auditoría y Refactorización de Borradores**: Revisión de documentos preliminares redactados por estudiantes o agentes para corregir tono, formato jerárquico y densidad de prosa.
- **Preparación de Contenido Multi-Formato**: Estructuración del contenido antes de exportarlo a cualquier compilador de documentos (Typst, LaTeX, Pandoc/DOCX o Markdown).

### Cuándo NO Utilizar Esta Skill
- **Documentación de Código Inline**: Redacción de docstrings, comentarios Javadoc o descripciones breves de funciones en archivos de código fuente.
- **Ensayos Literarios o Creativos**: Redacciones no técnicas, opiniones personales o narraciones informales.
- **Presentaciones y Diapositivas**: Elaboración de diapositivas de tipo *pitch deck* donde priman las frases ultra-cortas y viñetas publicitarias.
- **Respuestas Rápidas en Chat**: Consultas inmediatas de depuración que no requieran la entrega de un documento formal evaluable.

---

## 3. Inputs Needed (Entradas Requeridas)

Para redactar o revisar un informe conforme a este estándar, se requiere:

1. **Guía de Práctica o Enunciado del Proyecto**: Objetivos del laboratorio, requerimientos funcionales, preguntas de investigación y actividades pautadas por la cátedra.
2. **Rúbrica o Criterios de Evaluación**: Ponderación de aspectos evaluados (ej. comprensión conceptual, evidencias de implementación, análisis crítico de resultados, conclusiones).
3. **Evidencias Técnicas Recolectadas**:
   - Salidas de consola, trazas de ejecución y registros (*logs*).
   - Fragmentos puntuales de código (*snippets*) que demuestran la solución implementada.
   - Diagramas arquitecturales (secuencia, componentes, despliegue) o esquemas de flujo.
   - Tablas comparativas o mediciones cuantitativas (latencia, uso de memoria, concurrencia).
4. **Directrices de Plantilla (Opcional)**: Estructura base exigida por el docente (títulos de secciones, orden predefinido).

---

## 4. Core Content & Technical Writing Principles

### A. Desacoplamiento del Formato de Composición
El valor académico de un informe radica en la calidad de su contenido y la claridad de su razonamiento. El formato final (Typst, LaTeX, Markdown o DOCX) es un detalle de implementación. No se debe condicionar la lógica argumental al motor de diagramación utilizado.

### B. Prosa Directa y Economía Verbal
- Escribir párrafos breves (3 a 6 oraciones) con ideas concretas y autosuficientes.
- Emplear voz técnica objetiva: preferir tercera persona del singular o formas impersonales (*"Se configuró el clúster"*, *"El algoritmo evalúa la condición"*) frente a primera persona informal (*"Nosotros instalamos"*, *"Yo probé"*).
- Evitar adjetivos grandilocuentes sin evidencia empírica (sustituir *"es una herramienta increíblemente rápida"* por *"la latencia promedio se redujo en un 38% respecto al baseline"*).

### C. Supresión del Antipatrón de Viñetas (*Bullet Sprawl*)
- **El Problema**: Reemplazar la narrativa explicativa por cascadas interminables de viñetas anidadas (*bullet points*) que fragmentan la lectura y denotan falta de elaboración intelectual.
- **La Solución**: Los procedimientos, análisis y descripciones técnicas deben redactarse como párrafos cohesionados mediante conectores lógicos precisos.
- **Uso Válido de Listas**:
  - **Listas numeradas**: Únicamente para secuencias cronológicas estrictas o procedimientos paso a paso.
  - **Listas con viñetas**: Únicamente para enumerar conjuntos cerrados de elementos equivalentes (máximo un nivel subordinado).

### D. Eliminación del Abuso de Paréntesis
- No utilizar paréntesis para incluir información técnica sustancial. Si un dato es relevante para la comprensión del texto, debe integrarse gramaticalmente en la oración.
- Si una aclaración entre paréntesis es obvia o superflua, elimínese por completo.

### E. Sobriedad Tipográfica y Uso de Énfasis
- No saturar el texto con estilos en **negrita**, *cursiva* o `monoespaciado`.
- La negrita se reserva para el inicio de elementos de una lista o conceptos nucleares en su primera aparición, nunca para resaltar oraciones completas a modo de resumen.

### F. Jerarquía Estricta de Encabezados (Regla de los 3 Niveles)
- Emplear como máximo **tres niveles de profundidad**:
  - **Nivel 1 (`#` / `1.`)**: Macro-sección (e.g., *I. Introducción*, *II. Procedimiento Experimental*, *III. Conclusiones*).
  - **Nivel 2 (`##` / `1.1.`)**: Subactividad o bloque temático específico.
  - **Nivel 3 (`###` / `1.1.1.`)**: Tarea o aspecto técnico puntual.
- **Prohibido el nivel 4 o superior (`####`)**: Subdividir en cuatro o más niveles atomiza el informe y destruye la fluidez de lectura. Si se necesita desglosar un paso dentro del tercer nivel, empléese un párrafo introductorio con palabras destacadas al inicio de la oración.
- **No duplicar numeraciones manuales**: Si el motor de renderizado numera automáticamente los títulos, no anteponer números fijos en el texto del encabezado.

### G. Gestión de Snippets y Código Fuente
- Un informe de laboratorio **no es un volcado de código fuente**: no incluir archivos enteros ni funciones utilitarias irrelevantes.
- Los directorios de snippets (ej. `src/lst/` o `code/`) solo deben contener fragmentos representativos utilizados en la memoria escrita. El código del proyecto completo debe residir en su repositorio correspondiente.
- Todo fragmento de código debe ir delimitado en un bloque con sintaxis resaltada, acompañado de su respectivo análisis explicativo en el párrafo anterior o posterior.

### H. Organización Modular de Documentos Extensos
- Para informes que superen las 10 páginas o consten de múltiples prácticas, modularizar el contenido en archivos individuales por capítulo o sección (empleando directivas como `include` en Typst o `\input` en LaTeX), orquestados desde un documento principal limpio.

---

## 5. Step-by-Step Procedure (Flujo de Elaboración)

El desarrollo del informe sigue un flujo iterativo en cuatro etapas:

```
[Fase 1: Borrador Rápido] ──> [Fase 2: Estructuración] ──> [Fase 3: Evidencias y Análisis] ──> [Fase 4: Revisión Estilística]
```

### Fase 1: Drafting Rápido (Cobertura de Rúbrica)
1. Extraer todos los objetivos y criterios de evaluación de la guía de práctica.
2. Redactar un primer borrador rápido enfocado **exclusivamente en la completitud técnica**:
   - Responder conceptualmente a cada actividad solicitada.
   - Comprobar que ninguna pregunta o requisito de la guía quede sin abordar.
   - En esta fase no perder tiempo en detalles visuales ni compilaciones definitivas.

### Fase 2: Estructuración y Jerarquía
1. Organizar el documento reflejando la secuencia de actividades de la guía universitaria. Si la práctica tiene dos partes principales con sub-etapas, el informe debe mantener esa misma división.
2. Aplicar la regla de profundidad máxima (hasta el tercer nivel de encabezados).
3. Asegurar que cada sección cuente con un párrafo de introducción antes de presentar subsecciones o listas.

### Fase 3: Integración de Evidencias y Análisis Crítico
1. Incorporar capturas de ejecución, esquemas conceptuales o tablas de datos numéricos.
2. Cada evidencia visual o tabular debe estar formalmente referenciada en el texto (ej. *"como se ilustra en la Figura 2"* o `@fig:topologia`) y analizada críticamente: no basta con mostrar la imagen, se debe explicar qué demuestra.
3. Incrustar únicamente los snippets indispensables que justifiquen decisiones de diseño o algoritmos clave.

### Fase 4: Revisión Estilística y Refactorización
1. **Poda de listas**: Identificar listas de viñetas anidadas y convertirlas en párrafos de prosa fluida.
2. **Poda de paréntesis**: Eliminar incisos redundantes e integrar las precisiones en la sintaxis de las oraciones.
3. **Poda de negritas**: Reducir el resaltado en negrita a lo estrictamente necesario.
4. **Verificación de cohesión y concordancia**: Asegurar la continuidad temática entre párrafos y la corrección ortográfica del español técnico.

---

## 6. Validation Checklist (Criterios de Aceptación)

Antes de considerar concluido un informe técnico o de laboratorio para EPIS-UNSA, verificar cada uno de los siguientes puntos:

- [ ] **Cobertura Completa de la Guía**: Todos los ejercicios, preguntas teóricas y procedimientos solicitados por la cátedra están resueltos y fundamentados.
- [ ] **Estructura Jerárquica Limpia**: Ningún encabezado supera el tercer nivel de profundidad (`###` o `1.1.1`).
- [ ] **Ausencia de Bullet Sprawl**: No existen listas anidadas excesivas. Los procedimientos y análisis están desarrollados en párrafos completos.
- [ ] **Supresión de Paréntesis Innecesarios**: La información clave está integrada a la oración sin fragmentaciones entre paréntesis.
- [ ] **Voz Técnica y Objetiva**: Se utiliza un tono impersonal o tercera persona, evitando adjetivos pomposos y opiniones sin sustento numérico.
- [ ] **Snippets Relevantes y Acotados**: Solo se muestran los fragmentos de código estrictamente necesarios para explicar la solución; no hay volcados de archivos completos.
- [ ] **Evidencias Referenciadas y Analizadas**: Toda figura, tabla o gráfico está referenciado en el cuerpo del informe con su respectiva interpretación técnica.
- [ ] **Corrección Lingüística y Tipográfica**: Ortografía, tildación técnica y puntuación revisadas; el énfasis en negrita se mantiene sobrio.

---

## 7. Common Failure Modes & Concrete Fixes (Antipatrones y Soluciones)

A continuación se presentan casos reales de refactorización de contenido en informes técnicos de EPIS-UNSA:

### Caso 1: Proliferación de Viñetas Anidadas vs. Párrafo Cohesivo

#### ❌ Antipatrón (Malo)
> ### II. DESCRIPCIÓN DEL PROCEDIMIENTO REALIZADO EN LA PRÁCTICA
>
> 1. **Instalación y Configuración del Entorno de Gestión de Cambios:**
>
> * Se desplegó y configuró una herramienta de gestión de incidencias y cambios (se utilizó **Scarab / Redmine** en contenedor Docker).
>
> * Se definieron los roles dentro del sistema: *Solicitante (Cliente/Analista)*, *Comité de Control de Cambios (CCB / Project Manager)*, *Desarrollador/Arquitecto Distribuido* y *QA Tester*.
>
> 2. **Análisis del Diagrama de Flujo del Proceso de Gestión de Cambios:**
>
> * Se revisó el flujo estandarizado descrito en las buenas prácticas (Anexo 21 / ITIL / RUP):
>
>   1. **Identificación y Registro:** Creación de la Solicitud de Cambio (CR).
>   2. **Evaluación de Impacto:** Análisis técnico (costo, esfuerzo, riesgos en la arquitectura distribuida, afectación a nodos).
>   3. **Decisión del Comité (CCB):** Aprobación, rechazo, postergación o solicitud de mayor información.
>   4. **Implementación:** Asignación al equipo de desarrollo y modificación de ECSs.
>   5. **Verificación y Pruebas:** Validación de calidad (QA) e integración continua.
>   6. **Cierre y Despliegue:** Actualización de la línea base (*baseline*) y notificación a los involucrados.

*Diagnóstico del error*: Abuso indiscriminado de viñetas dentro de listas numeradas, anidamiento innecesario, sobrecarga de negritas y uso excesivo de paréntesis explicativos.

#### ✅ Estándar Corregido (Bueno)
> ### DESCRIPCIÓN DEL PROCEDIMIENTO REALIZADO EN LA PRÁCTICA
>
> 1. **Instalación y Configuración del Entorno de Gestión de Cambios:**
>
> Se desplegó y configuró una plataforma de gestión de incidencias mediante contenedores Docker basados en Scarab y Redmine. Posteriormente, se configuró la matriz de roles del sistema compuesta por: Solicitante (Cliente/Analista), Comité de Control de Cambios (CCB / Project Manager), Desarrollador/Arquitecto Distribuido y QA Tester.
>
> 2. **Análisis del Diagrama de Flujo del Proceso de Gestión de Cambios:**
>
> Con base en los marcos estandarizados de ITIL y RUP, se modeló el flujo de gestión en seis etapas secuenciales:
>
> 1. Identificación y Registro: Emisión formal de la Solicitud de Cambio (CR).
> 2. Evaluación de Impacto: Análisis técnico de esfuerzo, costos y riesgos sobre la arquitectura distribuida.
> 3. Decisión del Comité (CCB): Dictamen de aprobación, rechazo, postergación o requerimiento de información adicional.
> 4. Implementación: Asignación a la cuadrilla de desarrollo y modificación de elementos de configuración de software (ECSs).
> 5. Verificación y Pruebas: Control de calidad (QA) y pruebas de integración continua.
> 6. Cierre y Despliegue: Actualización de la línea base del sistema y notificación a las partes interesadas.

---

### Caso 2: Sobrecarga Adjetival, Conectores Múltiples y Énfasis Desmedido

#### ❌ Antipatrón (Malo)
> Cuando se abordan sistemas con alta variabilidad, múltiples componentes distribuidos o requisitos no funcionales estrictos (seguridad, rendimiento, alta disponibilidad), el costo de un cambio no planificado en etapas avanzadas puede multiplicar hasta por 100x el costo de haberlo evaluado preliminarmente. Por tanto, invertir hasta un 15% en análisis de impacto, reuniones del CCB, actualización de la trazabilidad y pruebas de regresión resulta ser altamente rentable (*prevención vs. corrección*).

*Diagnóstico del error*: Oraciones kilométricas, conectores superfluos, lenguaje publicitario (*"altamente rentable"*, *"100x"*), paréntesis explicativos innecesarios y cursivas ornamentales.

#### ✅ Estándar Corregido (Bueno)
> En arquitecturas con alta variabilidad o requisitos rigurosos de seguridad y disponibilidad, el costo de mitigar un cambio tardío supera con creces la inversión de una evaluación temprana. Los análisis de ingeniería reflejan que asignar hasta un 15% del esfuerzo inicial a la evaluación de impacto, sesiones del CCB y pruebas de regresión reduce drásticamente las fallas en entornos de producción.

---

### Caso 3: Inclusión de Volcados Masivos de Código vs. Snippets Analizados

#### ❌ Antipatrón (Malo)
> Se implementó el siguiente servicio de autenticación:
> ```typescript
> import { Injectable, UnauthorizedException } from '@nestjs/common';
> import { JwtService } from '@nestjs/jwt';
> import { UsersService } from '../users/users.service';
> import * as bcrypt from 'bcrypt';
> 
> @Injectable()
> export class AuthService {
>   constructor(
>     private usersService: UsersService,
>     private jwtService: JwtService,
>   ) {}
> 
>   async validateUser(username: string, pass: string): Promise<any> {
>     const user = await this.usersService.findOne(username);
>     if (user && await bcrypt.compare(pass, user.password)) {
>       const { password, ...result } = user;
>       return result;
>     }
>     return null;
>   }
> 
>   async login(user: any) {
>     const payload = { username: user.username, sub: user.userId };
>     return {
>       access_token: this.jwtService.sign(payload),
>     };
>   }
> }
> ```
> Como se puede ver, el código funciona correctamente.

*Diagnóstico del error*: Pegar el archivo entero con imports, constructores y código trivial sin explicar la lógica subyacente de la decisión de diseño.

#### ✅ Estándar Corregido (Bueno)
> Para salvaguardar las credenciales de los usuarios, la validación se delegó a una rutina asíncrona que contrasta el hash almacenado mediante `bcrypt.compare`, omitiendo la contraseña del objeto de retorno para prevenir fugas de información en memoria:
>
> ```typescript
> async validateUser(username: string, pass: string): Promise<UserSanitized | null> {
>   const user = await this.usersService.findOne(username);
>   if (user && await bcrypt.compare(pass, user.password)) {
>     const { password, ...result } = user;
>     return result;
>   }
>   return null;
> }
> ```
>
> Una vez verificado el hash criptográfico, el método genera un token JWT firmado que encapsula el identificador del usuario y sus privilegios de acceso.
