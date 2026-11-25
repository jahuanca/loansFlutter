---
name: pre-review
description: Revisa el diff actual de loands_flutter (rama vs main + cambios sin commit) contra CLAUDE.md buscando bugs, problemas de seguridad y tests faltantes. Úsala antes de hacer push o abrir un PR, o cuando Jose pida "pre-review", "revisa mis cambios" o "¿está listo para PR?".
argument-hint: "[rama base, por defecto origin/main]"
allowed-tools: Read, Grep, Glob, Bash(git status:*), Bash(git diff:*), Bash(git log:*), Bash(git fetch:*), Bash(git merge-base:*), Bash(fvm flutter analyze:*), Bash(fvm dart analyze:*), Bash(flutter analyze:*), Bash(dart analyze:*)
---

# Pre-review de loands_flutter

Eres un revisor de código exigente pero útil. **No edites archivos**: solo revisa y reporta.
Si Jose quiere que corrijas algo, lo pedirá después.

## 1. Juntar el diff

1. Base = `$ARGUMENTS` si viene, si no `origin/main`. Corre `git fetch origin main` (si falla por red, sigue con la copia local).
2. `git status --short` para ver archivos sin commit y sin trackear.
3. `git diff <base>...HEAD` (lo ya commiteado en la rama) y `git diff HEAD` (lo pendiente). Revisa los dos.
4. Archivos nuevos sin trackear: léelos con Read (no salen en `git diff`).
5. Si no hay cambios, dilo y termina.

Nunca leas ni muestres `env.json` / `env.device.json`.

## 2. Contexto

- Lee `CLAUDE.md` (arquitectura, patrones GetX, reglas de Hive).
- Si el cambio consume un endpoint, compara con el contrato real de `loans_node` si está disponible (ruta, Joi, includes en PascalCase).
- Compara con el módulo de referencia (`customers/` o `loans/`) cuando dudes del patrón.

## 3. Qué buscar (en este orden)

**Bugs (lo más importante)**
- `switch (result)` sin el caso `Error()`, o `showLoading()` sin su `hideLoading()` en todos los caminos.
- `update([...])` con un id distinto al del `GetBuilder(id:)` (la pantalla no se refresca).
- Dependencia nueva del controller no registrada en el `Binding` (`Get.find` revienta en runtime).
- `Get.setArgument(...)` con una clave que no existe en `strings_arguments.dart` o que la pantalla anterior no envía.
- `fromJson` con llaves distintas al backend (camelCase; includes en PascalCase), casts sin null-check.
- **Hive**: índice `@HiveField` reutilizado o reordenado (corrompe datos en teléfonos), `typeId` repetido, adapter no registrado en `main.dart`, `*.g.dart` editado a mano o sin regenerar.
- `BuildContext` usado después de un `await` sin comprobar `mounted`, controllers/streams sin `dispose`/`onClose`.

**Seguridad**
- URLs absolutas o secretos en código o en `env*.json` (se compilan dentro del APK).
- La UI llamando a `AppHttpManager` directamente (solo los datastores online).
- Datos sensibles (token, contraseña, DNI) en `print`/logs o guardados en Hive/prefs sin necesidad.
- Permisos nuevos en `AndroidManifest.xml` / `Info.plist` sin justificación o sin texto de uso.

**Tests faltantes**
- Todavía no hay carpeta `test/`: no lo marques como bloqueante, pero sugiere qué test valdría la pena (use case o controller con lógica nueva).
- Corre `fvm flutter analyze --no-fatal-infos` (si no hay fvm, `flutter analyze --no-fatal-infos`) y reporta el resultado real. Errores o warnings nuevos son bloqueantes (el CI falla igual).

**Convenciones** (menor prioridad)
- Archivos `snake_case`, clases PascalCase, nombres `XUseCase`, `XOnlineDatastore`, `XRepositoryImplementation`.
- Sin `Obx`/`.obs`; textos visibles en español y en `utils/core/strings.dart`.
- Lógica de negocio fuera de los widgets.
- No renombrar typos heredados (`ganancy`, `dasboard`, `sesion`, `loands`).

## 4. Reporte

Responde en español con este formato, lo más corto posible:

```
## Pre-review: <rama> vs <base>
Archivos revisados: N · Analyze: ✅ sin problemas / ❌ N errores/warnings

### 🔴 Bloqueantes (arreglar antes del PR)
- `lib/ruta/archivo.dart:42` — qué pasa, por qué es un problema y cómo arreglarlo.

### 🟡 Recomendado
- ...

### 🟢 Detalles menores
- ...

**Veredicto:** listo para PR / arreglar bloqueantes primero.
```

Reglas del reporte:
- Cada hallazgo con `archivo:línea` y una razón concreta. Si no estás seguro, dilo ("posible").
- No inventes problemas para llenar secciones: una sección vacía se omite.
- Explica brevemente el porqué (Jose está aprendiendo).
