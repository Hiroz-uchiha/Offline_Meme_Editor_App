# 🖼️ Offline Meme Editor

A Flutter application to create, edit, and save memes offline using clean architecture. It supports offline-first functionality using Hive for local storage and Dio for remote API access.

---

## 🚀 Getting Started

### Requirements:
- Flutter SDK ≥ 3.x
- Dart SDK
- Android Studio, VS Code, or any Flutter-compatible IDE
- A connected Android device or emulator
- Internet access to fetch meme templates (first-time only)
- ✅ Target SDK: **Android API 35 (Android 14)**

---

### Setup & Run

```bash
# 1. Clone the repository
git clone https://github.com/Dustymon111/offline-meme-editor.git
cd offline-meme-editor

# 2. Install dependencies
flutter pub get

# 3. (Optional) Configure Android SDK manually
#    Make sure android/app/build.gradle contains:
#    compileSdkVersion 35
#    targetSdkVersion 35
#    minSdkVersion 21

# 4. Generate necessary files
flutter pub run build_runner build
# (If error: delete conflicting outputs)
flutter pub run build_runner build --delete-conflicting-outputs

# 5. Run the app
flutter run

# 6. Run unit tests
flutter test

# 7. Build APK
flutter build apk
# APK will be in: build/app/outputs/flutter-apk/app-release.apk
