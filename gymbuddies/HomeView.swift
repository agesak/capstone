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
                        destination: CreateAccountView(),
                        label: {
                            Text("Sign Up")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                          .frame(width: 250, height: 50)
//                                .background(Color.purple)
                                .background(Color(red: 135.0 / 255.0, green: 206.0 / 255.0, blue: 250.0 / 255.0))
//                                .background(Color(red: 255.0 / 255.0, green: 153.0 / 255.0, blue: 153.0 / 255.0))
                          .cornerRadius(10.0)
                        })
                    Spacer().frame(height: 20)
                    
                NavigationLink(
                   destination: SignInView(),
                   label: {
                       Text("Sign In")
                       .font(.title)
                       .fontWeight(.bold)
                       .foregroundColor(.white)
                       .padding()
                     .frame(width: 250, height: 50)
       //                for custom divide rbg by 255
                       .background(Color(red: 135.0 / 255.0, green: 206.0 / 255.0, blue: 250.0 / 255.0))
                     .cornerRadius(10.0)
                   })
                    Spacer()
                    
//                    Spacer().frame(height: 200)
                }
            }
        }.navigationBarBackButtonHidden(true)
//        .navigationBarTitle("", displayMode: .inline)
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
        //                cant use sfsymbols as logos?
        //                sportscourt.fill
        Image("barbell-icon")
//        Image(systemName: "sportscourt")
//            .padding(.top)
//            .font(.system(size: 65, weight: .light))
    }
}
