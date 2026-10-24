# Campus Event Explorer

**BIM493 – Mobile Programming I | Assignment #1 | 2026–2027**

Campus Event Explorer is a Flutter mobile application that helps students discover campus events, save favorites, and manage event participation. It works offline using fictional event data stored locally in Dart code.

## Team and Contributions

| Full Name | Student ID | Contribution |
|---|---|---|
| Pelin Kaynarpınar | 40042862792 | Joint development of the event data, interface, search and category filters, favorites, participation features, testing, and documentation. |
| Zeynep Zişan Beylen | 20203124082 | Joint development of the event data, interface, search and category filters, favorites, participation features, testing, and documentation. |

The project was developed and reviewed as a team. Both members contributed collaboratively to application functionality, interface development, testing, and final documentation.

## Requirements and Development Environment

- **Framework:** Flutter 3.47.6 (Stable)
- **Language:** Dart 3.13.5
- **IDE:** Visual Studio Code
- **Android testing device:** Pixel 7 Android Emulator
- **Architecture:** Local mock data and `setState` for in-session state updates
- **Network/backend:** Not required

### Flutter version output

Recorded on the development computer on October 24, 2026:

```text
Flutter 3.47.6 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 5fc346839b (3 weeks ago) • 2026-09-30 15:02:49 -0700
Engine • hash b8c8d3d8d5d0095127057f8a29ca8cc53da2167c (revision 692136cb65) (24 days ago) • 2026-09-30 00:56:59.000Z
Tools • Dart 3.13.5 • DevTools 2.60.0
```

## Main Features

- **Explore:** Eight fictional campus events in three categories: Technology, Arts, and Sports.
- **Event information:** Each event has a unique ID, title, category, date/time, venue, description, local image, total capacity, and available places.
- **Search and filters:** Case-insensitive and trimmed title search combined with category filters; visible matching-event count, clear-search action, and informative empty states. Filters are shared across all three tabs.
- **Favorites:** Add or remove favorites from cards and details; view saved events in the Favorites tab.
- **Event details:** Separate detail screen with all event information; double-tap the image for an enlarged image viewer.
- **Participation:** Join or cancel using Yes/No confirmation dialogs. Joining decreases availability once; cancellation restores one place. Duplicate joins are prevented.
- **Capacity:** Fully booked events cannot be joined. A participant who takes the last available place can still cancel.
- **My Events:** Lists joined events and shows their total count.
- **Offline support:** Event records, favorites, and participation state are managed locally without a server or database.

## Installation and Running

Install Flutter **3.47.6 Stable** and the Android SDK. Then open a terminal in the project directory (the folder containing `pubspec.yaml`):

```powershell
flutter --version
flutter pub get
flutter analyze
flutter test
flutter devices
flutter run -d emulator-5554
```

Replace `emulator-5554` with the connected device ID shown by `flutter devices` if it differs. For quick UI checks, use `flutter run -d chrome`.

If the platform folders are missing in a source-only copy, run `flutter create --project-name campus_event_explorer .` before `flutter pub get`.

## Project Structure

```text
campus_event_explorer/
├── lib/
│   ├── main.dart
│   ├── data/mock_events.dart
│   ├── models/campus_event.dart
│   ├── screens/
│   ├── utils/event_format.dart
│   └── widgets/event_card.dart
├── assets/
│   ├── images/
│   └── fonts/
├── android/
├── test/
├── screenshots/
├── licenses/
├── pubspec.yaml
├── pubspec.lock
└── README.md
```

## Screenshots

The following screenshots were captured from the running application:

1. `screenshots/01_explore.png` — Explore screen with event cards.
2. `screenshots/02_details.png` — Event information and participation controls.
3. `screenshots/03_favorites.png` — Favorited events.
4. `screenshots/04_my_events.png` — Joined events.

## Manual Test Checklist

- [x] Explore displays eight events across three categories.
- [x] Search, category selection, clear-search, and empty results were checked.
- [x] Event details and double-tap image viewer were checked.
- [x] Favoriting and removing a favorite updates the relevant tabs.
- [x] A full event (`Campus Art Night`) cannot be joined.
- [x] Joining an event with one remaining place (`3x3 Basketball Tournament`) decreases availability to zero.
- [x] Join and cancellation confirmation dialogs were checked, including the No option.
- [x] Cancelling participation restores one available place and removes the event from My Events.
- [x] Joined-event counter and navigation between Explore, Favorites, and My Events were checked.
- [x] Application interface was checked in Chrome and on a Pixel 7 Android emulator.

## Assets and Credits

- **Event images:** Original programmatically created category illustrations (`technology.png`, `arts.png`, and `sports.png`) included in `assets/images/`. No third-party photographs are used.
- **Lato font:** Designed by Łukasz Dziedzic, distributed under the **SIL Open Font License 1.1**. Font license is included at `licenses/LATO_LICENSE.txt`. The project uses locally bundled Lato font files declared in `pubspec.yaml`.
- **Material icons:** Provided through Flutter's Material library.

## Known Limitations

Favorites, participation, and available-place changes are maintained only for the current app session. They reset when the app is restarted, as permitted by the assignment. The app uses fictional data and does not include user accounts, backend services, real ticket purchases, or a database.

## Submission

The submitted archive contains Flutter source files, platform/configuration folders, `pubspec.yaml`, `pubspec.lock`, locally bundled assets and fonts, this README, test source files, and the four screenshots. Generated folders such as `build/` and `.dart_tool/` are excluded.
