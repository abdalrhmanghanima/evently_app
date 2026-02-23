<p align="center">
  <img src="assets/readme/cover.png" alt="Evently App Preview" width="700"/>
</p>

# Evently App 🎉
Event management mobile application built with Flutter.

Evently is a modern Flutter application that allows users to discover events, create and manage their own events, with support for authentication, localization, theme switching, persistent local storage, real-time GPS tracking, and seamless Google Maps integration for interactive event navigation and location selection.

---

## 🚀 Features
- User Authentication (Login & Signup)
- OnBoarding Flow
- Browse Events
- Event Details Screen
- Add & Edit Events
- Google Maps Integration
- Real-time GPS Location Selection
- Light & Dark Theme Support
- Localization (Multi-language)
- Persistent User Preferences
- Clean & Responsive UI (Android & iOS)

---

## 🛠️ Tech Stack
- Flutter & Dart
- Firebase
- Local Database (DAO Pattern)
- Shared Preferences
- Provider (State Management)
- Localization (l10n)
- Google Maps SDK
- GPS & Location Services
- Clean Architecture Principles

---

## 📱 App Screenshots

<p align="center">
  <img src="assets/readme/signup.png" width="200"/>
  <img src="assets/readme/home.png" width="200"/>
  <img src="assets/readme/eventDetails.png" width="200"/>
</p>

<p align="center">
  <img src="assets/readme/addEvent.png" width="200"/>
</p>

### 📍 Google Maps & GPS Integration

<p align="center">
  <img src="assets/readme/map.png" width="250"/>
</p>

---

## 📦 Project Structure
```text
lib/
 ├── database/
 │    ├── model/
 │    ├── EventsDao.dart
 │    └── UsersDao.dart
 │
 ├── extensions/
 │    ├── context_extension.dart
 │    └── date_time_extensions.dart
 │
 ├── l10n/
 │
 ├── ui/
 │    ├── common/
 │    ├── design/
 │    ├── providers/
 │    └── screens/
 │
 ├── firebase_options.dart
 ├── routes.dart
 └── main.dart

👨‍💻 Author

Abdelrahman Ghanima
Flutter Mobile Application Developer