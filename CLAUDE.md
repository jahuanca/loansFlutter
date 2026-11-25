# loands_flutter — App móvil de préstamos

App **Flutter 3.35.6 (vía `fvm`) + GetX** que consume la API de `loans_node`. Clean Architecture por módulo, caché offline con **Hive** y Firebase (Firestore para feature flags, Analytics).

> Ojo: la carpeta y el paquete se llaman `loands_flutter` (con typo). Los imports son `package:loands_flutter/...`.

## Comandos

Usar siempre `fvm` delante de `flutter`/`dart` (la versión está fijada en `.fvmrc`).

- `fvm flutter pub get` — instala dependencias.
- `fvm flutter analyze` — verificación obligatoria tras cualquier cambio. No debe haber errores nuevos.
- `fvm flutter run --dart-define-from-file=env.json` — emulador (`melos run dev` hace lo mismo). Teléfono físico: `env.device.json`.
- `fvm dart run build_runner build --delete-conflicting-outputs` — regenera los `*.g.dart` de Hive (`melos run create_adapter`). **Pedir OK a Jose antes de correrlo.**
- No hay carpeta `test/` todavía.
- No leer ni mostrar `env.json` / `env.device.json` (están en `.gitignore`). Solo `env.example.json` se versiona.

## Arquitectura (Clean Architecture por módulo)

Módulos en `lib/src/<modulo>/`: `customers`, `loans`, `home`, `login`, `settings`, `chats`, `users`, `utils` (compartido).

```
ui/pages/<pantalla>/ (page + controller GetX)
  → domain/use_cases → domain/repositories (abstract)
  → data/repositories (*_implementation) → data/datastores (abstract + online/offline)
  → AppHttpManager (paquete utils) → API loans_node
```

| Carpeta | Responsabilidad |
|---|---|
| `di/<pantalla>_binding.dart` | `Bindings` de GetX: registra datastore → repository → use cases → controller con `Get.lazyPut` |
| `ui/pages/<pantalla>/` | `<pantalla>_page.dart` (widget), `<pantalla>_controller.dart` (`GetxController`), opcional `<pantalla>_ui.dart` (estado del formulario con `ValidateResult`) y enums |
| `ui/widgets/` | Widgets reutilizables del módulo (`*_widget.dart`) |
| `domain/entities/` | Modelos con `fromJson`/`toJson`; algunos con Hive (`@HiveType`) |
| `domain/use_cases/` | Una clase por acción con `execute(...)`. Plano en `loans/`, `home/`; con subcarpetas por submódulo en `customers/` (`use_cases/customer/`) |
| `domain/repositories/` | `abstract class XRepository` |
| `data/repositories/` | `XRepositoryImplementation`: delega en el datastore; si hay offline, decide con `isConnected` |
| `data/datastores/` | `abstract class XDatastore` + `XOnlineDatastore` (HTTP) + opcional `XOfflineDatastore` (Hive). Con submódulos van en subcarpeta: `datastores/loan/` |
| `data/requests/`, `data/responses/` | DTOs de envío y de respuestas que no son entidades (`request/`/`response/` en singular en `home` y `login`) |
| `core/` | Constantes/utilidades del módulo |

### Piezas clave en `lib/src/utils/`

- `core/helpers.dart` — `executeResponseObject` / `executeResponseList` (convierten `AppResponseHttp` en `Result<T>`; la lista puede guardar en Hive vía `sourceHiveDb`) y `executeResultUI`.
- `core/hive_db_config.dart` — enum `HiveDbAdapters` (nombres de cajas) y los `typeId` de cada adapter.
- `core/strings_arguments.dart` — claves de `Get.arguments` (`loanSelectedArgument`, `customerArgument`...).
- `core/ids_get.dart` — ids para `update([...])` / `GetBuilder(id:)`. `pageIdGet` viene del paquete `utils`.
- `core/config.dart` — `API_URL`, `SOCKET_URL`, `APP_ENV` con `String.fromEnvironment`.
- `core/feature_flag/` (Firestore) y `core/analytics/` — servicios globales.
- `ui/widgets/loading/loading_service.dart` — `showLoading()`, `hideLoading()`, `isConnected`.
- `ui/widgets/error/error_service.dart` — `showError(...)`; 401/422 cierra sesión y borra Hive.
- `ui/pages/routes_app.dart` (`RoutesApp`) y `ui/navigation_to.dart` (`NavigationTo`) — navegación centralizada.

### Arranque

`main.dart`: `UtilConfig.configure(appConfig)` → prefs → Firebase → `Get.put` de servicios globales (`LoadingService`, `FeatureFlagService`, `AnalyticsService`, `ErrorService`) → `Hive.initFlutter()` + `registerAdapter` de cada entidad Hive → `App`. `app.dart` usa `MainBinding` y elige `LoginPage` o `BackToSesionPage` según `keepSesion`.

## Patrones GetX usados

- **Navegación sin rutas con nombre**: `Get.to(() => XPage(), binding: XBinding(), arguments: {xArgument: valor})`. El enum `RoutesName` existe pero casi no se usa. Para pantallas reutilizadas, agregar un método en `RoutesApp` o `NavigationTo`.
- **Page**: `StatelessWidget` con `final XController controller = Get.find<XController>();` y `GetBuilder<XController>(id: pageIdGet, builder: ...)`. Sin `Obx`/`.obs`: el refresco es manual con `update([pageIdGet])` o un id de `ids_get.dart`.
- **Controller**: dependencias por constructor (`required this.getXUseCase`), argumentos en `onInit` (`Get.setArgument(xArgument)`), carga inicial en `onReady`.
- **Resultado**: todo método de datos devuelve `Result<T>` y el controller hace `switch (result) { case Success(): ...; case Error(): ... }`, envuelto en `showLoading()` / `hideLoading()`.
- **Diálogos/snackbars**: `showDialogWidget`, `showSnackbarWidget` del paquete `utils` (repo `github.com/jahuanca/utilsFlutter`).

## Convenciones

- Archivos en `snake_case`, clases en PascalCase: `get_loan_use_case.dart` → `GetLoanUseCase`; `loan_online_datastore.dart` → `LoanOnlineDatastore`; `loan_repository_implementation.dart` → `LoanRepositoryImplementation`.
- Entidades: `XEntity` + función top-level `xEntityFromJson(String)` para listas.
- Llaves JSON **idénticas** al backend (camelCase). Un `include` de Sequelize llega con el nombre del modelo en PascalCase (`json['Customer']`, `json['PaymentFrequency']`).
- La UI nunca llama a `AppHttpManager`; solo los datastores online.
- Lógica de negocio en use cases o controllers, nunca en widgets.
- URLs del backend: solo rutas relativas (`url: '/loan/id/${id}'`); la base viene de `env.json`. Nada de secretos en los `env*.json` (se compilan dentro del APK).
- Textos visibles en español. Constantes de texto en `utils/core/strings.dart`.
- Nombres heredados con typos (`ganancy`, `dasboard`, `sesion`, `loands`, `pay__quota_multiple_page.dart`): no renombrar salvo que se pida.

## Hive (modo offline)

- Entidades Hive: `LoanEntity`, `CustomerEntity`, `CustomerPaymentAccountEntity`, `PaymentFrequencyEntity`, `PaymentMethodEntity`, `SummaryOfDashboardResponse`. Llevan `part 'x.g.dart';`.
- Nuevo campo: siguiente índice `@HiveField` libre; **nunca** reutilizar ni reordenar índices (corrompe datos guardados en teléfonos).
- Nueva entidad Hive: nuevo `typeId` en `hive_db_config.dart` (siguiente libre), caja en `HiveDbAdapters`, `Hive.registerAdapter(...)` en `main.dart` y regenerar con build_runner.
- Los `*.g.dart` se versionan; no editarlos a mano.

## Checklist: funcionalidad nueva que consume un endpoint

1. Leer el endpoint real en `loans_node` (ruta, Joi, modelo, includes).
2. `domain/entities/<x>_entity.dart` (y `data/requests/` si el body difiere).
3. `data/datastores/<x>_datastore.dart` (abstract) + `<x>_online_datastore.dart`.
4. `domain/repositories/<x>_repository.dart` + `data/repositories/<x>_repository_implementation.dart`.
5. `domain/use_cases/<accion>_<x>_use_case.dart`.
6. `ui/pages/<pantalla>/` con page + controller.
7. `di/<pantalla>_binding.dart` y navegación con `Get.to(..., binding: ...)`.
8. `fvm flutter analyze`.

Ejemplos de referencia: `customers/` (`type_customer` es el más simple) y `loans/` (`loan` con datastore online + offline).

## Skills disponibles

- `.claude/skills/loans-flutter-feature/` — paso a paso para conectar un endpoint nuevo (las 8 piezas de arriba). Usarla al crear funcionalidades de datos.
- `../.claude/skills/loans-api-contract-sync/` (raíz del repo) — comparar el contrato `loans_node` ↔ Flutter cuando cambia una ruta, un body o un JSON.
- `.claude/skills/pre-review/` — revisa el diff (rama vs `main` + cambios sin commit) buscando bugs, seguridad y tests faltantes. Usarla antes de push/PR (`/pre-review`).
- Reglas de sincronización de contrato: `../AGENTS.md`.

## Hooks

- `.claude/settings.json` → `PostToolUse` en `Edit|Write|MultiEdit` corre `.claude/hooks/check_edited_dart.js`: `dart analyze` solo del `.dart` editado (vía `fvm` si existe). Si hay errores/warnings sale con código 2 y Claude ve el detalle para corregirlo. Se salta los `*.g.dart`.

## Al trabajar en este repo

- Seguir exactamente el patrón de un módulo existente antes de inventar uno nuevo.
- Si Flutter necesita un campo que el backend no expone, primero se cambia `loans_node`.
- No hacer commit sin OK de Jose. Explicar brevemente las decisiones (es un proyecto de aprendizaje).
