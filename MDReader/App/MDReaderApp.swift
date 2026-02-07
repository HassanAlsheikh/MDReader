import SwiftUI

@main
struct MDReaderApp: App {
    var body: some Scene {
        DocumentGroup(viewing: MarkdownDocument.self) { file in
            DocumentView(document: file.document)
        }
        #if os(macOS)
        .commands {
            CommandGroup(replacing: .appInfo) {
                Button("About MDReader") {
                    NSApplication.shared.orderFrontStandardAboutPanel(options: [
                        .applicationName: "MDReader",
                        .applicationVersion: "1.0",
                        .credits: NSAttributedString(
                            string: "Hassan Alsheikh asked Claude to code this idea\n\nVersion 1.0 — 2026",
                            attributes: [
                                .font: NSFont.systemFont(ofSize: 12),
                                .foregroundColor: NSColor.labelColor,
                                .paragraphStyle: {
                                    let style = NSMutableParagraphStyle()
                                    style.alignment = .center
                                    return style
                                }()
                            ]
                        )
                    ])
                }
            }
        }
        #endif
    }
}
