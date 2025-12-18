# QuizApp Preliminary - Complete Technical Documentation

## Table of Contents

1. [Project Overview](#project-overview)
2. [Technology Stack](#technology-stack)
3. [Project Architecture](#project-architecture)
4. [Directory Structure](#directory-structure)
5. [Core Components Deep Dive](#core-components-deep-dive)
6. [State Management System](#state-management-system)
7. [Data Models & Structures](#data-models--structures)
8. [UI Components & Styling](#ui-components--styling)
9. [Platform-Specific Configurations](#platform-specific-configurations)
10. [Graphical Elements & Assets](#graphical-elements--assets)
11. [Application Flow & Logic](#application-flow--logic)
12. [Scoring System & Personality Algorithm](#scoring-system--personality-algorithm)
13. [Modification Guide](#modification-guide)
14. [Development Tasks Completed](#development-tasks-completed)
15. [Known Issues & Technical Debt](#known-issues--technical-debt)
16. [Commands Reference](#commands-reference)

---

## Project Overview

**QuizApp Preliminary** is a Flutter-based mobile application that implements a personality quiz with three questions. Users answer questions about their favorite color, food, and superhero, and based on their accumulated score, receive a personalized result message categorizing their personality.

### Key Features
- Three-question personality assessment
- Dynamic score accumulation system
- Personalized result messages based on score ranges
- Quiz restart functionality
- Cross-platform support (Android, iOS, Windows)

### Application Lifecycle
```
Launch → Question 1 → Question 2 → Question 3 → Result Screen → [Restart] → Question 1...
```

---

## Technology Stack

### Primary Framework
| Technology | Version | Purpose |
|------------|---------|---------|
| Flutter | SDK | Cross-platform UI framework |
| Dart | >=2.16.2 <3.0.0 | Programming language |

### Dependencies (from `pubspec.yaml`)

#### Direct Dependencies
| Package | Version | Purpose |
|---------|---------|---------|
| `flutter` | SDK | Core Flutter framework providing widgets, rendering engine, and platform integration |
| `cupertino_icons` | ^1.0.2 | iOS-style iconography (optional, not actively used in this project) |

#### Dev Dependencies
| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_test` | SDK | Widget and unit testing framework |
| `flutter_launcher_name` | ^0.0.1 | Tool to customize the app launcher name on devices |
| `flutter_lints` | ^1.0.0 | Static analysis and linting rules for code quality |

### Build Configuration
- **Java Compatibility**: VERSION_1_8
- **Kotlin JVM Target**: 1.8
- **Android Application ID**: `com.example.flutter_complete_guide`
- **iOS Bundle Name**: `QuizApp Preliminary`

---

## Project Architecture

### Architectural Pattern
The application follows a **Stateful Parent with Stateless Children** architecture pattern:

```
┌─────────────────────────────────────────────────────────────┐
│                    MyApp (StatefulWidget)                    │
│  ┌─────────────────────────────────────────────────────┐   │
│  │                  _Myappstate (State)                 │   │
│  │  • _questions (static data)                          │   │
│  │  • _question_index (current question tracker)        │   │
│  │  • _totalscore (accumulated score)                   │   │
│  │  • _answers() (answer handler)                       │   │
│  │  • _resetquiz() (reset handler)                      │   │
│  │  • _updtqindex() (index incrementer)                 │   │
│  └─────────────────────────────────────────────────────┘   │
│                            │                                 │
│              ┌─────────────┴─────────────┐                  │
│              ▼                           ▼                  │
│  ┌─────────────────────┐    ┌─────────────────────┐        │
│  │  quiz (Stateless)   │    │ result (Stateless)  │        │
│  │  • Renders when     │    │ • Renders when      │        │
│  │    questions remain │    │   quiz is complete  │        │
│  └─────────┬───────────┘    └─────────────────────┘        │
│            │                                                 │
│  ┌─────────┴─────────────────────┐                         │
│  ▼                               ▼                         │
│  ┌─────────────────┐   ┌─────────────────┐                 │
│  │ questionsfile   │   │ Answers (x4)    │                 │
│  │ (Stateless)     │   │ (Stateless)     │                 │
│  │ • Question text │   │ • Answer button │                 │
│  └─────────────────┘   └─────────────────┘                 │
└─────────────────────────────────────────────────────────────┘
```

### Widget Hierarchy
```
MaterialApp
└── Scaffold
    ├── AppBar
    │   └── Text (title: "First Flutter Application")
    └── Body
        ├── [If questions remain] quiz
        │   └── Column
        │       ├── questionsfile
        │       │   └── Container
        │       │       └── Text (question)
        │       ├── Answers (option 1)
        │       │   └── Container
        │       │       └── RaisedButton
        │       ├── Answers (option 2)
        │       ├── Answers (option 3)
        │       └── Answers (option 4)
        │
        └── [If quiz complete] result
            └── Center
                └── Column
                    ├── Text (result phrase)
                    └── ElevatedButton (restart)
```

---

## Directory Structure

```
QuizApp-Preliminary/
│
├── lib/                              # Main Dart source code
│   ├── main.dart                     # Entry point, MyApp widget, state management
│   ├── quiz.dart                     # Quiz container widget
│   ├── questionsfile.dart            # Question display widget
│   ├── answersfile.dart              # Answer button widget
│   └── result.dart                   # Result screen widget
│
├── test/                             # Test files
│   └── widget_test.dart              # Widget tests (needs updating)
│
├── android/                          # Android platform files
│   ├── app/
│   │   ├── build.gradle              # App-level Gradle build config
│   │   └── src/
│   │       ├── main/
│   │       │   ├── AndroidManifest.xml   # App manifest
│   │       │   ├── kotlin/.../MainActivity.kt
│   │       │   └── res/
│   │       │       ├── drawable/         # Launch backgrounds
│   │       │       ├── mipmap-*/         # App icons (5 densities)
│   │       │       ├── values/           # Light theme styles
│   │       │       └── values-night/     # Dark theme styles
│   │       └── debug/
│   │           └── AndroidManifest.xml   # Debug manifest
│   ├── build.gradle                  # Project-level Gradle config
│   ├── settings.gradle               # Gradle settings
│   └── gradle.properties             # Gradle properties
│
├── ios/                              # iOS platform files
│   ├── Runner/
│   │   ├── AppDelegate.swift         # iOS entry point
│   │   ├── Info.plist                # iOS configuration
│   │   ├── Assets.xcassets/          # iOS assets
│   │   │   ├── AppIcon.appiconset/   # App icons (16 sizes)
│   │   │   └── LaunchImage.imageset/ # Launch screen images
│   │   └── Base.lproj/               # Storyboards
│   ├── Runner.xcodeproj/             # Xcode project
│   └── Flutter/                      # Flutter iOS config
│
├── windows/                          # Windows platform files
│   ├── CMakeLists.txt                # CMake build config
│   └── flutter/                      # Flutter Windows config
│
├── pubspec.yaml                      # Project manifest
├── pubspec.lock                      # Dependency lock file
├── analysis_options.yaml             # Linting configuration
├── .metadata                         # Flutter metadata
├── .gitignore                        # Git ignore rules
└── README.md                         # This documentation
```

---

## Core Components Deep Dive

### 1. main.dart - Application Entry Point

**File Location**: `lib/main.dart`

#### Entry Point Function (Line 9)
```dart
void main() => runApp(MyApp());
```
- **Purpose**: Application entry point that initializes and runs the Flutter app
- **Mechanism**: Uses arrow function syntax to call `runApp()` with `MyApp` widget instance
- **To Modify**: Change `MyApp()` to a different root widget if restructuring the app

#### MyApp StatefulWidget (Lines 11-17)
```dart
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Myappstate();
  }
}
```
- **Purpose**: Root widget that holds mutable state
- **Why StatefulWidget**: The quiz needs to track current question index and accumulated score
- **createState()**: Factory method that creates the associated State object
- **To Modify**: Add additional state variables in `_Myappstate` class

#### _Myappstate Class (Lines 19-94)

##### Static Questions Data (Lines 20-48)
```dart
static const _questions = [
  {
    'questiontext': 'What\'s ur favourite Color!?',
    'answertext': [
      {'text': 'Red', 'score': 6},
      {'text': 'Green', 'score': 3},
      {'text': 'Blue', 'score': 10},
      {'text': 'White', 'score': 1},
    ],
  },
  // ... more questions
];
```
- **Data Type**: `List<Map<String, Object>>` - List of maps containing question data
- **Structure**: Each question has `questiontext` (String) and `answertext` (List of answer maps)
- **Answer Structure**: Each answer has `text` (String) and `score` (int)
- **`static const`**: Compile-time constant, memory efficient, immutable
- **To Add Questions**: Add new map objects following the same structure
- **To Modify Scores**: Change the `score` values to adjust personality outcomes

##### State Variables (Lines 49-50)
```dart
var _question_index = 0;
var _totalscore = 0;
```
| Variable | Type | Initial Value | Purpose |
|----------|------|---------------|---------|
| `_question_index` | int | 0 | Tracks current question (0-based index) |
| `_totalscore` | int | 0 | Accumulates user's score across all answers |

- **Underscore Prefix**: Dart convention for private members
- **To Modify**: Change initial values if starting mid-quiz or with preset score

##### Reset Quiz Method (Lines 52-57)
```dart
void _resetquiz() {
  setState(() {
    _question_index = 0;
    _totalscore = 0;
  });
}
```
- **Purpose**: Resets quiz to initial state for replay
- **setState()**: Triggers widget rebuild with new state values
- **Called By**: Result screen's restart button via callback
- **To Modify**: Add additional reset logic (e.g., analytics tracking)

##### Update Question Index Method (Lines 59-62)
```dart
void _updtqindex() {
  _question_index++;
  print(_question_index);
}
```
- **Purpose**: Increments question counter
- **Debug Output**: `print()` statement outputs index to console
- **Note**: Called within `_answers()` method, not independently
- **To Modify**: Remove print statement in production

##### Answer Handler Method (Lines 64-75)
```dart
void _answers(int score) {
  _totalscore += score;
  setState(() {
    print('Answer chosen!');
    _updtqindex();
  });
  if (_question_index < _questions.length) {
    print('We have questions left');
  } else {
    print('We are out of questions');
  }
}
```
- **Parameter**: `int score` - The score value of the selected answer
- **Score Accumulation**: Adds answer's score to total before setState
- **State Update**: Calls `_updtqindex()` within `setState()` to trigger rebuild
- **Conditional Logging**: Debug messages for development
- **To Modify**: Add answer validation, analytics, or sound effects here

##### Build Method (Lines 77-93)
```dart
@override
Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('First Flutter Application'),
      ),
      body: _question_index < _questions.length
          ? quiz(
              answers: _answers,
              question_index: _question_index,
              questions: _questions,
            )
          : result(_totalscore, _resetquiz),
    ),
  );
}
```

**Component Breakdown:**

| Widget | Purpose | Customization Location |
|--------|---------|------------------------|
| `MaterialApp` | Root Material Design app wrapper | Add `theme:` for app-wide styling |
| `Scaffold` | Basic Material Design layout structure | Add `drawer:`, `floatingActionButton:` |
| `AppBar` | Top application bar | Line 81-83: Modify title, colors, actions |
| `body` | Main content area | Conditional rendering logic |

**Conditional Rendering Logic (Lines 84-90):**
```
IF _question_index < _questions.length (i.e., questions remain)
  THEN render quiz component
  ELSE render result component
```

---

### 2. quiz.dart - Quiz Container Widget

**File Location**: `lib/quiz.dart`

```dart
import 'package:flutter/material.dart';
import './questionsfile.dart';
import './answersfile.dart';

class quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final Function answers;
  final int question_index;

  quiz({
    required this.answers,
    required this.questions,
    required this.question_index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        questionsfile(questions[question_index]['questiontext'] as String),
        ...(questions[question_index]['answertext']
                as List<Map<String, Object>>)
            .map((ans) {
          return Answers(() => answers(ans['score']), ans['text'] as String);
        }).toList()
      ],
    );
  }
}
```

#### Class Properties (Lines 6-8)
| Property | Type | Purpose |
|----------|------|---------|
| `questions` | `List<Map<String, Object>>` | All quiz questions and answers |
| `answers` | `Function` | Callback to handle answer selection |
| `question_index` | `int` | Current question index |

#### Constructor (Lines 10-14)
- Uses named parameters with `required` keyword
- All parameters must be provided at instantiation
- **To Modify**: Add optional parameters like `questionStyle` for theming

#### Build Method Analysis

**Column Widget (Line 17)**
- Arranges children vertically
- Default: `MainAxisAlignment.start` (top-aligned)
- **To Modify**: Add `mainAxisAlignment:` for centering

**Question Display (Line 19)**
```dart
questionsfile(questions[question_index]['questiontext'] as String)
```
- Accesses current question's text using index
- Type cast to String for type safety
- Passes to `questionsfile` widget

**Answer Mapping (Lines 20-24)**
```dart
...(questions[question_index]['answertext'] as List<Map<String, Object>>)
    .map((ans) {
  return Answers(() => answers(ans['score']), ans['text'] as String);
}).toList()
```

| Component | Purpose |
|-----------|---------|
| `...` (spread operator) | Flattens list into Column children |
| `['answertext']` | Accesses answer array from current question |
| `as List<Map<String, Object>>` | Type cast for Dart analyzer |
| `.map((ans) {...})` | Transforms each answer into Answers widget |
| `() => answers(ans['score'])` | Anonymous function capturing answer's score |
| `.toList()` | Converts Iterable to List |

---

### 3. questionsfile.dart - Question Display Widget

**File Location**: `lib/questionsfile.dart`

```dart
import 'package:flutter/cupertino.dart';

class questionsfile extends StatelessWidget {
  final String ques;
  questionsfile(this.ques);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(15),
      child: Text(
        ques,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 25),
      ),
    );
  }
}
```

#### Visual Specifications

| Property | Value | Effect |
|----------|-------|--------|
| `width` | `double.infinity` | Expands to full parent width |
| `margin` | `EdgeInsets.all(15)` | 15 logical pixels on all sides |
| `textAlign` | `TextAlign.center` | Centers text horizontally |
| `fontSize` | `25` | 25 logical pixels text size |

#### Styling Breakdown

**Container Widget (Lines 9-11)**
- Wrapper providing sizing and spacing
- `width: double.infinity` ensures question spans full width
- `margin: EdgeInsets.all(15)` creates 15px breathing room

**Text Widget (Lines 12-16)**
- Displays the question string
- Centered alignment for visual balance
- 25px font size for readability

**To Modify Appearance:**
| Change | Location | Example |
|--------|----------|---------|
| Font size | Line 15 | `fontSize: 30` |
| Font weight | Line 15 | `fontWeight: FontWeight.bold` |
| Text color | Line 15 | `color: Colors.blue` |
| Margin | Line 11 | `EdgeInsets.symmetric(horizontal: 20, vertical: 10)` |
| Background | Line 9 | Add `color: Colors.grey[100]` |

---

### 4. answersfile.dart - Answer Button Widget

**File Location**: `lib/answersfile.dart`

```dart
import 'dart:ffi';  // Note: Unused import

import 'package:flutter/material.dart';

class Answers extends StatelessWidget {
  final VoidCallback selecthandler;
  final String anstxt;
  Answers(this.selecthandler, this.anstxt);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        onPressed: selecthandler,
        color: Colors.blueGrey,
        textColor: Colors.white,
        child: Text(anstxt),
      ),
    );
  }
}
```

#### Component Properties
| Property | Type | Purpose |
|----------|------|---------|
| `selecthandler` | `VoidCallback` | Function called when button pressed |
| `anstxt` | `String` | Text displayed on button |

#### Visual Specifications

| Property | Value | Effect |
|----------|-------|--------|
| Container `width` | `double.infinity` | Full-width button |
| Button `color` | `Colors.blueGrey` | Blue-grey background (#607D8B) |
| Button `textColor` | `Colors.white` | White text (#FFFFFF) |

#### Button Behavior
1. User taps button
2. `onPressed` triggers `selecthandler` callback
3. Callback executes `_answers(score)` in parent
4. State updates, triggering rebuild

**To Modify Button Appearance:**
| Change | Property | Example |
|--------|----------|---------|
| Background color | `color:` | `Colors.indigo` |
| Text color | `textColor:` | `Colors.yellow` |
| Padding | Add to Container | `padding: EdgeInsets.all(8)` |
| Margin between buttons | Add to Container | `margin: EdgeInsets.symmetric(vertical: 5)` |
| Border radius | Use `shape:` | `shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))` |

**Note**: `RaisedButton` is deprecated. Modern equivalent:
```dart
ElevatedButton(
  onPressed: selecthandler,
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blueGrey,
    foregroundColor: Colors.white,
  ),
  child: Text(anstxt),
)
```

---

### 5. result.dart - Result Screen Widget

**File Location**: `lib/result.dart`

```dart
import 'package:flutter/material.dart';

class result extends StatelessWidget {
  final int totalScore;
  final VoidCallback resetHandler;
  result(this.totalScore, this.resetHandler);

  String get resultphrase {
    String txt;
    if (totalScore <= 8)
      txt = "You're innocent!";
    else if (totalScore <= 12)
      txt = "Pretty Likable";
    else if (totalScore <= 16)
      txt = "You're...strange!!";
    else
      txt = "You're so bad!!";
    return txt;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            resultphrase,
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: resetHandler,
            child: Text('Restart!'),
            style: ElevatedButton.styleFrom(
                primary: Colors.orange, onPrimary: Colors.cyanAccent),
          ),
        ],
      ),
    );
  }
}
```

#### Component Properties
| Property | Type | Purpose |
|----------|------|---------|
| `totalScore` | `int` | Final accumulated score |
| `resetHandler` | `VoidCallback` | Callback to restart quiz |

#### Result Phrase Getter (Lines 8-20)

**Score-to-Message Mapping:**
| Score Range | Result Message | Personality Type |
|-------------|----------------|------------------|
| 0-8 | "You're innocent!" | Low score - mild/pure |
| 9-12 | "Pretty Likable" | Medium-low - balanced |
| 13-16 | "You're...strange!!" | Medium-high - quirky |
| 17+ | "You're so bad!!" | High score - extreme |

**Logic Flow:**
```
IF totalScore <= 8 → "You're innocent!"
ELSE IF totalScore <= 12 → "Pretty Likable"
ELSE IF totalScore <= 16 → "You're...strange!!"
ELSE → "You're so bad!!"
```

**To Modify Result Messages:**
1. Navigate to `lib/result.dart` lines 10-17
2. Adjust score thresholds in `if` conditions
3. Change message strings as desired

#### Visual Layout

**Center Widget (Line 23)**
- Centers entire content both horizontally and vertically
- Parent to Column widget

**Column Widget (Lines 24-39)**
- Vertical arrangement of children
- `mainAxisAlignment: MainAxisAlignment.center` - centers children vertically within Column

**Result Text (Lines 27-31)**
| Property | Value | Effect |
|----------|-------|--------|
| Content | `resultphrase` getter | Dynamic message based on score |
| `fontSize` | `35` | Large, prominent text |
| `fontWeight` | `FontWeight.bold` | Bold for emphasis |
| `textAlign` | `TextAlign.center` | Centered text |

**Restart Button (Lines 32-37)**
| Property | Value | Effect |
|----------|-------|--------|
| `onPressed` | `resetHandler` | Triggers quiz restart |
| Text | `'Restart!'` | Button label |
| `primary` (background) | `Colors.orange` | Orange background (#FF9800) |
| `onPrimary` (text) | `Colors.cyanAccent` | Cyan text (#18FFFF) |

---

## State Management System

### State Variables Location
All state is managed in `_Myappstate` class (`lib/main.dart`):

```dart
var _question_index = 0;  // Line 49
var _totalscore = 0;      // Line 50
```

### State Flow Diagram

```
User Interaction                    State Changes                UI Update
      │                                  │                          │
      ▼                                  ▼                          ▼
┌─────────────┐                 ┌─────────────────┐         ┌─────────────┐
│ Tap Answer  │────────────────▶│ _answers(score) │────────▶│ setState()  │
│   Button    │                 │ • _totalscore+= │         │  triggers   │
└─────────────┘                 │ • _question_idx++│        │  rebuild    │
                                └─────────────────┘         └──────┬──────┘
                                                                   │
                                                                   ▼
                                                           ┌─────────────┐
                                                           │ build()     │
                                                           │ re-executes │
                                                           └──────┬──────┘
                                                                   │
                              ┌────────────────────────────────────┴────────┐
                              ▼                                             ▼
                    ┌─────────────────┐                          ┌─────────────────┐
                    │ quiz widget     │                          │ result widget   │
                    │ (if questions   │                          │ (if quiz done)  │
                    │  remaining)     │                          │                 │
                    └─────────────────┘                          └─────────────────┘
```

### Callback Chain

```
Answers.selecthandler
    │
    ▼
quiz.answers (passed as prop)
    │
    ▼
_Myappstate._answers(score)
    │
    ├── _totalscore += score
    │
    └── setState(() {
            _updtqindex();  // _question_index++
        })
            │
            ▼
        build() re-executed
            │
            └── Conditional check: _question_index < _questions.length
```

---

## Data Models & Structures

### Question Data Schema

```dart
static const _questions = [
  {
    'questiontext': String,      // The question prompt displayed to user
    'answertext': [              // Array of answer options
      {
        'text': String,          // Answer display text
        'score': int             // Points for this answer
      },
      // ... 4 answers per question
    ]
  },
  // ... 3 total questions
];
```

### Current Quiz Data

#### Question 1: Favorite Color
| Answer | Score | Personality Indication |
|--------|-------|------------------------|
| Red | 6 | Passionate/intense |
| Green | 3 | Calm/natural |
| Blue | 10 | Deep/mysterious |
| White | 1 | Pure/simple |

#### Question 2: Favorite Food
| Answer | Score | Personality Indication |
|--------|-------|------------------------|
| Meat | 3 | Traditional |
| Fish | 11 | Sophisticated/extreme |
| Vegies | 5 | Health-conscious |
| Chicken | 9 | Balanced but strong |

#### Question 3: Favorite Superhero
| Answer | Score | Personality Indication |
|--------|-------|------------------------|
| SpiderMan | 10 | Relatable hero |
| Batman | 9 | Dark/brooding |
| Superman | 5 | Classic/traditional |
| Ironman | 7 | Tech-savvy/wealthy |

### Score Range Analysis

**Minimum Possible Score**: 1 + 3 + 5 = 9 (White + Meat + Superman)
**Maximum Possible Score**: 10 + 11 + 10 = 31 (Blue + Fish + SpiderMan)

**Adjusted Result Thresholds:**
- Score 9-8: Mathematically impossible (minimum is 9)
- Score 9-12: "Pretty Likable"
- Score 13-16: "You're...strange!!"
- Score 17-31: "You're so bad!!"

---

## UI Components & Styling

### Color Palette

| Element | Color | Hex Code | Material Color |
|---------|-------|----------|----------------|
| AppBar | Blue | #2196F3 | `Colors.blue` (default) |
| Answer Buttons | Blue Grey | #607D8B | `Colors.blueGrey` |
| Answer Text | White | #FFFFFF | `Colors.white` |
| Restart Button BG | Orange | #FF9800 | `Colors.orange` |
| Restart Button Text | Cyan Accent | #18FFFF | `Colors.cyanAccent` |

### Typography

| Element | Size | Weight | Alignment |
|---------|------|--------|-----------|
| AppBar Title | Default (~20) | Normal | Left |
| Question Text | 25 | Normal | Center |
| Answer Text | Default (~14) | Normal | Center |
| Result Text | 35 | Bold | Center |
| Restart Button | Default (~14) | Normal | Center |

### Spacing & Layout

| Element | Margin/Padding | Width |
|---------|----------------|-------|
| Question Container | 15px all sides | Full width |
| Answer Container | None | Full width |
| Result Container | None (centered) | Content width |

### Visual Layout Measurements

```
┌────────────────────────────────────────────────────┐
│ ┌────────────────────────────────────────────────┐ │
│ │           AppBar (default height ~56dp)        │ │
│ │        "First Flutter Application"              │ │
│ └────────────────────────────────────────────────┘ │
│                                                    │
│    ┌──────────────────────────────────────────┐   │
│    │         margin: 15px                      │   │
│    │  ┌────────────────────────────────────┐  │   │
│    │  │   Question Text (fontSize: 25)     │  │   │
│    │  │        Centered                     │  │   │
│    │  └────────────────────────────────────┘  │   │
│    └──────────────────────────────────────────┘   │
│                                                    │
│ ┌────────────────────────────────────────────────┐ │
│ │          Answer Button 1 (blueGrey)            │ │
│ └────────────────────────────────────────────────┘ │
│ ┌────────────────────────────────────────────────┐ │
│ │          Answer Button 2 (blueGrey)            │ │
│ └────────────────────────────────────────────────┘ │
│ ┌────────────────────────────────────────────────┐ │
│ │          Answer Button 3 (blueGrey)            │ │
│ └────────────────────────────────────────────────┘ │
│ ┌────────────────────────────────────────────────┐ │
│ │          Answer Button 4 (blueGrey)            │ │
│ └────────────────────────────────────────────────┘ │
│                                                    │
└────────────────────────────────────────────────────┘
```

---

## Platform-Specific Configurations

### Android Configuration

#### AndroidManifest.xml (`android/app/src/main/AndroidManifest.xml`)

| Attribute | Value | Purpose |
|-----------|-------|---------|
| `package` | `com.example.flutter_complete_guide` | Unique app identifier |
| `android:label` | `QuizApp Preliminary` | App name on device |
| `android:icon` | `@mipmap/ic_launcher` | Launcher icon reference |
| `android:launchMode` | `singleTop` | Prevents duplicate instances |
| `android:hardwareAccelerated` | `true` | GPU rendering enabled |
| `android:windowSoftInputMode` | `adjustResize` | Resize when keyboard appears |

**Config Changes:**
- Configuration changes handled: orientation, keyboard, screenSize, locale, fontScale, density, uiMode

#### Android Themes

**Light Theme** (`values/styles.xml`):
- Parent: `Theme.Light.NoTitleBar`
- Launch background: White with optional image

**Dark Theme** (`values-night/styles.xml`):
- Parent: `Theme.Black.NoTitleBar`
- Launch background: White (same as light)

#### Build Configuration (`android/app/build.gradle`)

| Setting | Value |
|---------|-------|
| `applicationId` | `com.example.flutter_complete_guide` |
| `compileSdkVersion` | flutter.compileSdkVersion |
| `minSdkVersion` | flutter.minSdkVersion |
| `targetSdkVersion` | flutter.targetSdkVersion |
| `sourceCompatibility` | Java 1.8 |
| `kotlinOptions.jvmTarget` | 1.8 |

### iOS Configuration

#### Info.plist (`ios/Runner/Info.plist`)

| Key | Value | Purpose |
|-----|-------|---------|
| `CFBundleDisplayName` | Flutter Complete Guide | App Store name |
| `CFBundleName` | QuizApp Preliminary | Internal name |
| `UILaunchStoryboardName` | LaunchScreen | Launch screen file |
| `UIMainStoryboardFile` | Main | Main storyboard |

**Supported Orientations (iPhone):**
- Portrait
- Landscape Left
- Landscape Right

**Supported Orientations (iPad):**
- All four orientations including upside-down

#### AppDelegate.swift (`ios/Runner/AppDelegate.swift`)
- Standard Flutter iOS entry point
- Registers Flutter plugins via `GeneratedPluginRegistrant`

---

## Graphical Elements & Assets

### Android App Icons

Located in `android/app/src/main/res/mipmap-*/`:

| Density | Directory | Size | DPI |
|---------|-----------|------|-----|
| MDPI | mipmap-mdpi | 48x48 | 160 |
| HDPI | mipmap-hdpi | 72x72 | 240 |
| XHDPI | mipmap-xhdpi | 96x96 | 320 |
| XXHDPI | mipmap-xxhdpi | 144x144 | 480 |
| XXXHDPI | mipmap-xxxhdpi | 192x192 | 640 |

**To Change App Icon:**
1. Replace `ic_launcher.png` in all mipmap directories
2. Maintain correct sizes for each density
3. Or use `flutter_launcher_icons` package

### iOS App Icons

Located in `ios/Runner/Assets.xcassets/AppIcon.appiconset/`:

| Size | Scale | Actual Pixels | Usage |
|------|-------|---------------|-------|
| 20x20 | 1x | 20x20 | Notifications |
| 20x20 | 2x | 40x40 | Notifications @2x |
| 20x20 | 3x | 60x60 | Notifications @3x |
| 29x29 | 1x | 29x29 | Settings |
| 29x29 | 2x | 58x58 | Settings @2x |
| 29x29 | 3x | 87x87 | Settings @3x |
| 40x40 | 1x | 40x40 | Spotlight |
| 40x40 | 2x | 80x80 | Spotlight @2x |
| 40x40 | 3x | 120x120 | Spotlight @3x |
| 60x60 | 2x | 120x120 | App Icon @2x |
| 60x60 | 3x | 180x180 | App Icon @3x |
| 76x76 | 1x | 76x76 | iPad Icon |
| 76x76 | 2x | 152x152 | iPad Icon @2x |
| 83.5x83.5 | 2x | 167x167 | iPad Pro |
| 1024x1024 | 1x | 1024x1024 | App Store |

### Launch Screen

**Android** (`android/app/src/main/res/drawable/launch_background.xml`):
- Layer-list drawable
- Base layer: White (`@android:color/white`)
- Optional: Centered bitmap image (currently commented out)

**iOS** (`ios/Runner/Assets.xcassets/LaunchImage.imageset/`):
- LaunchImage.png (1x)
- LaunchImage@2x.png (2x)
- LaunchImage@3x.png (3x)

---

## Application Flow & Logic

### Complete User Journey

```
┌─────────────────────────────────────────────────────────────────┐
│                        APP LAUNCH                                │
│                    main() → runApp(MyApp())                      │
└─────────────────────────┬───────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│                    INITIAL STATE                                 │
│              _question_index = 0, _totalscore = 0               │
└─────────────────────────┬───────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│                    QUESTION 1 DISPLAYED                          │
│                "What's ur favourite Color!?"                     │
│    ┌──────┐ ┌───────┐ ┌──────┐ ┌───────┐                       │
│    │ Red  │ │ Green │ │ Blue │ │ White │                       │
│    │  (6) │ │  (3)  │ │ (10) │ │  (1)  │                       │
│    └──────┘ └───────┘ └──────┘ └───────┘                       │
└─────────────────────────┬───────────────────────────────────────┘
                          │ User taps answer
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│                    STATE UPDATE #1                               │
│    _totalscore += selected_score                                 │
│    _question_index = 1                                           │
└─────────────────────────┬───────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│                    QUESTION 2 DISPLAYED                          │
│                 "What's ur favourite Food!?"                     │
│    ┌──────┐ ┌──────┐ ┌────────┐ ┌─────────┐                    │
│    │ Meat │ │ Fish │ │ Vegies │ │ Chicken │                    │
│    │  (3) │ │ (11) │ │   (5)  │ │   (9)   │                    │
│    └──────┘ └──────┘ └────────┘ └─────────┘                    │
└─────────────────────────┬───────────────────────────────────────┘
                          │ User taps answer
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│                    STATE UPDATE #2                               │
│    _totalscore += selected_score                                 │
│    _question_index = 2                                           │
└─────────────────────────┬───────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│                    QUESTION 3 DISPLAYED                          │
│              "Who's ur favourite Superhero!?"                    │
│  ┌───────────┐ ┌────────┐ ┌──────────┐ ┌─────────┐             │
│  │ SpiderMan │ │ Batman │ │ Superman │ │ Ironman │             │
│  │    (10)   │ │   (9)  │ │    (5)   │ │   (7)   │             │
│  └───────────┘ └────────┘ └──────────┘ └─────────┘             │
└─────────────────────────┬───────────────────────────────────────┘
                          │ User taps answer
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│                    STATE UPDATE #3                               │
│    _totalscore += selected_score                                 │
│    _question_index = 3                                           │
│    3 >= 3 (questions.length) → Show result                      │
└─────────────────────────┬───────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│                    RESULT SCREEN                                 │
│                                                                  │
│              "You're so bad!!" (or other phrase)                │
│                                                                  │
│                  ┌──────────────┐                               │
│                  │   Restart!   │                               │
│                  └──────────────┘                               │
└─────────────────────────┬───────────────────────────────────────┘
                          │ User taps Restart
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│                    STATE RESET                                   │
│              _question_index = 0, _totalscore = 0               │
│                    → Back to Question 1                          │
└─────────────────────────────────────────────────────────────────┘
```

---

## Scoring System & Personality Algorithm

### Score Calculation

```
Total Score = Q1_Score + Q2_Score + Q3_Score
```

### Possible Score Combinations

| Q1 (Color) | Q2 (Food) | Q3 (Hero) | Total | Result |
|------------|-----------|-----------|-------|--------|
| White (1) | Meat (3) | Superman (5) | 9 | Pretty Likable |
| White (1) | Meat (3) | Ironman (7) | 11 | Pretty Likable |
| Green (3) | Meat (3) | Superman (5) | 11 | Pretty Likable |
| White (1) | Vegies (5) | Superman (5) | 11 | Pretty Likable |
| White (1) | Meat (3) | Batman (9) | 13 | Strange |
| Blue (10) | Fish (11) | SpiderMan (10) | 31 | So Bad |

### Personality Categories

```
Score 0-8:   "You're innocent!"     → Pure, simple, conventional choices
Score 9-12:  "Pretty Likable"       → Balanced, mainstream preferences
Score 13-16: "You're...strange!!"   → Quirky, unconventional mix
Score 17+:   "You're so bad!!"      → Extreme, intense preferences
```

---

## Modification Guide

### Common Customization Tasks

#### Change App Name

**Android:**
1. Open `android/app/src/main/AndroidManifest.xml`
2. Change `android:label="QuizApp Preliminary"` (line 4)

**iOS:**
1. Open `ios/Runner/Info.plist`
2. Change `<string>QuizApp Preliminary</string>` under `CFBundleName` (line 16)

**Launcher Name (via pubspec.yaml):**
```yaml
flutter_launcher_name:
  name: "Your New Name"
```

#### Add New Questions

In `lib/main.dart`, add to `_questions` list (after line 47):

```dart
{
  'questiontext': 'Your new question?',
  'answertext': [
    {'text': 'Answer 1', 'score': 5},
    {'text': 'Answer 2', 'score': 3},
    {'text': 'Answer 3', 'score': 8},
    {'text': 'Answer 4', 'score': 1},
  ],
},
```

#### Modify Result Messages

In `lib/result.dart`, edit the `resultphrase` getter (lines 8-19):

```dart
String get resultphrase {
  if (totalScore <= 10) return "Your message for low scores";
  else if (totalScore <= 15) return "Your message for medium scores";
  else if (totalScore <= 20) return "Your message for high scores";
  else return "Your message for very high scores";
}
```

#### Change Color Scheme

**Answer Buttons** (`lib/answersfile.dart`, lines 13-16):
```dart
color: Colors.yourColor,
textColor: Colors.yourTextColor,
```

**Result Button** (`lib/result.dart`, lines 36-37):
```dart
primary: Colors.yourBackground,
onPrimary: Colors.yourText,
```

**AppBar** (`lib/main.dart`): Add theme to MaterialApp:
```dart
MaterialApp(
  theme: ThemeData(
    primarySwatch: Colors.purple,
  ),
  // ...
)
```

#### Change Question Text Size

In `lib/questionsfile.dart`, line 15:
```dart
style: TextStyle(fontSize: 30),  // Change 25 to desired size
```

#### Add Images to Questions

1. Create `assets/images/` directory
2. Add images
3. Update `pubspec.yaml`:
```yaml
flutter:
  assets:
    - assets/images/
```
4. Modify `questionsfile.dart` to include Image widget

#### Change App Icon

Use `flutter_launcher_icons` package:

1. Add to `pubspec.yaml`:
```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.11.0

flutter_icons:
  android: true
  ios: true
  image_path: "assets/icon/app_icon.png"
```

2. Run: `flutter pub run flutter_launcher_icons`

---

## Development Tasks Completed

### 1. Project Setup & Configuration
- [x] Initialized Flutter project with `flutter create`
- [x] Configured project name in `pubspec.yaml` as `flutter_complete_guide`
- [x] Set up app launcher name as "QuizApp Preliminary" using `flutter_launcher_name`
- [x] Configured Dart SDK version constraint (>=2.16.2 <3.0.0)
- [x] Added `cupertino_icons` dependency for iOS styling options
- [x] Set up `flutter_lints` for code quality

### 2. Architecture Design
- [x] Designed Stateful Parent → Stateless Children architecture
- [x] Created modular component structure with separate files
- [x] Implemented callback-based state management pattern
- [x] Established data flow from parent to children via props

### 3. Core Widget Development

#### MyApp (main.dart)
- [x] Created `StatefulWidget` as application root
- [x] Implemented `_Myappstate` class for state management
- [x] Defined static quiz questions data structure
- [x] Created `_question_index` state variable for tracking progress
- [x] Created `_totalscore` state variable for score accumulation
- [x] Implemented `_answers(int score)` callback for handling answer selection
- [x] Implemented `_updtqindex()` helper for index increment
- [x] Implemented `_resetquiz()` for quiz restart functionality
- [x] Created conditional rendering logic (quiz vs result)
- [x] Set up `MaterialApp` with `Scaffold` and `AppBar`

#### Quiz Widget (quiz.dart)
- [x] Created `StatelessWidget` for quiz container
- [x] Implemented constructor with required parameters
- [x] Built `Column` layout for vertical arrangement
- [x] Integrated `questionsfile` widget for question display
- [x] Implemented dynamic answer mapping with spread operator
- [x] Connected answer callbacks to parent handler

#### Question Widget (questionsfile.dart)
- [x] Created `StatelessWidget` for question display
- [x] Implemented `Container` with full width
- [x] Added 15px margin for spacing
- [x] Styled `Text` widget with 25px font size
- [x] Applied center text alignment

#### Answer Widget (answersfile.dart)
- [x] Created `StatelessWidget` for answer buttons
- [x] Implemented `VoidCallback` for tap handling
- [x] Created full-width `Container` wrapper
- [x] Styled `RaisedButton` with blueGrey background
- [x] Applied white text color

#### Result Widget (result.dart)
- [x] Created `StatelessWidget` for result screen
- [x] Implemented `totalScore` parameter for score display
- [x] Implemented `resetHandler` callback for restart
- [x] Created `resultphrase` getter with conditional logic
- [x] Designed score-to-message mapping algorithm
- [x] Built centered `Column` layout
- [x] Styled result text (35px, bold)
- [x] Created `ElevatedButton` with orange/cyan styling

### 4. Quiz Content Creation
- [x] Designed 3 personality-style questions
- [x] Created 4 answer options per question
- [x] Assigned score values to each answer (1-11 range)
- [x] Balanced scoring for varied personality outcomes
- [x] Wrote 4 personality result messages

### 5. State Management Implementation
- [x] Implemented `setState()` for reactive UI updates
- [x] Created unidirectional data flow pattern
- [x] Passed callbacks down to child widgets
- [x] Managed quiz progression through index tracking
- [x] Implemented score accumulation logic

### 6. Platform Configuration

#### Android
- [x] Configured `AndroidManifest.xml` with app settings
- [x] Set up launch theme and normal theme
- [x] Created light/dark mode style configurations
- [x] Configured activity settings (orientation, keyboard handling)
- [x] Set up Gradle build configuration

#### iOS
- [x] Configured `Info.plist` with app metadata
- [x] Set up supported interface orientations
- [x] Created `AppDelegate.swift` entry point
- [x] Configured launch screen storyboard reference

### 7. Asset Configuration
- [x] Default Flutter launcher icons (Android - 5 densities)
- [x] Default Flutter launcher icons (iOS - 16 sizes)
- [x] Default launch screen configuration
- [x] Material Design enabled

### 8. Code Organization
- [x] Separated concerns into individual files
- [x] Used consistent import patterns
- [x] Applied Dart naming conventions (with some variations)
- [x] Added debug print statements for development

---

## Known Issues & Technical Debt

### Deprecated APIs
| Issue | Location | Fix |
|-------|----------|-----|
| `RaisedButton` deprecated | `lib/answersfile.dart:13` | Replace with `ElevatedButton` |
| `primary`/`onPrimary` deprecated | `lib/result.dart:36-37` | Use `backgroundColor`/`foregroundColor` |

### Unused Imports
| File | Import | Action |
|------|--------|--------|
| `lib/answersfile.dart:1` | `dart:ffi` | Remove - not used |
| `lib/main.dart:1` | `cupertino.dart` | Optional - not actively used |
| `lib/main.dart:3,7` | Duplicate `result.dart` | Remove duplicate |

### Naming Conventions
| Current | Recommended | Location |
|---------|-------------|----------|
| `quiz` | `Quiz` | Class name should be PascalCase |
| `questionsfile` | `QuestionDisplay` | Class name should be PascalCase |
| `result` | `Result` | Class name should be PascalCase |
| `_question_index` | `_questionIndex` | Use camelCase for variables |
| `_totalscore` | `_totalScore` | Use camelCase for variables |
| `selecthandler` | `selectHandler` | Use camelCase for variables |
| `anstxt` | `answerText` | Use descriptive camelCase |

### Test Coverage
- Widget test file (`test/widget_test.dart`) contains default counter test
- Does NOT test actual quiz functionality
- Needs complete rewrite for quiz components

### Code Quality
| Issue | Location | Description |
|-------|----------|-------------|
| TODO comment | `lib/main.dart:14` | Incomplete TODO in createState |
| Debug prints | `lib/main.dart:61,67,71,73` | Remove in production |
| No error handling | Throughout | Add try-catch for edge cases |
| Hardcoded strings | Throughout | Consider localization |

### Accessibility
- No semantic labels on buttons
- No screen reader considerations
- Fixed text sizes (not responsive)

---

## Commands Reference

### Development Commands

```bash
# Get dependencies
flutter pub get

# Run app in debug mode
flutter run

# Run on specific device
flutter run -d <device_id>

# Hot reload (while running)
r

# Hot restart (while running)
R

# Build APK (Android)
flutter build apk

# Build App Bundle (Android)
flutter build appbundle

# Build IPA (iOS)
flutter build ios

# Run tests
flutter test

# Analyze code
flutter analyze

# Format code
dart format lib/

# Generate launcher icons (if configured)
flutter pub run flutter_launcher_icons

# Update launcher name
flutter pub run flutter_launcher_name
```

### Debug Commands

```bash
# Run with verbose logging
flutter run -v

# Check Flutter installation
flutter doctor

# List connected devices
flutter devices

# Clean build
flutter clean && flutter pub get
```

---

## File Quick Reference

| Task | File | Lines |
|------|------|-------|
| Add questions | `lib/main.dart` | 20-48 |
| Change result messages | `lib/result.dart` | 10-17 |
| Modify question styling | `lib/questionsfile.dart` | 9-17 |
| Modify answer button styling | `lib/answersfile.dart` | 11-19 |
| Modify result styling | `lib/result.dart` | 27-37 |
| Change app title | `lib/main.dart` | 82 |
| Change Android app name | `android/app/src/main/AndroidManifest.xml` | 4 |
| Change iOS app name | `ios/Runner/Info.plist` | 16 |
| Add dependencies | `pubspec.yaml` | 29-36 |
| Configure linting | `analysis_options.yaml` | All |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0+1 | Initial | Initial quiz implementation with 3 questions |

---

*Documentation generated for future reference. Last updated: December 2024*
