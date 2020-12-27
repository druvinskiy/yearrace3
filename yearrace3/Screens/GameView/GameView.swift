//
//  GameView.swift
//  yearrace3
//
//  Created by David Ruvinskiy on 12/20/20.
//

import SwiftUI
import HorizonCalendar

struct GameView: View {
    @ObservedObject var game: Game
    @ObservedObject var mainViewModel: MainViewModel
    @State var userSelectedDate: DateComponents?
    @State var shouldScroll = false
    
    var body: some View {
        VStack(alignment: .center) {
            HorizonView(game: game, userSelectedDate: $userSelectedDate, shouldScroll: $shouldScroll)
                .padding(.bottom)
            
            VStack(spacing: 20) {
                Button() {
                    if let userSelectedDate = userSelectedDate {
                        game.chooseDate(date: userSelectedDate)
                        shouldScroll = true
                    }
                } label: {
                    YRButton(title: "Select")
                }
                
                Button() {
                    mainViewModel.resetGame()
                } label: {
                    Text("Go Back")
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
            }
        }
        .onAppear() {
            game.startGame()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: Game(mode: .getdec31,
                            firstPlayer: .user),
                 mainViewModel: .init())
            .preferredColorScheme(.dark)
    }
}
