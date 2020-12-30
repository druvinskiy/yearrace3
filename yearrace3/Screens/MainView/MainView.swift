//
//  MainView.swift
//  yearrace3
//
//  Created by David Ruvinskiy on 12/14/20.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    @State private var showOnBoarding = false
    @AppStorage("OnboardBeenViewed") var hasOnboarded = false
    var onboardSet = OnboardData.buildSet(height: 550)
    
    var body: some View {
        ZStack {
            
            ZStack {
                QuestionMarkButton(showOnBoarding: $showOnBoarding)
                
                VStack {
                    Spacer()
                    
                    VStack() {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 223, height: 123)
                        
                        Text("Welcome to YearRace!")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    ModeFirstPlayerControls(viewModel: viewModel)
                    
                    Spacer()
                    
                    Button() {
                        viewModel.isShowingGameView = true
                    } label: {
                        YRButton(title: "Start")
                    }
                    
                    Spacer()
                }
                
            }
            .disabled(showOnBoarding)
            .blur(radius: showOnBoarding ? 3.0 : 0)
            
            if showOnBoarding {
                OnboardingScreens(isPresenting: $showOnBoarding, onboardSet: onboardSet)
            }
        }
        .fullScreenCover(isPresented: $viewModel.isShowingGameView) {
            let gameViewModel = GameViewModel(mainViewModel: viewModel)
            GameView(viewModel: gameViewModel)
        }
        
        .onAppear {
//            hasOnboarded = false // only here for testing
            if !hasOnboarded {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        showOnBoarding.toggle()
                        hasOnboarded = true
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
                .preferredColorScheme(.dark)
        }
    }
}
