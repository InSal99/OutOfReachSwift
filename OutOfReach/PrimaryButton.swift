//
//  BackToHomeButton.swift
//  asdfghjkl
//
//  Created by Intan Saliya Utomo on 24/05/23.
//

import SwiftUI

struct PrimaryButton: View {
    var buttonText: String = "Button Text"
    var paddingNumber: CGFloat = 0
    var body: some View {
        VStack {
            Text(buttonText)
                .font(.system(size: 22))
                .foregroundColor(.white)
                .fontWeight(.heavy)
                .padding(.horizontal, paddingNumber)
        }
        .padding()
        .background(.black)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
            .stroke(Color.black, lineWidth: 5)
        )
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton()
    }
}
