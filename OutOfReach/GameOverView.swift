//
//  GameOver.swift
//  asdfghjkl
//
//  Created by Intan Saliya Utomo on 22/05/23.
//

import SwiftUI

struct GameOver: View {
    
    @EnvironmentObject var countDownObject: CountDownObject
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .foregroundColor(Color("DarkRed"))
                Rectangle()
                    .fill(RadialGradient(colors: [.clear, .black], center: .center, startRadius: 0, endRadius: 800))
                    .opacity(0.4)
                VStack {
                    Text("GAME OVER!")
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .font(.system(size: 44))
                        .padding(.bottom, 40)
                        .padding(.top, 200)
                    Text("You had survived for")
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .font(.system(size: 24))
                    Text("\(countDownObject.countDownCGenerator(countDown: countDownObject.countDown, iterateCount: countDownObject.iterateCount)) sec")
                        .font(.system(size: 44))
                        .fontWeight(.heavy)
                    Spacer()
                    NavigationLink {
                        HomePageView()
                    } label: {
                        PrimaryButton(buttonText: "PLAY AGAIN", paddingNumber: 100)
                            .padding(.bottom, 32)
                    }
                }
            }
            .ignoresSafeArea()
            .onDisappear {
                countDownObject.iterateCount += 1
                print("haloo \(countDownObject.iterateCount)")
            }
        }
        .navigationViewStyle(.stack)
        .navigationBarBackButtonHidden()
    }
}

struct GameOver_Previews: PreviewProvider {
    static var previews: some View {
        GameOver()
    }
}
