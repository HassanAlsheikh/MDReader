# MDReader

A fast, lightweight markdown file viewer for macOS. Open and read `.md` files with rich formatting — nothing more, nothing less.

MDReader is a **read-only** viewer. No editing, no bloat. Just open a markdown file and read it.

## Features

- Open `.md` files from Finder or the system file picker
- Rich markdown rendering (headings, lists, code blocks, links, images, tables, etc.)
- Light / Dark / System appearance modes with persistence
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

### macOS Gatekeeper Notice

The app is not notarized with Apple, so macOS may show "Apple could not verify" on first launch. To fix this, run:

```bash
xattr -cr /Applications/MDReader.app
```

Or right-click the app, select **Open**, and click **Open** in the dialog.

### Building from Source

Requires [XcodeGen](https://github.com/yonaskolb/XcodeGen) and Xcode 16+.

```bash
xcodegen generate
open MDReader.xcodeproj
```

Build and run from Xcode (Cmd R), or build a release archive via Product > Archive.

## Project Structure

```
MDReader/
├── App/
│   └── MDReaderApp.swift              # Entry point, DocumentGroup, About menu
├── Models/
│   └── MarkdownDocument.swift         # FileDocument model (UTType, read/write)
├── ViewModels/
│   └── DocumentViewModel.swift        # State: appearance, font size, persistence
├── Views/
│   ├── DocumentView.swift             # Scrollable markdown rendering + shortcuts
│   └── ThemePickerView.swift          # Appearance & font size menu
├── Theme/
│   └── MarkdownTheme+Custom.swift     # MarkdownUI GitHub theme extension
└── Resources/
    └── Assets.xcassets/               # App icon, accent color
```

## Dependencies

- [MarkdownUI](https://github.com/gonzalezreal/swift-markdown-ui) — Markdown rendering with GitHub-style theme

## Requirements

- macOS 14.0+

## License

MIT
