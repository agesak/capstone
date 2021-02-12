//
//  SignInView.swift
//  gymbuddies
//
//  Created by Kareha on 1/28/21.
//

import SwiftUI
import Firebaseg

struct SignInView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State var password : String = ""
    @State var email : String = ""
    @State var isLoginValid: Bool = false
    @State var shouldShowLoginAlert: Bool = false
    
    var body: some View {
            ZStack{
                if colorScheme == .dark {
                    Image("barbell-cropped").resizable().aspectRatio(contentMode: .fill).opacity(0.1).ignoresSafeArea()
                } else {
                    Image("barbell-cropped").resizable().aspectRatio(contentMode: .fill).opacity(0.1).ignoresSafeArea()
                }
                VStack{
                    Spacer().frame(height: 250)
                    
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
                        destination: UsersView(),
                        isActive: self.$isLoginValid) {
                        ButtonView(buttonText: "Sign In")
                                .onTapGesture {
                                    Auth.auth().signIn(withEmail: self.email, password: self.password, completion: { (result, error) in
                                             if let error = error {
                                                 print(error.localizedDescription)
                                                self.isLoginValid = false
                                                self.shouldShowLoginAlert = true
                                             } else {
                                                print("signed in")
                                                self.email = ""
                                                self.password = ""
                                                self.isLoginValid = true
                                                self.shouldShowLoginAlert = false
                                                print(self.isLoginValid)
                                             }
                                    })
                                }
                        }
                
            Spacer()
            }
        }.navigationBarTitle("Sign In")
            .alert(isPresented: $shouldShowLoginAlert) {
                Alert(title: Text("Error Accessing Account"))}
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
