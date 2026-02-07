import MarkdownUI
import SwiftUI

extension MarkdownUI.Theme {
    static func custom(fontSize: CGFloat) -> MarkdownUI.Theme {
        .gitHub.text {
            ForegroundColor(.primary)
            FontSize(fontSize)
        }
    }
}
