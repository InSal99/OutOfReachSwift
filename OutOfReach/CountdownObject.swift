//
//  CountdownObject.swift
//  asdfghjkl
//
//  Created by Intan Saliya Utomo on 25/05/23.
//

import Foundation
import Combine

class CountDownObject: ObservableObject {
        @Published var countDown: Int = 0
        @Published var isTimerOn: Bool = true
        @Published var iterateCount: Int = 1
        @Published var finalCountDown: Int = 0
        @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func countDownCGenerator(countDown: Int, iterateCount: Int) -> Int {
        let generatedCountDown = countDown / iterateCount
        return generatedCountDown
    }
}
