//
//  CurrentUser.swift
//  gymbuddies
//
//  Created by Kareha on 2/11/21.
//

import SwiftUI
import Firebase


class getCurrentUser : ObservableObject{
    @Published var user = User()

    func getUser(){
        let db = Firestore.firestore()
        
        db.document("users/\(Auth.auth().currentUser!.uid)")
        .addSnapshotListener({ documentSnapshot, error in
            guard let document = documentSnapshot else {
            print("Error fetching document: \(error!)")
            return
          }
            let data = document.data()
            self.user = User(id: document.documentID, age: data!["age"] as! String, name: data!["name"] as! String, location: data!["location"] as! String, pronouns: data!["pronouns"] as! String, aboutMe: data!["aboutMe"] as! String, frequency: data!["frequency"] as! String, style: data!["style"] as! String, times: data!["times"] as! String, pic: data!["pic"] as! String)
          })
    }
}

class updateUser : ObservableObject {
    
    var user = Auth.auth().currentUser!
    var userInfo : [String : Any] = [:]
    
    init(userInfo: [String : Any]){
        self.userInfo = userInfo
    }
    
    func create(userInfo: [String : Any]) -> Bool {
        var valid = false
        let docRef = Firestore.firestore().document("users/\(user.uid)")
        docRef.setData(userInfo as [String : Any]){ (error) in
                if let error = error {
                    print("error = \(error)")
                } else {
                    print("profile updated")
                    valid = true
                }
            }
        return valid
    }
    
    
    func update(userInfo : [String]){
        
    }
    
}
