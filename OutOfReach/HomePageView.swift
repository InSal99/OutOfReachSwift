//
//  HomePageView.swift
//  asdfghjkl
//
//  Created by Intan Saliya Utomo on 25/05/23.
//

import SwiftUI
import Combine

struct HomePageView: View {
    var body: some View {
        @EnvironmentObject var countDownObject: CountDownObject
        NavigationView {
            ZStack {
                Rectangle()
                    .foregroundColor(Color("DarkRed"))
                Rectangle()
                    .fill(RadialGradient(colors: [.clear, .black], center: .center, startRadius: 0, endRadius: 600))
                    .opacity(0.7)
                    .ignoresSafeArea()
                VStack {
                    Image("HalfSlenderman")
                        .resizable()
                        .frame(width: 400, height: 400)
                        .padding(.top, 80)
                    Spacer()
                }
                VStack {
                    Spacer()
                    ZStack (alignment: .center){
                        RoundedRectangle(cornerRadius: 70)
                            .frame(height: 500)
                            .offset(y: 130)
                            .foregroundColor(Color("DarkRed"))
                        RoundedRectangle(cornerRadius: 70)
                            .frame(height: 500)
                            .offset(y: 130)
                            .foregroundColor(.red)
                            .opacity(0.3)
                        VStack {
                            Image("TextLogo")
                                .resizable()
                                .frame(width: 250, height: 110)
                                .padding(.top, 170)
                                .padding(.bottom, 40)
                            NavigationLink {
                                CameraView()
                            } label: {
                                PrimaryButton(buttonText: "START GAME", paddingNumber: 101)
                            }
                            NavigationLink {
                                HowToPlayView()
                            } label: {
                                SecondaryButton(buttonText: "HOW TO PLAY", paddingNumber: 92)
                                    .padding(.bottom, 16)
                            }

                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
        .navigationViewStyle(.stack)
        .navigationBarBackButtonHidden()
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
