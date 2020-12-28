//
//  GameView.swift
//  yearrace3
//
//  Created by David Ruvinskiy on 12/20/20.
//

import SwiftUI
import HorizonCalendar

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            HorizonView(game: viewModel.game,
                        userSelectedDate: $viewModel.userSelectedDate,
                        shouldScroll: $viewModel.shouldScroll,
                        result: $viewModel.result)
                .padding(.bottom)
            
            VStack(spacing: 20) {
                if viewModel.submitButtonShouldBeVisible {
                    Button() {
                        viewModel.confirmDate()
                    }
                    label: {
                        YRButton(title: viewModel.submitButtonTitle, color: viewModel.submitButtonColor)
                    }
                } else {
                    Text(viewModel.gameEndMessage)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(viewModel.gameEndColor)
                }
                
                Button() {
                    viewModel.resetGame()
                } label: {
                    Text("Go Back")
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
            }
        }
        .onAppear() {
            viewModel.startGame()
        }
        
        .onReceive(viewModel.timer) { _ in
            viewModel.onReceiveTimer()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(mainViewModel: MainViewModel()))
            .preferredColorScheme(.dark)
    }
}
