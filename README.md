# MDReader

A fast, lightweight markdown file viewer for macOS. Open and read `.md` files with rich formatting — nothing more, nothing less.

MDReader is a **read-only** viewer built with SwiftUI. No editing, no bloat. Just open a markdown file and read it.

## Features

- Open `.md` files from the system file picker or by double-clicking
- Rich markdown rendering (headings, lists, code blocks, links, images, tables, etc.)
- Light / Dark / System appearance modes
- Adjustable text size with persistence
- Print support
- Native macOS menu bar

## Keyboard Shortcuts

| Action | Shortcut |
|--------|----------|
| Open file | Cmd O |
| Increase font size | Cmd + |
| Decrease font size | Cmd - |
| Reset font to default | Cmd 0 |
| Print document | Cmd P |

## Installation

### Homebrew (recommended)

```bash
brew tap HassanAlsheikh/tap
brew install --cask mdreader
```

### Direct Download

Download the latest `MDReader.dmg` from [GitHub Releases](https://github.com/HassanAlsheikh/MDReader/releases), open it, and drag MDReader into your Applications folder.

### Gatekeeper Notice

The app is not notarized with Apple, so macOS may show "Apple could not verify" on first launch. To fix this, run:

```bash
xattr -cr /Applications/MDReader.app
```

Or right-click the app, select **Open**, and click **Open** in the dialog.

### Building from Source

Requires Xcode 16+ and [XcodeGen](https://github.com/yonaskolb/XcodeGen).

```bash
# Generate Xcode project
xcodegen generate

# Open in Xcode
open MDReader.xcodeproj

# Or build from the command line
xcodebuild -scheme MDReader -configuration Release build
```

## Project Structure

```
MDReader/
├── App/
│   └── MDReaderApp.swift         # Entry point (DocumentGroup)
├── Models/
│   └── MarkdownDocument.swift    # FileDocument conformance
├── ViewModels/
│   └── DocumentViewModel.swift   # Font size, appearance mode
├── Views/
│   ├── DocumentView.swift        # Scrollable markdown rendering + toolbar
│   └── ThemePickerView.swift     # Appearance + font size menu
├── Theme/
│   └── MarkdownTheme+Custom.swift # GitHub-style markdown theme
├── Resources/
│   └── ...
└── Info.plist
```

## Dependencies

- [swift-markdown-ui](https://github.com/gonzalezreal/swift-markdown-ui) — Markdown rendering

## Requirements

- macOS 14.0+
- Xcode 16+

## License

MIT
