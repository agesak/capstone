//
//  Welcome.swift
//  gymbuddies
//
//  Created by Kareha on 2/2/21.
//

import SwiftUI

struct Welcome: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        
        ZStack{
            if colorScheme == .dark {
//                "barbell_2nd_lighter"
                Image("barbell-cropped").resizable().aspectRatio(contentMode: .fill).opacity(0.1).ignoresSafeArea()
            } else {
                Image("barbell-cropped").resizable().aspectRatio(contentMode: .fill).opacity(0.1).ignoresSafeArea()
            }
        
        VStack {
            Spacer().frame(height: 250)
            
            HStack{
                Image(systemName: "hand.wave")
                    .imageScale(.large)
                Text("Welcome")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            
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
                        .background(Color(red: 135.0 / 255.0, green: 206.0 / 255.0, blue: 250.0 / 255.0))
                        .cornerRadius(10.0)
                    })
            Spacer()
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
    }
}
