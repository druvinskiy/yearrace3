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
                        DateButton(month: "Jan", day: "1", isSelected: $viewModel.isJan1Selected)
                    }
                    
                    Button() {
                        viewModel.setMode(mode: .getdec31)
                    } label: {
                        DateButton(month: "Dec", day: "31", isSelected: $viewModel.isDec31Selected)
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
                        print("Test")
                    } label: {
                        FirstPlayerButton(response: "Yes")
                    }
                    
                    Button() {
                        print("Test")
                    } label: {
                        FirstPlayerButton(response: "No")
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
