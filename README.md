# 🖼️ Offline Meme Editor App

Meme is a Flutter app built on clean architecture. The app supports both offline and online functionality, with Hive as local storage and Dio for data access from remote APIs.

---

## ✅ Requirements

- Flutter SDK ≥ 3.x
- Dart SDK
- Android Studio, VS Code, or any Flutter-compatible IDE
- A connected Android device or emulator
- Internet access to fetch meme templates (first-time only)
- ✅ Target SDK: **Android API 35 (Android 14)**

---

## 🔧 Setup

To get started with the project, follow these steps:

### 1. Clone the repository
```bash
git clone https://github.com/Hiroz-uchiha/Offline_Meme_Editor_App.git
```
```bash
cd Offline_Meme_Editor_App
```

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Generate Necessary Files
This project uses build_runner to generate:
```bash
flutter pub run build_runner build
```

### 4. Run the App
```bash
flutter run
```

### 5. Run Unit Test
```bash
flutter test
```

### 6. Build APK
```bash
flutter build apk
```


### 7. Project Structure
```bash
lib/
├── core/           # Core utilities, errors, network, dependency injection
├── data/           # Data sources, models, repositories
├── domain/         # Entities, repositories, use cases
├── presentation/   # UI pages, controllers, widgets
├── main.dart
```
