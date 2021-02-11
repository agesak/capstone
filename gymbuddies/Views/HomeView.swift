//
//  ContentView.swift
//  gymbuddies
//
//  Created by Kareha on 1/27/21.
//

import SwiftUI
import Firebase

struct HomeView : View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    init() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body : some View {
        
        NavigationView {
            
            ZStack{
                if colorScheme == .dark {
                    Image("barbell-cropped").resizable().aspectRatio(contentMode: .fill).ignoresSafeArea().opacity(0.1)
                } else {
                    Image("barbell-cropped").resizable().aspectRatio(contentMode: .fill).ignoresSafeArea().opacity(0.1)
                }
                VStack {
                    Spacer().frame(height: 130)
                    AppName()
                    Spacer().frame(height: 120)
                    AppLogo()
                    Spacer().frame(height: 80)
                
                 NavigationLink(
//                    SelectIconView()
                        destination: CreateAccountView(),
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

struct AppName: View {
    var body: some View {
        Text("MyGymPals")
            .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
            .fontWeight(.bold)
            .foregroundColor(Color.black)
    }
}

struct AppLogo: View {
    var body: some View {
        Image("barbell-icon")
    }
}
