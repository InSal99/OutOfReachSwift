//
//  SecondaryButton.swift
//  asdfghjkl
//
//  Created by Intan Saliya Utomo on 25/05/23.
//

import SwiftUI

struct SecondaryButton: View {
    var buttonText: String = "Button Text"
    var paddingNumber: CGFloat = 0
    var body: some View {
        VStack {
            Text(buttonText)
                .font(.system(size: 22))
                .foregroundColor(.black)
                .fontWeight(.heavy)
                .padding()
                .padding(.horizontal, paddingNumber)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 5)
                )
            .padding()
        }
    }
}

struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryButton()
    }
}
