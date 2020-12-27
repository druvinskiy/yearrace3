//
//  MainViewModel.swift
//  yearrace3
//
//  Created by David Ruvinskiy on 12/23/20.
//

import SwiftUI

final class MainViewModel: ObservableObject {
    @Published var game: Game = GetJan1(firstPlayer: .user)
    @Published var isShowingGameView = false
    
    func setMode(mode: Mode) {
        game = mode == .getdec31 ? GetDec31(firstPlayer: game.firstPlayer) : GetJan1(firstPlayer: game.firstPlayer)
    }
    
    func setFirstPlayer(firstPlayer: Player) {
        game = game.mode == .getdec31 ? GetDec31(firstPlayer: firstPlayer) : GetJan1(firstPlayer: firstPlayer)
    }
    
    func resetGame() {
        setMode(mode: game.mode)
        setFirstPlayer(firstPlayer: game.firstPlayer)
        isShowingGameView = false
    }
}
