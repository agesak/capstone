//
//  UserView.swift
//  gymbuddies
//
//  Created by Kareha on 1/27/21.
//

//current user's profile
import SwiftUI
import Firebase

struct UserView: View {
    
    let user = Auth.auth().currentUser
    @State var name : String = ""
    
    private var db = Firestore.firestore()
    
    var body: some View {
        VStack {
            if user != nil {
                
            Text(user!.email!)
            Text(user!.uid)
                
            Text("Profile Information")
                
            VStack(alignment: .leading){
                Text("Name").font(.headline).fontWeight(.light)
                TextField("Enter your Name", text: $name)
                .autocapitalization(.none)
                Divider()
            }
  

            Button(action: {
                let userDictionary = [
                    "name": self.name,
                ]

                let docRef = Firestore.firestore().document("users/\(user!.uid)")
                    print("setting data")
                    docRef.setData(userDictionary){ (error) in
                        if let error = error {
                            print("error = \(error)")
                        } else {
                            self.name = ""
                        }
                    }
            }) { Text("Update Profile")}
                
                
                Button(action: signOut) { Text("Sign Out")}

                }
            }
        }
    
    
    func signOut(){
        do {
            try Auth.auth().signOut()
            print("signed out")
//            print(Auth.auth().currentUser!)
//            self.session = nil
//            self.users = []
//            self.messages = [Message]()
//            self.messagesDictionary = [String:Message]()
        } catch {
            print("Error signing out")
            print(Auth.auth().currentUser!)
        }
    }
}


struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
            
    }
}
