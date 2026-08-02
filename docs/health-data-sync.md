# Integração Google Health Connect — ArtriApp

## Objetivo

Permitir que o ArtriApp leia dados de saúde do Google Health Connect (passos, sono, frequência cardíaca, energia ativa) e os exiba no gráfico de Evolução, além de gerenciar a conexão via tela de Configurações.

## Arquitetura (Local-First)

```
┌──────────────┐    ┌──────────────────┐    ┌────────────────┐    ┌──────────────┐    ┌───────────┐
│  Evolution    │    │  LoggedSettings   │    │ HealthViewModel │    │ HealthSync    │    │  SQLite   │
│  Page         │◄───│  Page             │◄───│ (ChangeNotifier)│◄───│ Service       │◄───│ (sqflite) │
│ (fl_chart)    │    │ (CustomSolidButton)│   │                 │    │               │    │           │
└──────────────┘    └──────────────────┘    └────────────────┘    └───────┬───────┘    └───────────┘
                                                                          │
                                                                   ┌──────▼───────┐
                                                                   │  HealthData   │
                                                                   │  Provider     │
                                                                   │ (health pkg)  │
                                                                   │              │
                                                                   │  ┌──────────┐│
                                                                   │  │ Method    ││
                                                                   │  │ Channel   ││
                                                                   │  └─────┬────┘│
                                                                   └───────┼──────┘
                                                                           │
                                                                   ┌───────▼───────┐
                                                                   │  Native       │
                                                                   │  HealthPlugin │
                                                                   │  (Kotlin)     │
                                                                   └───────┬───────┘
                                                                           │
                                                                   ┌───────▼───────┐
                                                                   │  Google       │
                                                                   │  Health       │
                                                                   │  Connect      │
                                                                   │  (App/SDK)    │
                                                                   └───────────────┘
```

## Fluxo de Dados

1. **Configurações** → "Conectar Smartwatch" → `HealthViewModel.connectHealth()`
2. → `HealthSyncService.requestPermissions()` → `HealthDataProvider` → plugin health → nativo → Health Connect
3. → `fetchDailyMetrics()` → lê últimas 24h de cada tipo de dado
4. → `HealthRepository.insertMetrics()` → persiste no SQLite
5. → `getWeeklyMetrics()` → busca 7 dias do SQLite
6. → Evolution Page renderiza gráfico com `fl_chart` via `getDailyAggregate()`

## Arquivos Criados / Modificados

### `pubspec.yaml` — Dependências

| Pacote | Versão | Motivo |
|--------|--------|--------|
| `health` | `^13.3.1` | SDK principal do Health Connect |
| `sqflite` | `^2.4.2` | Banco local offline-first |
| `path_provider` | `^2.1.5` | Caminho do arquivo do banco |
| `path` | `^1.9.0` | Join de paths |
| `sqflite_common_ffi` | `^2.3.4` | (dev) Testes com SQLite em desktop |
| `integration_test` | SDK | (dev) Testes de integração em dispositivo |

### `android/app/build.gradle.kts` — SDK mínimo

| Mudança | Antes | Depois |
|---------|-------|--------|
| `minSdk` | 24 | **26** |

Necessário pelo plugin `health` v13 (Health Connect SDK exige API 26+).

### `android/app/src/main/AndroidManifest.xml` — Permissões e declarações

Adicionados:

```xml
<!-- Permissões de leitura do Health Connect -->
<uses-permission android:name="android.permission.health.READ_STEPS"/>
<uses-permission android:name="android.permission.health.READ_SLEEP"/>
<uses-permission android:name="android.permission.health.READ_HEART_RATE"/>
<uses-permission android:name="android.permission.health.READ_ACTIVE_CALORIES_BURNED"/>

<!-- Query para encontrar o Health Connect -->
<queries>
    <package android:name="com.google.android.apps.healthdata" />
    <intent>
        <action android:name="androidx.health.ACTION_SHOW_PERMISSIONS_RATIONALE" />
    </intent>
</queries>

<!-- Intent-filter na MainActivity para Health Connect -->
<intent-filter>
    <action android:name="androidx.health.ACTION_SHOW_PERMISSIONS_RATIONALE" />
</intent-filter>

<!-- Activity-alias para tela de permissão -->
<activity-alias
    android:name="ViewPermissionUsageActivity"
    android:exported="true"
    android:targetActivity=".MainActivity"
    android:permission="android.permission.START_VIEW_PERMISSION_USAGE">
    <intent-filter>
        <action android:name="android.intent.action.VIEW_PERMISSION_USAGE" />
        <category android:name="android.intent.category.HEALTH_PERMISSIONS" />
    </intent-filter>
</activity-alias>
```

### `android/app/src/main/kotlin/.../MainActivity.kt` — Base class

| Mudança | Antes | Depois |
|---------|-------|--------|
| Extends | `FlutterActivity` | `FlutterFragmentActivity` |
| Import | `io.flutter.embedding.android.FlutterActivity` | `io.flutter.embedding.android.FlutterFragmentActivity` |

**Motivo:** O plugin `health` v13 usa `registerForActivityResult()` (AndroidX), que exige que a Activity estenda `ComponentActivity`. `FlutterFragmentActivity` → `FragmentActivity` → `ComponentActivity`. `FlutterActivity` estende `android.app.Activity` diretamente, o que causava "Permission launcher not found".

### `lib/models/health_metric_type.dart` — (novo)

Enum com os tipos de dado suportados:

```dart
enum HealthMetricType { steps, sleep, heartRate, activeEnergy }
```

Métodos `toDbString()` e `fromDbString()` para persistência.

### `lib/models/local_health_metrics.dart` — (novo)

Modelo de dados:

| Campo | Tipo | Descrição |
|-------|------|-----------|
| `id` | `int?` | PK auto-increment |
| `metricType` | `HealthMetricType` | Tipo do dado |
| `value` | `double` | Valor numérico |
| `startTime` | `DateTime` | Início da medição |
| `endTime` | `DateTime?` | Fim da medição |
| `unit` | `String` | Unidade (count, hours, bpm, kcal) |
| `isSynced` | `bool` | Sincronizado com servidor (reservado) |

### `lib/database/app_database.dart` — (novo)

Tabela SQLite:

```sql
CREATE TABLE health_metrics (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    metric_type TEXT NOT NULL,
    value REAL NOT NULL,
    start_time TEXT NOT NULL,
    end_time TEXT,
    unit TEXT NOT NULL,
    is_synced INTEGER NOT NULL DEFAULT 0
);
CREATE UNIQUE INDEX idx_metric_type_start ON health_metrics(metric_type, start_time);
CREATE INDEX idx_start_time ON health_metrics(start_time);
```

### `lib/repositories/health_repository.dart` — (novo)

| Método | Descrição |
|--------|-----------|
| `insertMetric()` | Insere um registro |
| `insertMetrics()` | Batch insert |
| `getMetrics()` | Query com filtros (type, data, synced) |
| `getUnsyncedMetrics()` | Registros não enviados ao servidor |
| `markAsSynced()` / `markAllAsSynced()` | Marca como sincronizado |
| `deleteMetricsOlderThan()` | Limpeza de dados antigos |
| `getMetricsCount()` | Contagem total |

### `lib/services/interfaces/health_data_provider.dart` — (novo)

Interface `IHealthDataProvider` + implementação `HealthDataProvider`:

| Método | Descrição |
|--------|-----------|
| `isAvailable()` | Verifica se Health Connect SDK está disponível (fallback `isHealthConnectAvailable()`) |
| `requestPermissions()` | Solicita permissões ao usuário via plugin nativo |
| `hasPermissions()` | Verifica se permissões já foram concedidas |
| `installHealthConnect()` | Abre Play Store para instalar Health Connect |
| `fetchData()` | Lê dados de saúde via plugin |

### `lib/services/health_sync_service.dart` — (novo)

Orquestrador central:

| Método | Descrição |
|--------|-----------|
| `isAvailable()` | Delega ao provider |
| `requestPermissions()` | Delega ao provider |
| `hasPermissions()` | Delega ao provider |
| `installHealthConnect()` | Delega ao provider |
| `fetchDailyMetrics()` | Lê últimas 24h de cada tipo, converte para `LocalHealthMetrics`, persiste |
| `getWeeklyMetrics()` | Busca 7 dias de dados no SQLite |
| `getUnsyncedMetrics()` | Registros não enviados |
| `clearOldData()` | Remove dados > 30 dias |
| `seedSimulatedData()` | **Gera 7 dias de dados fake para teste** (último, após `simulateData()`) |

**`seedSimulatedData()`**:

```dart
Future<void> seedSimulatedData() async {
  // Gera 28 registros (7 dias × 4 tipos):
  // - steps: 3000-10000
  // - sleep: 5-9 horas
  // - heartRate: 65-95 bpm
  // - activeEnergy: 150-550 kcal
  // Usa Random(42) para valores determinísticos
}
```

### `lib/view_models/health_view_model.dart` — (novo)

| Estado | Tipo | Descrição |
|--------|------|-----------|
| `isLoading` | `bool` | Operação em andamento |
| `isConnected` | `bool` | Permissões concedidas e conectado |
| `isAvailable` | `bool` | Health Connect SDK disponível |
| `installNeeded` | `bool` | Health Connect precisa ser instalado |
| `errorMessage` | `String?` | Mensagem de erro atual |

| Método | Descrição |
|--------|-----------|
| `initialize()` | Verifica disponibilidade e permissões |
| `connectHealth()` | Conecta: verifica → solicita permissão → fetch → carrega gráfico |
| `installHealthConnect()` | Abre Play Store |
| `disconnectHealth()` | Desconecta: limpa dados do gráfico |
| `refreshMetrics()` | Re-fetch dados do Health Connect |
| `simulateData()` | **Insere dados fake e recarrega o gráfico** |
| `getDailyAggregate()` | Agrega por dia (soma para steps/sleep/energy, média para FC) |
| `clearError()` | Limpa mensagem de erro |

### `lib/views/logged_settings/logged_settings_page.dart` — Modificado

Botão de Health Connect com 3 estados:

| Estado | Texto | Ação |
|--------|-------|------|
| SDK não disponível | "Instalar Health Connect" | Abre Play Store |
| SDK disponível, desconectado | "Conectar Smartwatch / Health Connect" | Solicita permissões |
| Conectado | "Desconectar Smartwatch" | Desconecta |

Botão de simulação (adicional):

| Texto | Quando visível | Ação |
|-------|---------------|------|
| "Simular Dados de Smartwatch" | Sempre (após init) | Insere 7 dias de dados fake |

### `lib/views/evolution/evolution_page.dart` — Modificado

Adicionados filtros: "Passos", "Sono", "Freq. Cardíaca", "Energia" com `FilterChip`.

`_buildHealthDataLine()` — lê `getDailyAggregate()` do ViewModel e gera `LineChartBarData`.

### `lib/utils/providers/global_providers.dart` — Modificado

Providers registrados:

```
HealthRepository → HealthSyncService → HealthViewModel
                                      → HealthDataProvider
```

### `lib/views/widgets/custom_solid_button.dart` — Modificado

`onPressed` alterado de `VoidCallback` para `VoidCallback?` (nullable) para suportar estado disabled (usado enquanto `isLoading`).

## Problemas Encontrados e Soluções

| Problema | Causa | Solução |
|----------|-------|---------|
| Compilação falha (Registrar removido) | health v10 incompatível com Flutter novo | Upgrade → `health ^13.3.1` |
| "Permission launcher not found" | `FlutterActivity` não estende `ComponentActivity` | `FlutterFragmentActivity` |
| Health Connect mostra "No compatible apps installed" | Faltavam `ACTION_SHOW_PERMISSIONS_RATIONALE` + `activity-alias` + `queries` no AndroidManifest | Adicionados conforme exemplo do plugin |
| `minSdk = 24` → erro Gradle | health v13 exige API 26 | `minSdk = 26` |
| Java 17 requerido | Gradle moderno + Kotlin 2.2 | `JAVA_HOME=/usr/lib/jvm/java-17-temurin-jdk` |
| `sqflite` em desktop | sqflite_common_ffi não inicializado | `sqfliteFfiInit()` + `databaseFactory = databaseFactoryFfi` nos testes |

## Testes

### Unitários e Widget (53 testes, todos passam)

| Suite | Arquivo | Testes | O que testa |
|-------|---------|--------|-------------|
| Models | `test/models/` | 9 | Serialização `toMap()` / `fromMap()`, `copyWith()`, equality |
| Repository | `test/repositories/` | 12 | CRUD SQLite, batch insert, query com filtros |
| Services | `test/services/` | 11 | `HealthSyncService` com mocks de provider e repository |
| ViewModels | `test/view_models/` | 12 | Ciclo connect/disconnect, simulação, estados |
| Evolution Page | `test/views/` | 5 | Renderização do gráfico com dados mock |
| Logged Settings | `test/views/` | 3 | Botão 3-estados, loading, erro |

### Integração (opção A — platform channel mockado)

| Suite | Arquivo | O que testa |
|-------|---------|-------------|
| Health Connect flow | `integration_test/health_connect_test.dart` | Conectar → seed dados → verificar gráfico |

O teste mocka o MethodChannel `flutter_health` para simular respostas do plugin nativo sem depender do Health Connect real.

Para executar:

```bash
flutter test integration_test/health_connect_test.dart
```

## Tipos de Dado Mapeados

| HealthDataType | HealthMetricType | Unidade | Agregação no gráfico |
|----------------|-----------------|---------|---------------------|
| `STEPS` | `steps` | count | Soma |
| `SLEEP_ASLEEP` | `sleep` | hours | Soma |
| `HEART_RATE` | `heartRate` | bpm | Média |
| `ACTIVE_ENERGY_BURNED` | `activeEnergy` | kcal | Soma |
