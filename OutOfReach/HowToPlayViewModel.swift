//
//  HowToPlayViewModel.swift
//  asdfghjkl
//
//  Created by Intan Saliya Utomo on 26/05/23.
//

import Foundation

class HowToPlayViewModel: ObservableObject {
    @Published var howToPlay: [Instruction]
    @Published var currentInstructionIndex: Int = 0
    @Published var isEnd: Bool = false
    @Published var lastBeforeEnd: Bool = false
    
    init() {
        self.howToPlay = instructions
    }
    
    func endInstruction() {
        if currentInstructionIndex < instructions.count - 1 {
            isEnd = false
            currentInstructionIndex += 1
            if currentInstructionIndex == instructions.count - 1 {
                lastBeforeEnd = true
            }
        } else {
            isEnd = true
            lastBeforeEnd = false
        }
    }
}

