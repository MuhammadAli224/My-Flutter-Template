# 🚀 Flutter Clean Architecture Template

A production-ready Flutter project template built using **Clean Architecture**, **Cubit**, **Hive**, **Dio**, **Freezed**, and **Mason Bricks** for feature generation. This template provides a scalable and modular approach for developing Flutter apps efficiently.

---

## 📁 Project Structure

```
lib/
├── core/                   # Shared utilities, errors, themes, services
├── features/               # All app features live here
│   └── new_feature/
│       ├── data/
│       │   ├── datasource/
│       │   │   └── new_feature/
│       │   │       ├── local_new_feature_data_source.dart
│       │   │       └── remote_new_feature_data_source.dart
│       │   ├── endpoint/
│       │   │   └── new_feature_endpoint.dart
│       │   ├── model/
│       │   │   └── new_feature_dto.dart
│       │   └── repository/
│       │       └── new_feature_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── new_feature_entity.dart
│       │   ├── mapper/
│       │   │   └── new_feature_mapper.dart
│       │   ├── usecases/
│       │   │   └── get_new_feature_case.dart
│       │   └── repository/
│       │       └── new_feature_repository.dart
│       ├── di/
│       │   └── new_feature_di.dart
│       └── presentation/
│           └── new_feature/
│               ├── cubit/
│               │   ├── new_feature_cubit.dart
│               │   └── new_feature_state.dart
│               ├── pages/
│               │   └── new_feature_page.dart
│               ├── shared/
│               └── widget/
│                   └── new_feature_body.dart
├── new_feature_barrel.dart  # Barrel file for re-exports
```

---

## ⚙️ Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/MuhammadAli224/My-Flutter-Template.git
cd My-Flutter-Template
```

Or click **"Use this template"** on GitHub to start a new project based on it.

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Generate Code

The project uses [Freezed](https://pub.dev/packages/freezed), so after creating new models or states:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 🧱 Feature Generator via Mason

This template uses [Mason](https://pub.dev/packages/mason_cli) to generate features.

### 🔨 Setup Mason

Install Mason CLI if you haven’t already:

```bash
dart pub global activate mason_cli
```

### 📦 Use Brick to Generate a Feature

```bash
mason make feature
```

This will prompt you for the feature name and generate a fully structured feature folder under `features/`.

---

## 🧠 State Management

This template uses **Cubit** (from the `flutter_bloc` package) for state management. Each feature includes:

- A Cubit (`new_feature_cubit.dart`)
- A State (`new_feature_state.dart`)

---

## 📡 API & Data Handling

### ✅ Dio

Dio is used for making network requests. It is wrapped inside your custom remote data sources.

### 💾 Hive

Hive is used for local caching in the `local_new_feature_data_source.dart`.

---

## ❄️ Freezed for Models

Freezed helps with:

- Data classes
- Union types (sealed classes)
- Code generation (e.g., copyWith, equality)

Used in:
- DTOs
- Cubit states
- Entities if needed

---

## 🧪 Dependency Injection

Each feature has its own `di/new_feature_di.dart`, which contains:

- Data source registrations
- Repository bindings
- Use case injections
- Cubit registration

You can import this in the app-level DI container to initialize the feature.

---

## ✅ How to Add a New Feature

```bash
mason make feature
```

Then:
1. Register the feature’s `di.dart` in your main DI.
2. Use `GoRouter` or your preferred navigation method to navigate to the new feature page.
3. Call the `UseCase` from the Cubit, which in turn calls the repository -> data source.

---

## 🧰 Tools Used

| Tool        | Purpose                        |
|-------------|--------------------------------|
| 🧱 Mason     | Generate features via bricks   |
| 🧠 Cubit     | Lightweight state management   |
| 🧊 Freezed   | Code generation for classes    |
| 🧪 Dio       | HTTP requests handling         |
| 📦 Hive      | Local storage                  |
| 🔧 BuildRunner | Code generation               |

---

### 🌍 Localization

This template includes built-in support for multilingual apps using [`easy_localization`](https://pub.dev/packages/easy_localization).

#### ✅ Supported Locales:
- English (`en`)
- Arabic (`ar`)

#### 📁 Translation Files:

```
lib/core/localization/language/
├── en.dart
└── ar.dart
```

#### 🔧 Setup

1. **Wrap your app with `EasyLocalization`:**

```dart
return EasyLocalization(
  supportedLocales: const [Locale('en'), Locale('ar')],
  path: 'lib/core/localization/language',
  fallbackLocale: const Locale('en'),
  child: MyApp(),
);
```

2. **Usage in widgets:**

```dart
Text('hello'.tr()), // loads value for 'hello' from en.dart or ar.dart
```

3. **Change language programmatically:**

```dart
context.setLocale(Locale('ar'));
```

---

### 📝 Tip

Make sure to register your `.dart` localization files if you're using code-based maps instead of JSON, using `EasyLocalizationLoader` or custom loaders.


---

## 📖 License

[MIT](LICENSE)

---

## 🤝 Contributing

Feel free to open issues or pull requests to improve the template!

---

## 📬 Contact

Created with 💙 by Muhammad Ali

GitHub: [Muhammad Ali](https://github.com/MuhammadAli224)