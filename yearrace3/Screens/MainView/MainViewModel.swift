//
//  MainViewModel.swift
//  yearrace3
//
//  Created by David Ruvinskiy on 12/23/20.
//

import SwiftUI

final class MainViewModel: ObservableObject {
    @Published var game = GetDec31(firstPlayer: .user)
    
//    func setMode(mode: Mode) {
//        game = mode == .getdec31 ? GetDec31(firstPlayer: game?.firstPlayer) : GetJan1(firstPlayer: game?.firstPlayer)
//    }
}
