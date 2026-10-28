# EPIS-UNSA Academic & Technical Report Writer

[![Skills.sh](https://img.shields.io/badge/skills.sh-epis--unsa--report--writer-blue)](https://skills.sh)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Language: ES](https://img.shields.io/badge/Language-Spanish-green.svg)](#)

Agent skill establishing high-standard academic and technical writing principles for laboratory reports, technical projects, and university coursework at **EPIS-UNSA** (Escuela Profesional de Ingeniería de Sistemas - Universidad Nacional de San Agustín).

Completely decoupled from specific typesetting engines (Typst, LaTeX, Markdown, or DOCX), this skill focuses on **rigorous content, structured thinking, objective exposition, and anti-pattern eradication**.

---

## Features

- **Format-Agnostic Content Focus**: Guidelines apply universally across Typst, LaTeX, Markdown, Pandoc, and Word/DOCX.
- **Anti-Pattern Eradication**: Eliminates nested *bullet sprawl*, overuse of parentheses, emotional/marketing adjectivation, and bolding saturation.
- **Strict 3-Level Heading Hierarchy**: Enforces clean document architecture (`#`, `##`, `###`), preventing readability loss caused by 4th-level micro-headings.
- **Selective Snippet Management**: Distinguishes project repositories from document snippets; enforces concise, analyzed code blocks over raw file dumps.
- **4-Phase Drafting Workflow**: Guides the agent through Rapid Drafting & Rubric Coverage $\rightarrow$ Hierarchical Structuring $\rightarrow$ Evidence & Analysis $\rightarrow$ Stylistic Pruning.
- **Evaluation Checklist Included**: Companion checklist in [`references/report-checklist.md`](references/report-checklist.md) for pre-submission quality audits.

---

## Installation

Install using the official [skills.sh](https://skills.sh) CLI (`npx skills`):

### 1. Project-level Installation
Installs the skill into your current project workspace for configured agents:

```bash
npx skills add alvaro9rqc/epis-unsa-report-writer
```

### 2. Global Installation
Installs the skill globally for all projects on your machine:

```bash
npx skills add alvaro9rqc/epis-unsa-report-writer -g
```

### 3. Inspect Repository Skills Without Installing
```bash
npx skills add alvaro9rqc/epis-unsa-report-writer --list
```

### 4. Direct Prompt Piping (One-shot use)
Pipe the skill instructions directly into your agent without permanently installing:

```bash
npx skills use alvaro9rqc/epis-unsa-report-writer@epis-unsa-report-writer | claude
```

---

## Supported AI Agents

This skill conforms to the open Agent Skills standard and is compatible with:

- **Claude Code** (`claude`)
- **Cursor**
- **Antigravity CLI**
- **Cline / Roo Code**
- **GitHub Copilot**
- **Windsurf**

---

## Usage Examples

Once installed, invoke the skill in your agent prompt when drafting, structuring, or reviewing an academic report:

### Example 1: Drafting from a University Lab Guide
> *"Actúa con la skill epis-unsa-report-writer. Tengo la Guía de Laboratorio 04 de Sistemas Distribuidos adjunta y las capturas de la ejecución en Docker. Redacta el borrador del informe asegurando cubrir todos los criterios de la rúbrica y siguiendo la regla de máximo 3 niveles de encabezados."*

### Example 2: Refactoring an Existing Draft
> *"Usa la skill epis-unsa-report-writer para auditar y refactorizar este borrador de informe. Elimina el exceso de viñetas anidadas (bullet sprawl), quita los paréntesis innecesarios y redacta el procedimiento en párrafos técnicos fluidos en tercera persona."*

### Example 3: Verifying Against the Checklist
> *"Evalúa este informe técnico utilizando el checklist de calidad de epis-unsa-report-writer (`references/report-checklist.md`). Entrega un informe de discrepancias y propón los cambios de redacción correspondientes."*

---

## Repository Structure

```
epis-unsa-report-writer/
├── SKILL.md                     # Agent skill instructions and anti-pattern guide
├── references/
│   └── report-checklist.md      # Comprehensive quality verification checklist
├── LICENSE                      # MIT License
└── README.md                    # Documentation and skills.sh discovery metadata
```

---

## Contributing & License

Contributions, improvements, and course-specific rubric adaptations are welcome via pull requests.

Distributed under the [MIT License](LICENSE).
