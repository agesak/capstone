//
//  CreateAccountView.swift
//  gymbuddies
//
//  Created by Kareha on 1/27/21.
//

import SwiftUI
import Firebase

struct CreateAccountView: View {
    
//    @ObservedObject var users = getUsersData()
//    @State var username : String = ""
    @State var password : String = ""
    @State var email : String = ""
    @State private var isLoginValid: Bool = false
    @State private var shouldShowLoginAlert: Bool = false
    
    var body: some View {
            VStack{
//                    Text("Gym Buddies")
//                        .font(.headline)
//                        .fontWeight(.heavy)
//                        idk why this doesn't work
//                        .multilineTextAlignment(.leading)
                
                Spacer().frame(height: 90)
                
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
                    destination: Welcome(),
                    isActive: self.$isLoginValid) {
                        Text("Continue")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 250, height: 50)
                            .background(Color.purple)
                            .cornerRadius(10.0)
                            .onTapGesture {
                                
                                Auth.auth().createUser(withEmail: self.email, password: self.password, completion: { (result, error) in
                                         if let error = error {
                                             print(error.localizedDescription)
                                            self.isLoginValid = false
                                            self.shouldShowLoginAlert = true
                                         } else {
                                             print("it worked!!!!")
                                            print(self.email)
                                             self.email = ""
                                             self.password = ""
                                            self.isLoginValid = true
                                            self.shouldShowLoginAlert = false
//                                            print(self.isLoginValid)
                                         }
                                     })
                            }
                    }
                
                Spacer()

            }.navigationBarTitle("Sign Up")
            .alert(isPresented: $shouldShowLoginAlert) {
            Alert(title: Text("Email/Password invalid"))
            
        }
        
    }
}

struct CreateAccount_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
            
    }
}

//struct Home : View {
//
//
//
//    var body : some View{
//
//        VStack{
//
//            Text("Sign Up")
//                .font(.largeTitle)
//            TextField("Username", text: $username)
//
////            List(users.data){i in
////
////                Text(i.username)
////
////
////            }
//        }
//    }
//}

//displaying the data
//class getUsersData : ObservableObject {
//    @Published var data = [user]()
//    
//    init() {
//        let db = Firestore.firestore()
//        
//        db.collection("users").addSnapshotListener { (snap, err) in
//            if err != nil {
//                print((err?.localizedDescription)!)
//                return
//            }
//            for i in snap!.documentChanges{
//                let id = i.document.documentID
//                let username = i.document.get("username") as! String
//                let password = i.document.get("password") as! String
//                let email = i.document.get("email") as! String
//                
//                self.data.append(user(id: id, username: username, email: email, password: password))
//            }
//        }
//    }
//}
//
//struct user : Identifiable {
//    
//    var id : String
//    var username : String
//    var email : String
//    var password : String
//}
