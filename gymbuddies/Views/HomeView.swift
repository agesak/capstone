//
//  ContentView.swift
//  gymbuddies
//
//  Created by Kareha on 1/27/21.
//

import SwiftUI
import Firebase

struct AppName: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
        Text("MyGymPals")
            .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
            .fontWeight(.bold)
            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
    }
}

struct AppLogo: View {
    var body: some View {
        Image("barbell-icon")
    }
}

struct HomeView : View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    init() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body : some View {
        
        NavigationView {
            
            ZStack{
                Image("barbell-cropped").resizable().aspectRatio(contentMode: .fill).ignoresSafeArea().opacity(0.1)
                
                VStack {
                    Spacer().frame(height: 130)
                    AppName()
                    Spacer().frame(height: 120)
                    if colorScheme == .dark {
                        Image("inverted-barbell-icon")
                    } else {
                        Image("barbell-icon")
                    }
                    Spacer().frame(height: 80)
                
                 NavigationLink(
//                    SelectIconView()
                        destination: SignUpView(),
                        label: {
                            ButtonView(buttonText: "Sign Up")
                        })
                Spacer().frame(height: 20)
                    
                NavigationLink(
                   destination: SignInView(),
                   label: {
                    ButtonView(buttonText: "Sign In")
                   })
                Spacer()
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.light)
    }
}
