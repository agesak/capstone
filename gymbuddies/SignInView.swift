//
//  SignInView.swift
//  gymbuddies
//
//  Created by Kareha on 1/28/21.
//

import SwiftUI
import Firebase

struct SignInView: View {
    
    @State var password : String = ""
    @State var email : String = ""
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Text("Gym Buddies")
                .font(.headline)
                .fontWeight(.heavy)
//                        idk why this doesn't work
//                .multilineTextAlignment(.leading)

                
                
            Text("Sign In")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .multilineTextAlignment(.leading)
//                    .multilineTextAlignment(.leading)
            
            Spacer()
            
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    Text("Email").font(.headline).fontWeight(.light)
                    TextField("Enter your Email Address", text: $email)
                    .autocapitalization(.none)
                    Divider()
                }
                VStack(alignment: .leading){
                    Text("Password").font(.headline).fontWeight(.light)
                    SecureField("Enter your Password", text: $password)
                    .autocapitalization(.none)
                    Divider()
                }
            }.padding(.horizontal, 6)
            
            Spacer()
            
            NavigationLink(
               destination: UserView(),
               label: {
                   Text("Continue")
                   .font(.title)
                   .fontWeight(.bold)
                   .foregroundColor(.white)
                   .padding()
                 .frame(width: 250, height: 50)
                   .background(Color.purple)
                 .cornerRadius(10.0)
               }).simultaneousGesture(TapGesture().onEnded{
                Auth.auth().signIn(withEmail: self.email, password: self.password, completion: { (result, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        print("it worked bihhhhh!!!!")
//                            self.username = ""
                        self.email = ""
                        self.password = ""
                    }
                    })
               })
            
            Spacer()
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
