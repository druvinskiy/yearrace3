//
//  MainView.swift
//  yearrace3
//
//  Created by David Ruvinskiy on 12/14/20.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 223, height: 123)
                
                Text("Welcome to YearRace!")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 30)
                
                Text("What date do you want to race to?")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.top, 30)
                
                HStack(spacing: 40) {
                    Button() {
                        viewModel.setMode(mode: .getjan1)
                        
                    } label: {
                        DateButton(month: "Jan", day: "1", isSelected: viewModel.game.mode == .getjan1)
                    }
                    
                    Button() {
                        viewModel.setMode(mode: .getdec31)
                    } label: {
                        DateButton(month: "Dec", day: "31", isSelected: viewModel.game.mode == .getdec31)
                    }
                }
                .padding()
                
                Text("Do you want to go first?")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                
                HStack(spacing: 40) {
                    Button() {
                        viewModel.setFirstPlayer(firstPlayer: .user)
                    } label: {
                        FirstPlayerButton(response: "Yes", isSelected: viewModel.game.firstPlayer == .user)
                    }
                    
                    Button() {
                        viewModel.setFirstPlayer(firstPlayer: .computer)
                    } label: {
                        FirstPlayerButton(response: "No", isSelected: viewModel.game.firstPlayer == .computer)
                    }
                }
                
                Button() {
                    print("Test")
                } label: {
                    YRButton(title: "Start")
                        .foregroundColor(.black)
                }
                .padding(60)
            }
        }
        .fullScreenCover(isPresented: .constant(false)) {
            GameView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
    }
}
