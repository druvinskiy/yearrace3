//
//  GameView.swift
//  yearrace3
//
//  Created by David Ruvinskiy on 12/20/20.
//

import SwiftUI

struct GameView: View {
    var body: some View {
        VStack(alignment: .center) {
            HorizonView()
            
            Button() {
                print("Test")
            } label: {
                YRButton(title: "Select")
            }
            .padding(30)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
