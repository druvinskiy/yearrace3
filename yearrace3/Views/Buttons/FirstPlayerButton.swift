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
    var isSelected: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .foregroundColor(Color.brandPrimary)
                .frame(width: 100, height: 40)
                
            Rectangle()
                .fill(colorScheme == .dark ? Color.white : Color.black)
                .frame(width: 100, height: 60)
        }
        .cornerRadius(5)
        .overlay(
            Text(response)
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(colorScheme == .dark ? .black : .white)
                .offset(y: 10.0)
        )
        .border(isSelected ? Color.brandSecondary : Color.clear, width: 5)
    }
}

struct FirstPlayerButton_Previews: PreviewProvider {
    static var previews: some View {
        FirstPlayerButton(isSelected: true)
    }
}
