# 🖼️ Offline Meme Editor

A Flutter application to create, edit, and save memes offline using clean architecture. Includes offline-first support with Hive for local storage, and Dio for remote API access.

---

## ✅ Requirements

- Flutter SDK ≥ 3.x
- Dart SDK
- Android Studio, VS Code, or any Flutter-compatible IDE
- A connected Android device or emulator
- Internet access to fetch meme templates (only needed once)

> ✅ This app targets **Android API level 35 (Android 14)**

---

## 📦 Dependencies Used

- `flutter_bloc` – state management
- `hive` + `hive_flutter` – local offline storage
- `dio` – HTTP client
- `build_runner` – code generation
- `permission_handler`, `saver_gallery` – storage access
- `path_provider`, `share_plus` – file handling & sharing

---

## 🔧 Setup

### 1. Clone the Repository

```bash
git clone https://github.com/Dustymon111/offline-meme-editor.git
cd offline-meme-editor
