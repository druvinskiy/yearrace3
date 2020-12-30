//
//  QuestionMarkButton.swift
//  yearrace3
//
//  Created by David Ruvinskiy on 12/29/20.
//

import SwiftUI

struct QuestionMarkButton: View {
    @Binding var showOnBoarding: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button {
                    showOnBoarding = true
                } label: {
                    Image(systemName: "questionmark.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(Color(.label))
                        .frame(width: 55, height: 55)
                }
            }
            .padding(.trailing, 10)
            
            Spacer()
        }
    }
}

struct QuestionMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        QuestionMarkButton(showOnBoarding: .constant(true))
    }
}
