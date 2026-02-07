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
    }
}
