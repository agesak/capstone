//
//  Welcome.swift
//  gymbuddies
//
//  Created by Kareha on 2/2/21.
//

import SwiftUI

struct WelcomeView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        
        ZStack{
            if colorScheme == .dark {
                Image("barbell-cropped").resizable().aspectRatio(contentMode: .fill).opacity(0.1).ignoresSafeArea()
            } else {
                Image("barbell-cropped").resizable().aspectRatio(contentMode: .fill).opacity(0.1).ignoresSafeArea()
            }
        
        VStack {
            Spacer().frame(height: 250)
            
            HStack{
                Text("👋")
                    .font(.system(size: 30))
                Text("Welcome")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            
            Text("Let's learn some more about you!")
            Spacer().frame(height: 90)
            
            NavigationLink(
                destination: DemographicInfoView(),
                label: {
                    ButtonView(buttonText: "Let's Go!")
                    })
            Spacer()
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
