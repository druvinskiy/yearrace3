//
//  GameViewModel.swift
//  yearrace3
//
//  Created by David Ruvinskiy on 12/24/20.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    @Published var mainViewModel: MainViewModel
    @Published var userSelectedDate: DateComponents?
    @Published var shouldScroll = false
    @Published var result = Result.ok
    
    var submitButtonTitle: LocalizedStringKey {
        guard userSelectedDate != nil else {
            return "Choose a Date"
        }
        
        return mainViewModel.game.isValidDate(date: userSelectedDate!) == .ok ? "Select" : "Invalid Date"
    }
    
    var submitButtonColor: Color {
        guard let userSelectedDate = userSelectedDate else {
            return .gray
        }
        
        return mainViewModel.game.isValidDate(date: userSelectedDate) ? .brandSecondary : Color(#colorLiteral(red: 0.7215686275, green: 0, blue: 0.3607843137, alpha: 1))
    }
    
    var game: Game {
        mainViewModel.game
    }
    
    init(mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
    }
    
    func startGame() {
        if game.mode == .getjan1 {
            shouldScroll = true
        }
        
        mainViewModel.game.startGame()
    }
    
    func resetGame() {
        mainViewModel.resetGame()
    }
    
    func confirmDate() {
        guard let userSelectedDate = userSelectedDate else { return }
        
        guard game.isValidDate(date: userSelectedDate) else {
            result = game.isValidDate(date: userSelectedDate)
            return
        }
        
        result = .ok
        mainViewModel.game.chooseDate(userSelectedDate)
        self.userSelectedDate = nil
        shouldScroll = true
    }
}
