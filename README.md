# MDReader

A fast, lightweight markdown file viewer. Open and read `.md` files with rich formatting — nothing more, nothing less.

MDReader is a **read-only** viewer. No editing, no bloat. Just open a markdown file and read it.

## Supported Platforms

| Platform | Status |
|----------|--------|
| macOS 14+ | Available |
| iOS | Available (build from source) |
| Android | Available (build from source) |
| Linux | Available (build from source) |
| Windows | Available (build from source) |
| AppGallery (Huawei/Honor) | Planned |

## Features

- Open `.md` files from the system file picker or by double-clicking
- Rich markdown rendering (headings, lists, code blocks, links, images, tables, etc.)
- Light / Dark / System appearance modes
- Adjustable text size with persistence
- Print support
- Native macOS menu bar with File, View, and About
- Cross-platform keyboard shortcuts
- Native performance on each platform

## Keyboard Shortcuts

| Action | macOS | Linux / Windows |
|--------|-------|-----------------|
| Open file | Cmd O | Ctrl O |
| Increase font size | Cmd + | Ctrl + |
| Decrease font size | Cmd - | Ctrl - |
| Reset font to default | Cmd 0 | Ctrl 0 |
| Print document | Cmd P | Ctrl P |

## Installation

### Homebrew (macOS — recommended)

```bash
brew tap HassanAlsheikh/tap
brew install --cask mdreader
```

### Direct Download (macOS)

Download the latest `MDReader.dmg` from [GitHub Releases](https://github.com/HassanAlsheikh/MDReader/releases), open it, and drag MDReader into your Applications folder.

### macOS Gatekeeper Notice

The app is not notarized with Apple, so macOS may show "Apple could not verify" on first launch. To fix this, run:

```bash
xattr -cr /Applications/MDReader.app
```

Or right-click the app, select **Open**, and click **Open** in the dialog.

### Building from Source

Requires [Flutter](https://flutter.dev/docs/get-started/install) 3.x+.

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
```

## Project Structure

```
mdreader_flutter/
├── lib/
│   ├── main.dart                  # Entry point with window init
│   ├── app.dart                   # MaterialApp with theme switching
│   ├── models/                    # MarkdownDocument data class
│   ├── services/                  # File picker, print service
│   ├── view_models/               # DisplaySettings (ChangeNotifier)
│   ├── views/                     # Home view, document view
│   ├── widgets/                   # Markdown renderer, theme picker
│   ├── theme/                     # App theme, markdown theme
│   └── platform/                  # Desktop menu, keyboard shortcuts, window config
```

## Dependencies

- [markdown_widget](https://pub.dev/packages/markdown_widget) — Markdown rendering with syntax highlighting
- [file_picker](https://pub.dev/packages/file_picker) — Cross-platform file open dialog
- [window_manager](https://pub.dev/packages/window_manager) — Desktop window management
- [printing](https://pub.dev/packages/printing) — Print support
- [shared_preferences](https://pub.dev/packages/shared_preferences) — Persist display settings
- [url_launcher](https://pub.dev/packages/url_launcher) — Open links in browser

## License

MIT
