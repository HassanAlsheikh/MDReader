# MDReader

A SwiftUI multiplatform markdown viewer app for iOS and macOS.

## Build Commands

```bash
# Generate Xcode project (run after modifying project.yml)
xcodegen generate

# Build macOS
xcodebuild -scheme MDReader_macOS -project MDReader.xcodeproj -destination 'platform=macOS' build

# Build iOS Simulator
xcodebuild -scheme MDReader_iOS -project MDReader.xcodeproj -destination 'platform=iOS Simulator,name=iPhone 16' build

# Release build for macOS
xcodebuild -scheme MDReader_macOS -project MDReader.xcodeproj -destination 'platform=macOS' -configuration Release build

# Create DMG (after release build)
# 1. Copy .app from DerivedData Release folder into a staging dir with /Applications symlink
# 2. hdiutil create -volname "MDReader" -srcfolder <staging> -ov -format UDZO ~/Downloads/MDReader.dmg
```

## Architecture

- **MVVM** pattern with SwiftUI
- **Document-based** app using `DocumentGroup` and `FileDocument`
- **MarkdownUI** (gonzalezreal/swift-markdown-ui) for rendering

## Project Structure

- `project.yml` - XcodeGen spec (generates `.xcodeproj`)
- `MDReader/App/MDReaderApp.swift` - App entry point with DocumentGroup + custom About window (macOS)
- `MDReader/Models/MarkdownDocument.swift` - FileDocument conformance + UTType.markdown extension
- `MDReader/Views/DocumentView.swift` - Main view with MarkdownUI rendering + keyboard shortcuts
- `MDReader/Views/ThemePickerView.swift` - Appearance mode and text size menu
- `MDReader/ViewModels/DocumentViewModel.swift` - Display preferences (theme, font size)
- `MDReader/Theme/MarkdownTheme+Custom.swift` - Custom MarkdownUI theme based on .gitHub

## Key Patterns

- Read-only viewer (not an editor)
- UTType `.markdown` defined as imported type (`net.daringfireball.markdown`)
- XcodeGen creates separate schemes: `MDReader_iOS` and `MDReader_macOS`
- Deployment targets: iOS 17.0, macOS 14.0
- Keyboard shortcuts via hidden Button views with `.keyboardShortcut()`
- Cmd+/= increase font, Cmd- decrease, Cmd0 reset, CmdP print (macOS)

## Distribution

- **GitHub repo**: https://github.com/HassanAlsheikh/MDReader
- **Homebrew tap**: https://github.com/HassanAlsheikh/homebrew-tap (`brew tap HassanAlsheikh/tap && brew install --cask mdreader`)
- **GitHub Releases**: DMG attached to v1.0.0
- **Not notarized** — users need `xattr -cr /Applications/MDReader.app` or right-click > Open
- Notarization requires Apple Developer Program ($99/year) — decided to skip for now

## Future Plans

- Android, Linux, Windows, AppGallery (Huawei/Honor) support planned
- App is designed as a quick read-only MD viewer across all platforms
