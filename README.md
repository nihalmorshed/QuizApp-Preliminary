# QuizApp Preliminary

A Flutter-based personality quiz application that determines your personality type through three fun questions.

## Features

- Three-question personality assessment (favorite color, food, and superhero)
- Score-based personality categorization
- Quiz restart functionality
- Cross-platform support (Android, iOS, Windows)

## Getting Started

### Prerequisites

- Flutter SDK installed
- Dart SDK (>=2.16.2 <3.0.0)

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## How It Works

Users answer three questions, each answer contributing to a cumulative score. Based on the final score, the app displays one of four personality results:

| Score Range | Personality |
|-------------|-------------|
| 0-8 | "You're innocent!" |
| 9-12 | "Pretty Likable" |
| 13-16 | "You're...strange!!" |
| 17+ | "You're so bad!!" |

## Project Structure

```
lib/
├── main.dart          # App entry point and state management
├── quiz.dart          # Quiz container widget
├── questionsfile.dart # Question display widget
├── answersfile.dart   # Answer button widget
└── result.dart        # Result screen widget
```

## Build Commands

```bash
# Android APK
flutter build apk

# Android App Bundle
flutter build appbundle

# iOS
flutter build ios
```

## Documentation

For detailed technical documentation including architecture, component deep-dives, and modification guides, see [TECHNICAL.md](TECHNICAL.md).

## License

This project is for educational purposes.
