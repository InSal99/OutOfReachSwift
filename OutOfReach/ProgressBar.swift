//
//  ProgressBar.swift
//  asdfghjkl
//
//  Created by Intan Saliya Utomo on 26/05/23.
//

import Foundation
import SwiftUI

struct ProgressBar: View {
    var value: Int
    var maximum: Int

    var body: some View {
        Gauge(value: Double(value), in: 0...Double(maximum)) {}
        .gaugeStyle(.accessoryLinearCapacity)
        .accentColor(.black)
        .scaleEffect(CGSize(width: 1, height: 3))
        .animation(.spring(), value: value)
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(value: 1, maximum: 5)
    }
}
