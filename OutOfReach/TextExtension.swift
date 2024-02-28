//
//  FontExtension.swift
//  OutOfReach
//
//  Created by Intan Saliya Utomo on 30/01/24.
//

import Foundation
import SwiftUI

extension Text {
    @ViewBuilder
    func titleStyle() -> some View {
        self.font(.imfell(.regular, size: .body1))
    }
}

extension Font {
    enum FontType: String {
        case regular = "IMFellEnglishSC-Regular"
    }
    
    enum FontSize: CGFloat {
        case heading1 = 48.00
        case heading2 = 36.00
        case heading3 = 32.00
        case body1 = 24.00
        case body2 = 16.00
        case body3 = 20.00
        case label1 = 14.00
        case label2 = 12.00
    }
    
    static func imfell(_ font: FontType, size: FontSize) -> SwiftUI.Font {
        SwiftUI.Font.custom(font.rawValue, size: size.rawValue)
    }
}
