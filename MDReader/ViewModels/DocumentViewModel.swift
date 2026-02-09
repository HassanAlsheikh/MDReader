import SwiftUI
import MarkdownUI

final class DocumentViewModel: ObservableObject {
    enum AppearanceMode: String, CaseIterable {
        case system = "System"
        case light = "Light"
        case dark = "Dark"
    }

    static let defaultFontSize: CGFloat = 16

    @Published var appearanceMode: AppearanceMode = .system {
        didSet { UserDefaults.standard.set(appearanceMode.rawValue, forKey: "appearanceMode") }
    }
    @Published var fontSize: CGFloat = DocumentViewModel.defaultFontSize {
        didSet { UserDefaults.standard.set(fontSize, forKey: "fontSize") }
    }

    init() {
        let savedSize = UserDefaults.standard.double(forKey: "fontSize")
        if savedSize > 0 {
            self.fontSize = savedSize
        }
        if let raw = UserDefaults.standard.string(forKey: "appearanceMode"),
           let mode = AppearanceMode(rawValue: raw) {
            self.appearanceMode = mode
        }
    }

    func increaseFontSize() {
        fontSize = min(fontSize + 2, 32)
    }

    func decreaseFontSize() {
        fontSize = max(fontSize - 2, 10)
    }

    func resetFontSize() {
        fontSize = Self.defaultFontSize
    }

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
