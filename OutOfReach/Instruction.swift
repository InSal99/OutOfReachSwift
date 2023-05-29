//
//  Instruction.swift
//  asdfghjkl
//
//  Created by Intan Saliya Utomo on 26/05/23.
//

import Foundation

struct Instruction: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let text: String
}

let instructions = [
    Instruction(
        image: "Tentacles",
        title: "WELCOME TO THE DARK",
        text: "Get ready for a thrilling adventure where you'll be escaping the enigmatic Slenderman!"
    ),
    Instruction(
        image: "",
        title: "GOAL",
        text: "Your mission is to avoid Slenderman's reach at all costs. Your survivability is the key point!"
    ),
    Instruction(
        image: "",
        title: "STAY ALERT!",
        text: "Slenderman loves to keep you on edge, lurking in the darkness and shifting like a shadow. so keep your distance from Slanderman."
    ),
    Instruction(
        image: "",
        title: "HANG IN THERE!",
        text: "The longer you survive in the dark world, the faster Slenderman will try to reach you."
    ),
    Instruction(
        image: "",
        title: "SLENDERMAN IS NEARBY!",
        text: "Watch out for the danger radius indicator. You will get a warning when Slenderman is getting too close. When that happens, RUN!"
    ),
    Instruction(
        image: "",
        title: "OH NO!",
        text: "If you accidentally point your camera at Slenderman, it's game over!"
    ),
]
