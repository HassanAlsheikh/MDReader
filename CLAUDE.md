# MDReader

A native macOS read-only markdown viewer built with SwiftUI.

## Build Commands

```bash
# Generate Xcode project (requires XcodeGen)
xcodegen generate

# Open in Xcode
open MDReader.xcodeproj

# Build from command line
xcodebuild -project MDReader.xcodeproj -scheme MDReader -configuration Release build

# Create DMG (after release build)
# 1. Archive via Xcode: Product > Archive
# 2. Export .app from Organizer
# 3. Copy .app into staging dir with /Applications symlink
# 4. hdiutil create -volname "MDReader" -srcfolder <staging> -ov -format UDZO ~/Downloads/MDReader.dmg
```

## Architecture

- **MVVM** pattern with SwiftUI
- **DocumentGroup** for native file handling (open, file associations, recent files)
- **MarkdownUI** package (gonzalezreal/swift-markdown-ui) for rendering
- **FileDocument** protocol for markdown file model
- **UserDefaults** for persisting display settings
- macOS 14.0+ / Swift 5.9+

## Project Structure

```
MDReader/
├── App/
│   └── MDReaderApp.swift              # Entry point, DocumentGroup scene, About menu
├── Models/
│   └── MarkdownDocument.swift         # FileDocument model with UTType for markdown
├── ViewModels/
│   └── DocumentViewModel.swift        # ObservableObject: appearance, fontSize, persistence
├── Views/
│   ├── DocumentView.swift             # ScrollView + MarkdownUI rendering + keyboard shortcuts + print
│   └── ThemePickerView.swift          # Menu for appearance mode + text size controls
├── Theme/
│   └── MarkdownTheme+Custom.swift     # MarkdownUI.Theme extension (GitHub base + dynamic font size)
├── Resources/
│   └── Assets.xcassets/               # App icon, accent color
└── Info.plist                         # File associations, UTType declarations
```

## Key Patterns

- Read-only viewer (not an editor) — uses `DocumentGroup(viewing:)`
- File associations via `CFBundleDocumentTypes` + `UTImportedTypeDeclarations` in Info.plist
- Supported extensions: md, markdown, mdown, mkd, mkdn
- Keyboard shortcuts via hidden Button + `.keyboardShortcut()` pattern
- Print via `NSPrintOperation` with `NSTextView`
- Settings persisted with `UserDefaults` (fontSize, appearanceMode)
- Appearance: System / Light / Dark via `.preferredColorScheme()`

## Distribution

- **GitHub repo**: https://github.com/HassanAlsheikh/MDReader
- **Homebrew tap**: https://github.com/HassanAlsheikh/homebrew-tap (`brew tap HassanAlsheikh/tap && brew install --cask mdreader`)
- **GitHub Releases**: DMG attached to releases
- **Not notarized** — users need `xattr -cr /Applications/MDReader.app` or right-click > Open
