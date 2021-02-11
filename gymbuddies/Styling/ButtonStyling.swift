//
//  ButtonStyling.swift
//  gymbuddies
//
//  Created by Kareha on 2/11/21.
//

import SwiftUI

struct ButtonView: View {
    
    var buttonText : String
    
    var body: some View {
        Text(buttonText)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding()
            .frame(width: 250, height: 50)
            .background(Color.buttonColor)
            .cornerRadius(10.0)
    }
}

extension Color {
    static let buttonColor = Color("Button")
}
