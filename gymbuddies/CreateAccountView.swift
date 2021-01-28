//
//  CreateAccountView.swift
//  gymbuddies
//
//  Created by Kareha on 1/27/21.
//

import SwiftUI
import Firebase

struct CreateAccountView: View {
    
    @ObservedObject var users = getUsersData()
    @State var username : String = ""
    @State var password : String = ""
    @State var email : String = ""
    
    var body: some View {
        NavigationView{
            VStack{
                
                
    //            VStack(alignment: .leading){
                    Text("Gym Buddies")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.trailing)
    //                    .multilineTextAlignment(.leading)

                        
                        
                    Text("Sign Up")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.leading)
    //                    .multilineTextAlignment(.leading)
    //            }
                
                
                Spacer().frame(height: 90)
                
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                        Text("Username").font(.headline).fontWeight(.light)
                        TextField("Enter your Username", text: $username)
                        Divider()
                    }
                    VStack(alignment: .leading){
                        Text("Email").font(.headline).fontWeight(.light)
                        TextField("Enter your Email Address", text: $email)
                        Divider()
                    }
                    VStack(alignment: .leading){
                        Text("Password").font(.headline).fontWeight(.light)
                        SecureField("Enter your Password", text: $password)
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
       //                for custom divide rbg by 255
                       .background(Color.purple)
                     .cornerRadius(10.0)
                   })
                
                Spacer()
                
    //            List(users.data){i in
    //
    //                Text(i.username)
    //
    //
    //            }
            }.padding()
            
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
class getUsersData : ObservableObject {
    @Published var data = [user]()
    
    init() {
        let db = Firestore.firestore()
        
        db.collection("users").addSnapshotListener { (snap, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            for i in snap!.documentChanges{
                let id = i.document.documentID
                let username = i.document.get("username") as! String
                let password = i.document.get("password") as! String
                let email = i.document.get("email") as! String
                
                self.data.append(user(id: id, username: username, email: email, password: password))
            }
        }
    }
}

struct user : Identifiable {
    
    var id : String
    var username : String
    var email : String
    var password : String
}
