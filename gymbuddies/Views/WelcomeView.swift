//
//  Welcome.swift
//  gymbuddies
//
//  Created by Kareha on 2/2/21.
//

import SwiftUI

struct WelcomeView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        ZStack{
        Image("barbell-cropped").resizable().aspectRatio(contentMode: .fill).opacity(0.1).ignoresSafeArea()
        
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
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                Button(action: goBack) {
                    HStack {
                        Text("Cancel")
                    }
                }
            )
    }
    func goBack(){
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
