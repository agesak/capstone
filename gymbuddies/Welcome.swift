//
//  Welcome.swift
//  gymbuddies
//
//  Created by Kareha on 2/2/21.
//

import SwiftUI

struct Welcome: View {
    var body: some View {
        
        VStack {
            Text("Welcome")
            
            NavigationLink(
                destination: CreatePreferencesView(),
                label: {
                    Text("Continue")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 250, height: 50)
                        .background(Color.purple)
                        .cornerRadius(10.0)
                    })
            }
    }
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
    }
}
