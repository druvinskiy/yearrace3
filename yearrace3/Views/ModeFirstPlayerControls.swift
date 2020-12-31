//
//  ModeFirstPlayerControls.swift
//  yearrace3
//
//  Created by David Ruvinskiy on 12/29/20.
//

import SwiftUI

struct ModeFirstPlayerControls: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                Text("What date do you want to race to?")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                
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
            }
            
            VStack {
                Text("Do you want to go first?")
                    .font(.title3)
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
            }
        }
    }
}

struct PlayerModeControlls_Previews: PreviewProvider {
    static var previews: some View {
        ModeFirstPlayerControls(viewModel: MainViewModel())
    }
}
