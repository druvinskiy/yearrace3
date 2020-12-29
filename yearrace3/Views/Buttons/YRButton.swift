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
    var tapped: Bool = false
    
    init(title: LocalizedStringKey, color: Color, tapped: Bool) {
        self.title = title
        self.color = color
        self.tapped = tapped
    }
    
    init(title: LocalizedStringKey) {
        self.title = title
    }
    
    var body: some View {
        ZStack {
            if tapped {
                RoundedRectangle(cornerRadius: 10)
                    .fill(color)
                Text(title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration:0.3)))
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(color)
                Text(title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration:0.3)))
            }
        }
        .frame(width: 260, height: 50)
    }
}

struct APButton_Previews: PreviewProvider {
    static var previews: some View {
        YRButton(title: "Test Title")
    }
}
