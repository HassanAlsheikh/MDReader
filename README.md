# MDReader

A fast, lightweight markdown file viewer. Open and read `.md` files with rich formatting — nothing more, nothing less.

MDReader is a **read-only** viewer. No editing, no bloat. Just open a markdown file and read it.

## Supported Platforms

| Platform | Status |
|----------|--------|
| macOS 14+ | Available |
| iOS 17+ | Available |
| Android | Planned |
| Linux | Planned |
| Windows | Planned |
| AppGallery (Huawei/Honor) | Planned |

## Features

- Open `.md` files from the system file picker
- Rich markdown rendering (headings, lists, code blocks, links, images, tables, etc.)
- Light / Dark / System appearance modes
- Adjustable text size
- Native performance on each platform

## Building from Source

Requires [XcodeGen](https://github.com/yonaskolb/XcodeGen) and Xcode 16+.

```bash
# Generate the Xcode project
xcodegen generate

# Build for macOS
xcodebuild -scheme MDReader_macOS -project MDReader.xcodeproj -destination 'platform=macOS' build

# Build for iOS Simulator
xcodebuild -scheme MDReader_iOS -project MDReader.xcodeproj -destination 'platform=iOS Simulator,name=iPhone 16' build
```

## Project Structure

```
MDReader/
├── project.yml              # XcodeGen project spec
├── MDReader/
│   ├── App/                 # App entry point (DocumentGroup)
│   ├── Models/              # FileDocument conformance for .md files
│   ├── Views/               # Document view, theme picker
│   ├── ViewModels/          # Display preferences (theme, font size)
│   ├── Theme/               # Custom MarkdownUI theme
│   └── Resources/           # Asset catalog
```

## Dependencies

- [MarkdownUI](https://github.com/gonzalezreal/swift-markdown-ui) — SwiftUI markdown rendering

## License

MIT
