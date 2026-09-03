<div align="center">

# 🛠️ ServiceHub

**A Flutter app built with Clean Architecture, BLoC, and Firebase**

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com)
[![BLoC](https://img.shields.io/badge/State%20Management-BLoC%2FCubit-4285F4?style=for-the-badge)](https://bloclibrary.dev)

</div>

---

## 📖 About

**ServiceHub** is a Flutter application built from the ground up around **Clean Architecture**, with a clear separation between the **Presentation**, **Domain**, and **Data** layers. It uses **BLoC/Cubit** for state management, **Firebase** as the backend, and **get_it** for dependency injection — designed to be scalable, testable, and maintainable rather than a quick prototype.

> This project isn't just "an app" — it's a deliberate practice in building the kind of architecture expected in production-grade, senior-level Flutter development.

---

## 🏗️ Architecture

ServiceHub follows a strict **unidirectional dependency flow**:

```
              UI (Widgets / Pages)
                      │
                 BLoC / Cubit
                      │
                   UseCase
                      │
                  Repository
                      │
                  DataSource
                      │
             Firebase / REST API
```

| Layer | Responsibility | Depends On |
|---|---|---|
| **Presentation** | Widgets, pages, BLoC/Cubit, UI state | Domain |
| **Domain** | Entities, repository interfaces, use cases (pure business logic) | Nothing (framework-independent) |
| **Data** | Models, data sources, repository implementations | Domain + external services (Firebase) |

The **Domain layer never knows Firebase exists** — it only defines contracts (abstract repositories). The **Data layer** implements those contracts and is the only place that talks to Firebase directly.

```
lib/
├── core/
│   ├── di/            # get_it dependency injection setup
│   ├── constants/
│   ├── errors/
│   ├── routes/
│   ├── theme/
│   └── utils/
│
├── features/
│   └── auth/
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           ├── bloc/
│           ├── pages/
│           └── widgets/
│
└── main.dart
```

---

## ✨ Tech Stack

- **Flutter** & **Dart**
- **Firebase** — Authentication (email/password), with Firestore, FCM, Analytics, Crashlytics, Remote Config, App Check, Performance Monitoring, In-App Messaging, A/B Testing, and App Distribution planned
- **flutter_bloc** — Cubit for state management
- **get_it** — Service locator / dependency injection
- **Clean Architecture** — data / domain / presentation separation

---

## 🚀 Features

- [x] Clean Architecture project structure (data / domain / presentation)
- [x] Firebase initialization with `flutterfire configure`
- [x] Firebase Authentication (email & password) — sign in / register
- [x] Centralized dependency injection with `get_it`
- [x] Auth state management with Cubit (`Initial → Loading → Authenticated / Error`)
- [ ] Firestore integration
- [ ] Push notifications (FCM)
- [ ] Crashlytics & Analytics
- [ ] More features coming as the app grows 🚧

---

## 🧩 Dependency Injection

All dependencies are wired centrally in `core/di/injection_container.dart` using **get_it**:

```
FirebaseAuth
   ↓
FirebaseAuthDataSource
   ↓
AuthRepository (interface) → AuthRepositoryImpl
   ↓
LoginUseCase / RegisterUseCase
   ↓
AuthCubit
```

- Stateless dependencies (Firebase instances, repositories, use cases) → `registerLazySingleton`
- Stateful dependencies tied to a screen (Cubit/Bloc) → `registerFactory`

This keeps every layer decoupled — swapping Firebase for another backend later would only require changes inside the **Data** layer.

---

## 🛠️ Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- A [Firebase project](https://console.firebase.google.com/)
- [FlutterFire CLI](https://firebase.flutter.dev/docs/cli/)

### Setup

```bash
# 1. Clone the repository
git clone https://github.com/amalmathew2003/service_hub.git
cd service_hub

# 2. Install dependencies
flutter pub get

# 3. Connect Firebase to the project
flutterfire configure

# 4. Run the app
flutter run
```

---

## 📂 Project Status

This project is actively being developed step by step, layer by layer — architecture and Firebase setup first, UI polish to follow.

---

## 👤 Author

**Amal Mathew**
Flutter Developer, Thrissur, Kerala

[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/amalmathew2003)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/amal-mathew-1-)
[![Portfolio](https://img.shields.io/badge/Portfolio-000000?style=for-the-badge&logo=google-chrome&logoColor=white)](https://amalmathew2003.github.io/newportfolio/)

---

<div align="center">

⭐ Star this repo if you find the architecture useful for your own Flutter projects!

</div>
