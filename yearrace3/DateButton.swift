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
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .foregroundColor(Color(#colorLiteral(red: 0.7215686275, green: 0, blue: 0, alpha: 1)))
                .frame(width: 100, height: 40)
                .overlay(
                    Text(month)
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                )
            Rectangle()
                .fill(colorScheme == .dark ? Color.white : Color.black)
                .frame(width: 100, height: 60)
                .overlay(
                    Text(day)
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(colorScheme == .dark ? .black : .white)
                )
        }
        .cornerRadius(5)
        
//        ZStack {
//            Rectangle()
//                .foregroundColor(colorScheme == .dark ? .white : .black)
//                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
//                .offset(y: 25)
//
//            Text(month)
//                .font(.title)
//                .foregroundColor(.white)
//                .fontWeight(.heavy)
//                .zIndex(1)
//                .offset(y: -25)
//
//            Text(day)
//                .font(.title)
//                .foregroundColor(colorScheme == .dark ? .black : .white)
//                .fontWeight(.heavy)
//                .zIndex(1)
//                .offset(y: 20)
//
//
//            Rectangle()
//                .cornerRadius(5)
//                .foregroundColor(Color(#colorLiteral(red: 0.7215686275, green: 0, blue: 0, alpha: 1)))
//                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 40)
//                .offset(y: -25)
//        }
//        .cornerRadius(5)

    }
}

struct DateButton_Previews: PreviewProvider {
    static var previews: some View {
        DateButton()
            .preferredColorScheme(.dark)
    }
}
