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
    @Published var submitButtonToggle = false
    
    @Published var gameEndMessage = ""
    @Published var inGameOverState = false
    @Published var gameEndColor = Color.brandBad
    
    @Published var timeRemaining = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
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
        
        return mainViewModel.game.isValidDate(date: userSelectedDate) ? .brandSecondary : .brandBad
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
    
    func onReceiveTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            return
        }
        
        result = .ok
    }
    
    func confirmDate() {
        guard let userSelectedDate = userSelectedDate else { return }
        
        guard game.isValidDate(date: userSelectedDate) else {
            result = game.isValidDate(date: userSelectedDate)
            timeRemaining = 2
            return
        }
        
        result = .ok
        mainViewModel.game.chooseDate(userSelectedDate)
        self.userSelectedDate = nil
        shouldScroll = game.currentDate.month != game.lastChosenDate.month
        
        configureWinnerState()
    }
    
    private func configureWinnerState() {
        guard let winner = game.winner else { return }
        
        gameEndMessage = winner == .user ? WonLostMessage.won.rawValue : WonLostMessage.lost.rawValue
        gameEndColor = winner == .user ? .brandGood : .brandBad
        inGameOverState = true
    }
}
