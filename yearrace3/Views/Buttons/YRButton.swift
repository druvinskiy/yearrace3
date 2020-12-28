//
//  YRButton.swift
//  yearrace3
//
//  Created by David Ruvinskiy on 12/20/20.
//

import SwiftUI

struct YRButton: View {
    let title: LocalizedStringKey
    var color: Color = .brandSecondary
    
    init(title: LocalizedStringKey, color: Color) {
        self.title = title
        self.color = color
    }
    
    init(title: LocalizedStringKey) {
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .font(.title)
            .fontWeight(.semibold)
            .frame(width: 260, height: 50)
            .foregroundColor(.white)
            .background(color)
            .cornerRadius(10)
    }
}

struct APButton_Previews: PreviewProvider {
    static var previews: some View {
        YRButton(title: "Test Title")
    }
}
