import SwiftUI
import MarkdownUI

final class DocumentViewModel: ObservableObject {
    enum AppearanceMode: String, CaseIterable {
        case system = "System"
        case light = "Light"
        case dark = "Dark"
    }

    @Published var appearanceMode: AppearanceMode = .system
    @Published var fontSize: CGFloat = 16

    var colorSchemeOverride: ColorScheme? {
        switch appearanceMode {
        case .system: nil
        case .light: .light
        case .dark: .dark
        }
    }

    var currentTheme: MarkdownUI.Theme {
        .custom(fontSize: fontSize)
    }
}
