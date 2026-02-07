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
                Button("Increase") {
                    viewModel.fontSize = min(viewModel.fontSize + 2, 32)
                }
                Button("Decrease") {
                    viewModel.fontSize = max(viewModel.fontSize - 2, 10)
                }
                Button("Reset") {
                    viewModel.fontSize = 16
                }
            }
        } label: {
            Label("Display", systemImage: "textformat.size")
        }
    }
}
