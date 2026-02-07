import SwiftUI

struct ThemePickerView: View {
    @ObservedObject var viewModel: DocumentViewModel

    var body: some View {
        Menu {
            Picker("Appearance", selection: $viewModel.appearanceMode) {
                ForEach(DocumentViewModel.AppearanceMode.allCases, id: \.self) { mode in
                    Text(mode.rawValue).tag(mode)
                }
            }

            Divider()

            Section("Text Size") {
                Button("Increase") { viewModel.increaseFontSize() }
                Button("Decrease") { viewModel.decreaseFontSize() }
                Button("Reset") { viewModel.resetFontSize() }
            }
        } label: {
            Label("Display", systemImage: "textformat.size")
        }
    }
}
