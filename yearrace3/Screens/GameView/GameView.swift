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
    
    @State var timeRemaining = 10
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(alignment: .center) {
            HorizonView(game: viewModel.game,
                        userSelectedDate: $viewModel.userSelectedDate,
                        shouldScroll: $viewModel.shouldScroll,
                        result: $viewModel.result)
                .padding(.bottom)
            
            VStack(spacing: 20) {
                Button() {
                    viewModel.confirmDate()
                    
                    if viewModel.result != .ok {
                        timeRemaining = 1
                    }
                    
                }
                label: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        YRButton(title: viewModel.submitButtonTitle, color: viewModel.submitButtonColor)
                    }
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
        
        .onReceive(timer) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
                return
            }
            
            viewModel.result = .ok
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(mainViewModel: MainViewModel()))
            .preferredColorScheme(.dark)
    }
}
