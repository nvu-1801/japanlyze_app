# JapaLyze Mobile App

**JapaLyze** is a comprehensive mobile application built with Flutter, designed to help users learn Japanese effectively using Artificial Intelligence (AI) and Spaced Repetition System (SRS).

## Features

- **Flashcards & SRS**: Learn vocabulary and grammar effectively with our Spaced Repetition System to ensure long-term retention.
- **AI Integration**: AI-powered features for a personalized learning experience (Speech to Text, Text to Speech).
- **Offline Support**: Local data caching via Isar Database allows learning on the go.
- **Authentication**: Secure user authentication and data syncing powered by Supabase.
- **Audio & Speech**: Built-in Text-to-Speech (TTS) for pronunciation and Speech-to-Text for speaking practice.

## Tech Stack & Architecture

This project follows **Clean Architecture** principles and uses **BLoC** (Business Logic Component) for state management.

### Key Dependencies

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: `flutter_bloc`
- **Dependency Injection**: `get_it`
- **Network Request**: `dio`
- **Backend as a Service**: `supabase_flutter` 
- **Local Database**: `isar` (Fast NoSQL database)
- **Functional Programming**: `dartz` & `equatable`
- **Media & Hardware**: `flutter_tts`, `speech_to_text`
- **Notifications**: `flutter_local_notifications`

## Project Structure

The codebase is organized using Clean Architecture:
```
lib/
├── core/               # App-wide constants, errors, and utilities
├── data/               # Data Layer (Models, Repositories implementations, Data Sources)
├── domain/             # Domain Layer (Entities, UseCases, Repositories interfaces)
├── presentation/       # Presentation Layer (Pages, Widgets, BLoCs)
├── injection_container.dart # Dependency Injection setup
└── main.dart           # App entry point
```

## Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Version >= 3.0)
- IDE (VS Code, Android Studio, or IntelliJ) with Flutter & Dart plugins installed.

### Installation

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd japanlyze_app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Generate Isar models and build runner files:**
   Because this project uses `isar` and `get_it`, you need to run the build runner to generate necessary files (e.g., `*.g.dart`).
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Environment Variables (.env):**
   Create a `.env` file in the root directory and ensure all required API keys are populated (e.g., Supabase URLs, AI keys, etc.).
   *Note: Never commit your `.env` file to version control.*

5. **Run the app:**
   Select your target device (Emulator or Physical Device) and build:
   ```bash
   flutter run
   ```

## Contributing

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
