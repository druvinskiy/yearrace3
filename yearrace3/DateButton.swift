//
//  DateButton.swift
//  yearrace3
//
//  Created by David Ruvinskiy on 12/16/20.
//

import SwiftUI

struct DateButton: View {
    var month = "Dec"
    var day = "31"
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                .offset(y: 25)

            Text(month)
                .font(.title)
                .foregroundColor(.white)
                .fontWeight(.heavy)
                .zIndex(1)
                .offset(y: -25)

            Text(day)
                .font(.title)
                .foregroundColor(.white)
                .fontWeight(.heavy)
                .zIndex(1)
                .offset(y: 20)


            Rectangle()
                .cornerRadius(5)
                .foregroundColor(Color(#colorLiteral(red: 0.7215686275, green: 0, blue: 0, alpha: 1)))
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 40)
                .offset(y: -25)
        }
        .cornerRadius(5)

    }
}

struct DateButton_Previews: PreviewProvider {
    static var previews: some View {
        DateButton()
    }
}
