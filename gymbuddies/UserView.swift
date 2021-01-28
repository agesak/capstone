//
//  UserView.swift
//  gymbuddies
//
//  Created by Kareha on 1/27/21.
//

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
                        print("it worked bihhhhh!!!!")
                        self.name = ""
                    }
                }
        }) { Text("Update User")}
        
            }
        }
    }
}


struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
            
    }
}
