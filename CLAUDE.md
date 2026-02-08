# MDReader

A cross-platform read-only markdown viewer built with Flutter, targeting macOS, iOS, Android, Linux, and Windows.

## Build Commands

```bash
cd mdreader_flutter

# macOS
flutter build macos

# iOS
flutter build ios --no-codesign

# Android
flutter build apk

# Linux
flutter build linux

# Windows
flutter build windows

# Analyze
flutter analyze

# Test
flutter test

# Create DMG (after macOS release build)
# 1. Copy .app from build/macos/Build/Products/Release/ into staging dir with /Applications symlink
# 2. hdiutil create -volname "MDReader" -srcfolder <staging> -ov -format UDZO ~/Downloads/MDReader.dmg
```

## Architecture

- **MVVM** pattern with Flutter
- **ChangeNotifier** + **ListenableBuilder** for state (no Provider/Riverpod)
- **markdown_widget** package for rendering
- **file_picker** for cross-platform file open
- **window_manager** for desktop window management
- **PlatformMenuBar** for macOS native menu

## Project Structure

```
mdreader_flutter/lib/
├── main.dart                         # Entry point, window init, runApp
├── app.dart                          # MaterialApp with theme switching
├── models/
│   └── markdown_document.dart        # Simple data class (text, fileName, filePath)
├── services/
│   ├── file_service.dart             # File picking + reading
│   └── print_service.dart            # Print via printing package
├── view_models/
│   └── display_settings.dart         # ChangeNotifier: fontSize, themeMode, persistence
├── views/
│   ├── home_view.dart                # Empty state / file picker landing
│   └── document_view.dart            # Scrollable markdown rendering + toolbar
├── widgets/
│   ├── markdown_renderer.dart        # markdown_widget wrapper with GitHub-style config
│   └── theme_picker.dart             # PopupMenuButton for appearance + font size
├── theme/
│   ├── app_theme.dart                # Light/dark MaterialTheme definitions
│   └── markdown_theme.dart           # GitHub-style MarkdownConfig
└── platform/
    ├── desktop_menu.dart             # PlatformMenuBar (macOS)
    ├── keyboard_shortcuts.dart       # Shortcuts + Actions + Intents
    └── window_config.dart            # window_manager init (size, title, min size)
```

## Key Patterns

- Read-only viewer (not an editor)
- File associations configured for all 5 platforms
- macOS entitlements: files.user-selected.read-only, network.client, print
- Keyboard shortcuts: Cmd/Ctrl + O (open), +/= (zoom in), - (zoom out), 0 (reset), P (print)
- PlatformMenuBar only on macOS (guarded with Platform.isMacOS)
- markdown_widget API: ListMarker is a typedef, link taps via LinkConfig(onTap:)

## Distribution

- **GitHub repo**: https://github.com/HassanAlsheikh/MDReader
- **Homebrew tap**: https://github.com/HassanAlsheikh/homebrew-tap (`brew tap HassanAlsheikh/tap && brew install --cask mdreader`)
- **GitHub Releases**: DMG attached to releases
- **Not notarized** — users need `xattr -cr /Applications/MDReader.app` or right-click > Open

## Legacy SwiftUI Version (v1.0.0)

The original SwiftUI codebase remains at the repo root (project.yml, MDReader/, MDReader.xcodeproj) for reference. The Flutter version in `mdreader_flutter/` is the active codebase from v2.0.0 onward.
