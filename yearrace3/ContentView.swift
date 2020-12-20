//
//  ContentView.swift
//  yearrace3
//
//  Created by David Ruvinskiy on 12/14/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 301, height: 185)
                
                Text("Welcome to YearRace!")
                    .font(.title)
                    .fontWeight(.bold)
//                    .padding()
                
                Text("What date do you want to race to?")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.top, 30)
                
                HStack(spacing: 40) {
                    Button() {
                        print("Test")
                    } label: {
                        DateButton(month: "Dec", day: "31")
                    }
                    
                    Button() {
                        print("Test")
                    } label: {
                        DateButton(month: "Jan", day: "1")
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
            }
            .offset(y: -50)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
