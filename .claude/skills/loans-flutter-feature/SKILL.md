---
name: loans-flutter-feature
description: Conecta la app loands_flutter a un endpoint de loans_node siguiendo su Clean Architecture con GetX (entity, datastore, repository, use case y binding). Úsalo cuando Jose pida consumir un endpoint nuevo o agregar una funcionalidad de datos en un módulo de Flutter.
---

# Funcionalidad nueva en loands_flutter

App Flutter (gestionada con `fvm`) + GetX. Cada módulo vive en `lib/src/<modulo>/` (customers, loans, users, home, chats, settings, login, utils):

```
ui (page + controller GetX) → domain/use_cases → domain/repositories (abstract)
  → data/repositories (*_implementation) → data/datastores (abstract + *_online_datastore) → API
```

## Antes de escribir
1. Lee el endpoint real en `loans_node` (ruta, Joi, modelo, includes). Si hay dudas de contrato, usa la skill `loans-api-contract-sync`.
2. Toma como referencia `lib/src/customers/` (`type_customer` es el ejemplo más simple; `customer` el completo).

## Piezas a crear (submódulo `<sub>` en snake_case)
| Capa | Ruta | Contenido |
|---|---|---|
| entity | `domain/entities/<sub>_entity.dart` | campos con las llaves **camelCase** exactas del JSON, `fromJson`, `toJson`, y `<sub>EntityFromJson(String)` para listas |
| request | `data/requests/<accion>_<sub>_request.dart` | solo si el body difiere de la entity; `toJson` con las llaves que acepta el Joi |
| datastore | `data/datastores/<sub>/<sub>_datastore.dart` | `abstract class` con `Future<Result<T>>` |
| datastore online | `data/datastores/<sub>/<sub>_online_datastore.dart` | `AppHttpManager().get/post/put/delete(url: ...)` + `executeResponseObject` o `executeResponseList` |
| repository | `domain/repositories/<sub>_repository.dart` | `abstract class` |
| repository impl | `data/repositories/<sub>_repository_implementation.dart` | recibe `datastore` y delega |
| use case | `domain/use_cases/<sub>/<accion>_<sub>_use_case.dart` | una clase por acción con `execute(...)` |
| binding | `di/<pantalla>_binding.dart` | `Get.lazyPut<Datastore>`, `Get.lazyPut<Repository>`, `Get.lazyPut(UseCase)` |

## Reglas
1. Todo método de datos devuelve `Result<T>` (paquete `utils`); la UI no llama a `AppHttpManager` directamente.
2. Llaves JSON idénticas a las del backend (camelCase). Un `include` de Sequelize llega con el nombre del modelo (ej. `PaymentProvider`).
3. Entidades con Hive: no reutilizar índices de `@HiveField` ni `typeId` (`lib/src/utils/core/hive_db_config.dart`). Si cambias campos, regenera `*.g.dart` con `fvm dart run build_runner build --delete-conflicting-outputs`, pidiendo OK a Jose primero.
4. Lógica de negocio en use cases o controllers GetX, nunca en widgets.
5. Las URLs del backend vienen de `--dart-define-from-file` (`env.json`); no las escribas fijas.

## Verificación
- `fvm flutter analyze` sin errores nuevos.
- Lista de archivos creados/modificados y el endpoint que consume cada datastore.

## Cierre
No hacer commit sin OK de Jose. Explica brevemente las decisiones (es un proyecto de aprendizaje).
