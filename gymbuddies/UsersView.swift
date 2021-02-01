//
//  UsersView.swift
//  gymbuddies
//
//  Created by Kareha on 1/29/21.
//

import SwiftUI
import Firebase
import Foundation

struct User: Identifiable{
    var id: String = UUID().uuidString
    var age:String
    var name:String
    var location:String
}

struct UsersView: View {
    
    @ObservedObject private var userData = getUserData()
    var body: some View {
        
        VStack{
            NavigationView {
                List(userData.users) { user in
                    VStack(alignment: .leading) {
                        Text(user.name).font(.title)
                        Text(user.age).font(.subheadline)
                    }
                } .onAppear() {
                    self.userData.getData()
                }
        
            }
        }
//        UserRow()
    }
}


class getUserData: ObservableObject {
    @Published var users = [User]()
 
    func getData(){
        let db = Firestore.firestore()
        
        db.collection("users").addSnapshotListener( {querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("error fetching documents: \(error)")
                return
            }
            print(documents)
            
            
            self.users = documents.map { (queryDocumentSnapshot) -> User in
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let age = data["age"] as? String ?? ""
                let location = data["location"] as? String ?? ""
                return User(age: age, name: name, location: location)
            }
        })
        
    }
    
}


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
struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}


struct UserRow: View {
    var body: some View {
        HStack{
            Image(systemName: "person")
        }
    }
}

