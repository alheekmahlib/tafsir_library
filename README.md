# tafsir_library

<p align="center">
<img src="https://raw.githubusercontent.com/alheekmahlib/data/refs/heads/main/packages/tafsir_library/tafsir_library_banner.png" width="500"/>
</p>


<!-- الصف الأول -->
<p align="center">
  <a href="https://pub.dev/packages/tafsir_library">
    <img alt="pub package" src="https://img.shields.io/pub/v/tafsir_library.svg?color=D6B46A&labelColor=A88B55" />
  </a>
  <a href="https://pub.dev/packages/tafsir_library/score">
    <img alt="pub points" src="https://img.shields.io/pub/points/tafsir_library?color=D6B46A&labelColor=A88B55" />
  </a>
  <a href="https://pub.dev/packages/tafsir_library/score">
    <img alt="likes" src="https://img.shields.io/pub/likes/tafsir_library?color=D6B46A&labelColor=A88B55" />
  </a>
  <a href="https://pub.dev/packages/tafsir_library/score">
    <img alt="Pub Downloads" src="https://img.shields.io/pub/dm/tafsir_library?color=D6B46A&labelColor=A88B55" />
  </a>
  <a href="LICENSE">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-D6B46A.svg?labelColor=A88B55" />
  </a>
</p>

<!-- الصف الثاني -->
<p align="center">
  <a href="https://flutter.dev/">
    <img alt="Web" src="https://img.shields.io/badge/Web-A88B55?logo=google-chrome&logoColor=white" />
  </a>
  <a href="https://flutter.dev/">
    <img alt="Windows" src="https://img.shields.io/badge/Windows-A88B55?logo=Windows&logoColor=white" />
  </a>
  <a href="https://flutter.dev/">
    <img alt="macOS" src="https://img.shields.io/badge/macOS-A88B55?logo=apple&logoColor=white" />
  </a>
  <a href="https://flutter.dev/">
    <img alt="Android" src="https://img.shields.io/badge/Android-A88B55?logo=android&logoColor=white" />
  </a>
  <a href="https://flutter.dev/">
    <img alt="iOS" src="https://img.shields.io/badge/iOS-A88B55?logo=ios&logoStyle=bold&logoColor=white" />
  </a>
  <a href="https://flutter.dev/">
    <img alt="linux" src="https://img.shields.io/badge/linux-A88B55?logo=linux&logoStyle=bold&logoColor=white" />
  </a>
</p>

A Flutter/Dart library for displaying and accessing Tafsir, Translations and Tajweed data with ready-made UI widgets and a direct API facade.

## Features

- Ready UI widget for showing Tafsir with tabs (Tafsir + Translations + Tajweed).
- Direct API access to Tafsir data, translations, and Tajweed info.
- Built-in download management for tafsir/translation sources.
- Custom tafsir sources support.
- Arabic-friendly UI and styling options.

## Installation

Add to your pubspec.yaml:
```yaml
dependencies:
    ...
	tafsir_library: ^1.0.1
```

Then run:

flutter pub get

## Quick Start

### 1) Initialize the library

```dart
Future<void> main() async {
	WidgetsFlutterBinding.ensureInitialized();
	await TafsirLibrary.initialize();
	runApp(
      const MyApp(),
      );
}
```

### 2) Use the ready-made UI widget

```dart
ShowTafsir(
	context: context,
	ayahUQNumber: 2,
	ayahNumber: 2,
	pageIndex: 1,
	isDark: false,
	surahNumber: 1,
)
```

<p align="center">
<img src="https://raw.githubusercontent.com/alheekmahlib/data/refs/heads/main/packages/tafsir_library/tafsir_library_screenshot.png" width="320"/>
</p>

### 3) Direct API usage (without ShowTafsir)

```dart
await TafsirLibrary.fetchData();
final items = await TafsirLibrary.fetchTafsirAyah(ayahUQNumber);
final tafsirText = items.isNotEmpty ? items.first.tafsirText : '';

await TafsirLibrary.fetchTranslate();
final translation = TafsirLibrary.getTranslationText(surahNumber, ayahNumber);

TafsirLibrary.getTafsirFromCurrentTafsir(int ayahUQNumber);
```

## UI Utilities

### Change Tafsir dialog

```dart
TafsirLibrary.changeTafsirDialog(
	tafsirStyle: TafsirStyle.defaults(isDark: false, context: context),
	isDark: false,
	pageNumber: pageIndex + 1,
)
```

### Font size dropdown

```dart
TafsirLibrary.fontSizeDropdown(
	height: 30,
	isDark: false,
	tafsirStyle: TafsirStyle.defaults(isDark: false, context: context),
)
```

## Tajweed

```dart
final isAvailable = TafsirLibrary.isTajweedAvailable;
if (!isAvailable) {
	await TafsirLibrary.downloadTajweed();
}

final info = await TafsirLibrary.getTajweedAyahInfo(
	surahNumber: 1,
	ayahNumber: 2,
);
```

## Sources

- Fonts, Tafsir, and Translations: Quranic Universal Library (QUL) by Tarteel
  - https://qul.tarteel.ai/

- Quran Tajweed data: The Tafsir Center for Quranic Studies
  - https://dev.surahapp.com/api/docs/

## License

MIT