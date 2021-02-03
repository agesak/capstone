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
            
            Spacer().frame(height: 200)
            
            HStack{
                Image(systemName: "hand.wave")
                Text("Welcome")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            
            
            
//            Spacer()
            Text("Let's learn some more about you!")
            Spacer().frame(height: 90)
            
            NavigationLink(
                destination: CreatePreferencesView(),
                label: {
                    Text("Let's go!")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 250, height: 50)
                        .background(Color.purple)
                        .cornerRadius(10.0)
                    })
            
            Spacer()
            }.navigationBarBackButtonHidden(true)
    }
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
    }
}
