//
//  FirstPlayerButton.swift
//  yearrace3
//
//  Created by David Ruvinskiy on 12/19/20.
//

import SwiftUI

struct FirstPlayerButton: View {
    var response = "Yes"
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                .offset(y: 25)

            Text(response)
                .font(.title)
                .foregroundColor(colorScheme == .dark ? .black : .white)
                .fontWeight(.heavy)
                .zIndex(1)


            Rectangle()
                .foregroundColor(Color(#colorLiteral(red: 0.7215686275, green: 0, blue: 0, alpha: 1)))
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 50)
                .offset(y: -25)
        }
        .cornerRadius(5)
    }
}

struct FirstPlayerButton_Previews: PreviewProvider {
    static var previews: some View {
        FirstPlayerButton()
    }
}
