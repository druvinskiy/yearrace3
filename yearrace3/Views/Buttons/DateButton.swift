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
                .foregroundColor(Color.brandPrimary)
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

    }
}

struct DateButton_Previews: PreviewProvider {
    static var previews: some View {
        DateButton()
            .preferredColorScheme(.dark)
    }
}
