//
//  CreateAccountView.swift
//  gymbuddies
//
//  Created by Kareha on 1/27/21.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    
    @State var password : String = ""
    @State var email : String = ""
    @State private var isLoginValid: Bool = false
    @State private var shouldShowLoginAlert: Bool = false
    
    var body: some View {
        
        ZStack {
            Image("barbell-cropped").resizable().aspectRatio(contentMode: .fill).opacity(0.1).ignoresSafeArea()
            
            VStack{
                Spacer().frame(height: 250)
                
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                        Text("Email").font(.headline).fontWeight(.light).foregroundColor(Color.black)
                        TextField("Enter your Email Address", text: $email)
                            .background(Color.clear)
                        .autocapitalization(.none)
                        Divider()
                    }
                    VStack(alignment: .leading){
                        Text("Password").font(.headline).fontWeight(.light).foregroundColor(Color.black)
                        SecureField("Enter your Password", text: $password)
                        .autocapitalization(.none)
                        Divider()
                    }
                }.padding(.horizontal, 6)
                Spacer()
                NavigationLink(
                    destination: WelcomeView(),
                    isActive: self.$isLoginValid) {
                    ButtonView(buttonText: "Sign Up")
                            .onTapGesture {
                                Auth.auth().createUser(withEmail: self.email, password: self.password, completion: { (result, error) in
                                         if let error = error {
                                            print(error.localizedDescription)
                                            self.isLoginValid = false
                                            self.shouldShowLoginAlert = true
                                         } else {
                                            print("profile created")
                                            self.email = ""
                                            self.password = ""
                                            self.isLoginValid = true
                                            self.shouldShowLoginAlert = false
                                         }
                                     })
                            }
                    }
                Spacer()
            }
        }.navigationBarTitle("Sign Up")
        .alert(isPresented: $shouldShowLoginAlert) {
        Alert(title: Text("Email/Password invalid"))}
    }
}

struct CreateAccount_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .preferredColorScheme(.light)
    }
}
