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

```bash
# 1. Clone the repository
git clone https://github.com/Hiroz-uchiha/Offline_Meme_Editor_App.git
cd Offline_Meme_Editor_App

# 2. Install dependencies
flutter pub get

# 3. Generate necessary files using build_runner
#    - Hive type adapters (for local caching)
#    - Mockito mocks (for unit testing)
flutter pub run build_runner build
# If there are conflicting outputs, run:
flutter pub run build_runner build --delete-conflicting-outputs

# 4. (Optional) Check Android SDK version
#    Make sure android/app/build.gradle contains:
#    compileSdkVersion 35
#    targetSdkVersion 35
#    minSdkVersion 21
