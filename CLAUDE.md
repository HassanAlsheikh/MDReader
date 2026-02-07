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
```

## Architecture

- **MVVM** pattern with SwiftUI
- **Document-based** app using `DocumentGroup` and `FileDocument`
- **MarkdownUI** (gonzalezreal/swift-markdown-ui) for rendering

## Project Structure

- `project.yml` - XcodeGen spec (generates `.xcodeproj`)
- `MDReader/App/` - App entry point with DocumentGroup
- `MDReader/Models/` - MarkdownDocument (FileDocument conformance)
- `MDReader/Views/` - DocumentView, ThemePickerView
- `MDReader/ViewModels/` - DocumentViewModel (display preferences)
- `MDReader/Theme/` - Custom MarkdownUI theme extensions

## Key Patterns

- Read-only viewer (not an editor)
- UTType `.markdown` defined as imported type (`net.daringfireball.markdown`)
- XcodeGen creates separate schemes: `MDReader_iOS` and `MDReader_macOS`
- Deployment targets: iOS 17.0, macOS 14.0
