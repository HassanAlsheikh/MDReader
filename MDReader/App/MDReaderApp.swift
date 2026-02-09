import SwiftUI

@main
struct MDReaderApp: App {
    var body: some Scene {
        DocumentGroup(viewing: MarkdownDocument.self) { file in
            DocumentView(document: file.document)
        }
        .commands {
            CommandGroup(replacing: .appInfo) {
                Button("About MDReader") {
                    NSApplication.shared.orderFrontStandardAboutPanel(options: [
                        .applicationName: "MDReader",
                        .applicationVersion: "3.0",
                        .credits: NSAttributedString(
                            string: "Hassan Alsheikh asked Claude to code this idea\n\nVersion 3.0 — 2026",
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
    }
}
