//
//  HowToPlayWelcomeView.swift
//  asdfghjkl
//
//  Created by Intan Saliya Utomo on 25/05/23.
//

import SwiftUI

struct HowToPlayView: View {
    
    @EnvironmentObject var viewModel: HowToPlayViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .foregroundColor(Color("DarkRed"))
                Rectangle()
                    .fill(RadialGradient(colors: [.clear, .black], center: .center, startRadius: 0, endRadius: 800))
                    .opacity(0.4)
                VStack {
                    Spacer()
                    Image("\(viewModel.howToPlay[viewModel.currentInstructionIndex].image)")
                        .resizable()
                        .frame(width: 250, height: 250)
                        .padding(.bottom, 16)
                    Text(viewModel.howToPlay[viewModel.currentInstructionIndex].title)
                        .font(.system(size: 32))
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.bottom, 16)
                    Text(viewModel.howToPlay[viewModel.currentInstructionIndex].text)
                        .font(.system(size: 16))
                        .fontWeight(.ultraLight)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.bottom, 16)
                    Spacer()
                    VStack {
                        ProgressBar(value: viewModel.currentInstructionIndex + 1, maximum: viewModel.howToPlay.count + 1)
                            .environmentObject(viewModel)
                    }
                    .padding(.bottom, 24)
                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.endInstruction()
                            if viewModel.isEnd {
                                presentationMode.wrappedValue.dismiss()
                                viewModel.currentInstructionIndex = 0
                            }
                        }, label: {
                            PrimaryButton(buttonText: viewModel.lastBeforeEnd ? "HOME" : "NEXT", paddingNumber: 125)
                        })
                    }
                    .padding(.vertical, 16)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(
            isPresented: .constant(viewModel.isEnd)) {
                HomePageView()
            }
    }
}

struct HowToPlayWelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlayView()
    }
}
