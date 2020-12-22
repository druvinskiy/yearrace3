//
//  YRButton.swift
//  yearrace3
//
//  Created by David Ruvinskiy on 12/20/20.
//

import SwiftUI

struct YRButton: View {
    let title: LocalizedStringKey
    
    var body: some View {
        Text(title)
            .font(.title)
            .fontWeight(.semibold)
            .frame(width: 260, height: 50)
            .foregroundColor(.white)
            .background(Color(#colorLiteral(red: 0.1803921569, green: 0.2352941176, blue: 0.8196078431, alpha: 1)))
            .cornerRadius(10)
    }
}

struct APButton_Previews: PreviewProvider {
    static var previews: some View {
        YRButton(title: "Test Title")
    }
}
