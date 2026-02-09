import SwiftUI
import MarkdownUI

struct DocumentView: View {
    let document: MarkdownDocument
    @StateObject private var viewModel = DocumentViewModel()

    var body: some View {
        ScrollView {
            Markdown(document.text)
                .markdownTheme(viewModel.currentTheme)
                .textSelection(.enabled)
                .padding()
        }
        .frame(minWidth: 300, minHeight: 400)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                ThemePickerView(viewModel: viewModel)
            }
        }
        .preferredColorScheme(viewModel.colorSchemeOverride)
        .keyboardShortcut(commands: viewModel)
        .keyboardShortcut("p", modifiers: .command) { printDocument() }
    }

    private func printDocument() {
        let printView = NSTextView(frame: NSRect(x: 0, y: 0, width: 612, height: 792))
        printView.string = document.text
        printView.font = NSFont.systemFont(ofSize: viewModel.fontSize)
        let printOperation = NSPrintOperation(view: printView)
        printOperation.runModal(for: NSApp.keyWindow ?? NSWindow(), delegate: nil, didRun: nil, contextInfo: nil)
    }
}

private struct KeyboardShortcutsModifier: ViewModifier {
    @ObservedObject var viewModel: DocumentViewModel

    func body(content: Content) -> some View {
        content
            .keyboardShortcut("+", modifiers: .command) { viewModel.increaseFontSize() }
            .keyboardShortcut("=", modifiers: .command) { viewModel.increaseFontSize() }
            .keyboardShortcut("-", modifiers: .command) { viewModel.decreaseFontSize() }
            .keyboardShortcut("0", modifiers: .command) { viewModel.resetFontSize() }
    }
}

private extension View {
    func keyboardShortcut(_ key: KeyEquivalent, modifiers: EventModifiers, action: @escaping () -> Void) -> some View {
        self.background(
            Button("") { action() }
                .keyboardShortcut(key, modifiers: modifiers)
                .hidden()
        )
    }

    func keyboardShortcut(commands viewModel: DocumentViewModel) -> some View {
        modifier(KeyboardShortcutsModifier(viewModel: viewModel))
    }
}
