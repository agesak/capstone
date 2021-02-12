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

//class getUserData: ObservableObject {
//    @Published var users = [User]()
//    func getData(){
//        let db = Firestore.firestore()
//
//        db.collection("users").addSnapshotListener( {querySnapshot, error in
//            guard let documents = querySnapshot?.documents else {
//                print("error fetching documents: \(error!)")
//                return
//            }
//            let allUsers = documents.map { (queryDocumentSnapshot) -> User in
//                let data = queryDocumentSnapshot.data()
//                let id = queryDocumentSnapshot.documentID
//                let name = data["name"] as? String ?? ""
//                let age = data["age"] as? String ?? ""
//                let location = data["location"] as? String ?? ""
//                let pronouns = data["pronouns"] as? String ?? ""
//                let aboutMe = data["aboutMe"] as? String ?? ""
//                let frequency = data["frequency"] as? String ?? ""
//                let style = data["style"] as? String ?? ""
//                let times = data["times"] as? String ?? ""
//                let pic = data["pic"] as? String ?? ""
//                return User(id: id, age: age, name: name, location: location, pronouns: pronouns, aboutMe: aboutMe, frequency: frequency, style: style, times: times, pic: pic)
//            }
//
//            self.users = allUsers.filter{user in return user.id != Auth.auth().currentUser!.uid}
//        })
//    }
//}

// doesnt currently work
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

class getAllUsers : ObservableObject{
    @Published var users = [User]()
    @Published var empty = false
    private let user = Auth.auth().currentUser
    
    
    init() {
        
        let db = Firestore.firestore()
        
        db.collection("users").getDocuments { (snap, err) in

            if err != nil{
                
                print((err?.localizedDescription)!)
                self.empty = true
                return
            }
            
            for i in snap!.documents{
                
                let id = i.documentID
                let name = i.get("name") as! String
                let age = i.get("age") as! String
                let location = i.get("location") as! String
                let pronouns = i.get("pronouns") as! String
                let aboutMe = i.get("aboutMe") as! String
                let frequency = i.get("frequency") as! String
                let style = i.get("style") as! String
                let times = i.get("times") as! String
                let pic = i.get("pic") as! String

                if id != self.user?.uid {
                    self.users.append(User(id: id, age: age, name: name, location: location, pronouns: pronouns, aboutMe: aboutMe, frequency: frequency, style: style, times: times, pic: pic))
                }
            }
        }
    }
}

