//
//  MainViewModel.swift
//  yearrace3
//
//  Created by David Ruvinskiy on 12/23/20.
//

import SwiftUI

final class MainViewModel: ObservableObject {
    var game: Game = GetJan1(firstPlayer: .user)
    @Published var isDec31Selected = false
    @Published var isJan1Selected = true
    
    func setMode(mode: Mode) {
        game = mode == .getdec31 ? GetDec31(firstPlayer: game.firstPlayer) : GetJan1(firstPlayer: game.firstPlayer)
        isJan1Selected = mode == .getjan1
        isDec31Selected = mode == .getdec31
    }
}
