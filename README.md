# Football IQ

**Football IQ** is a Flutter-based football trivia game designed for Android.

The goal is simple: test how well you really know football by identifying players from images, career information, achievements, statistics, and other clues.

## ⚽ Game Concept

Football IQ includes different ways to challenge a player's football knowledge.

### Guess the Player

Identify a footballer from a limited visual clue such as a cropped image, silhouette, or partially revealed picture.

### Career Path

Guess the player from the clubs they have represented throughout their career.

Example:

`Sporting CP → Manchester United → Real Madrid → Juventus → Manchester United → Al Nassr`

### Who Am I?

Players receive clues progressively, such as:

* Nationality
* Position
* Clubs
* Achievements
* Trophies

Guessing with fewer hints gives a better score.

### Guess by Stats

Identify players using information such as goals, appearances, position, nationality, trophies, and shirt number.

### Daily Challenges

A daily football challenge designed to encourage players to return and maintain their streak.

##  Core Features

* Multiple football quiz modes
* Player guessing challenges
* Progressive hint system
* Score and XP system
* Streak tracking
* Player profiles
* Achievements
* Leaderboards
* Quiz completion statistics
* Football-themed animations and effects

##  Progression

Players can improve their Football IQ profile by:

* Completing quizzes
* Maintaining winning streaks
* Earning XP
* Unlocking achievements
* Improving their accuracy
* Climbing leaderboard tiers

##  Built With

* **Flutter**
* **Dart**
* Material Design

The application is currently being developed primarily for **Android**.

## 📁 Project Structure

```text
lib/
├── data/
├── models/
├── screens/
├── state/
├── theme/
├── widgets/
└── main.dart
```

### `data`

Contains temporary/mock football data and quiz generation logic.

### `models`

Contains the application's core data models such as players, questions, achievements, game modes, and leaderboard entries.

### `screens`

Contains the main application screens including home, gameplay, profile, leaderboard, and quiz completion screens.

### `state`

Manages application state and game progress.

### `theme`

Contains the visual theme and styling configuration for Football IQ.

### `widgets`

Contains reusable UI components used throughout the application.

##  Running the Project

Make sure Flutter is installed and an Android device or emulator is available.

Install dependencies:

```bash
flutter pub get
```

Check available devices:

```bash
flutter devices
```

Run the application:

```bash
flutter run
```

##  Target Platform

The current primary target is:

**Android**

Support for additional platforms may be considered later.

##  Development Status

Football IQ is currently under active development.

The current focus is building the core gameplay experience, UI, player data system, quiz modes, progression system, and overall application architecture.

##  Planned Improvements

Future versions may include:

* More football players and questions
* Daily player challenges
* Online leaderboards
* Authentication
* Friend competitions
* Additional quiz modes
* Player image challenges
* Advanced statistics
* Improved animations
* Backend-powered football data

## 📄 License

This project is currently being developed as a personal software project.
