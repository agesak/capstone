//
//  CreateAccountView.swift
//  gymbuddies
//
//  Created by Kareha on 1/27/21.
//

import SwiftUI
import Firebase

struct CreateAccountView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State var password : String = ""
    @State var email : String = ""
    @State private var isLoginValid: Bool = false
    @State private var shouldShowLoginAlert: Bool = false
    
    var body: some View {
        
        ZStack {
            
            if colorScheme == .dark {
//                "barbell_2nd_lighter"
                Image("barbell-cropped").resizable().aspectRatio(contentMode: .fill).opacity(0.1).ignoresSafeArea()
            } else {
                Image("barbell-cropped").resizable().aspectRatio(contentMode: .fill).opacity(0.1).ignoresSafeArea()
            }
            

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
                    destination: Welcome(),
                    isActive: self.$isLoginValid) {
                        Text("Sign Up")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 250, height: 50)
                            .background(Color(red: 135.0 / 255.0, green: 206.0 / 255.0, blue: 250.0 / 255.0))
                            .cornerRadius(10.0)
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
        CreateAccountView()
            .preferredColorScheme(.light)
            
    }
}
