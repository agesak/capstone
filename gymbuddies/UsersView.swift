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
    var email:String
}

struct UsersView: View {
    
    @ObservedObject private var userData = getUserData()
    var body: some View {
        
        VStack{
                List(userData.users) { user in
                    VStack(alignment: .leading) {
                        NavigationLink(
                            destination : OtherUserView(user: user)) {
                            HStack {
                                Image(systemName: "person")
                                Text(user.name).font(.title)
                                //                        Text(user.age).font(.subheadline)
                                }
                            }
                    }
                }.onAppear() {
                    self.userData.getData()
                    }
            }
        }
}


class getUserData: ObservableObject {
    @Published var users = [User]()

    func getCurrentUser() -> String {
        let currentUser = Auth.auth().currentUser
        print("current user's email: \(currentUser!.email!)")
        return currentUser!.email!
    }
 
    func getData(){
        let db = Firestore.firestore()
        let currentUserEmail = getCurrentUser()
        
        db.collection("users").addSnapshotListener( {querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("error fetching documents: \(error!)")
                return
            }
//            print(documents)

//            for document in documents {
//                let data = document.data()
//                let id = document.documentID
//                let name = data["name"] as? String ?? ""
//                let age = data["age"] as? String ?? ""
//                let location = data["location"] as? String ?? ""
//                let email = data["email"] as? String ?? ""
//                let newUser = User(id: id, age: age, name: name, location: location, email: email)
//                print(email)
//                if email != currentUserEmail {
//                    self.users.append(newUser)
//                }
//
//            }
            
     
            let allUsers = documents.map { (queryDocumentSnapshot) -> User in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let name = data["name"] as? String ?? ""
                let age = data["age"] as? String ?? ""
                let location = data["location"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                print(email)
                print(location)
//                if email != currentUserEmail {
                return User(id: id, age: age, name: name, location: location, email: email)
//                }
            }
            
            self.users = allUsers.filter{user in return user.email != currentUserEmail}
        })
        
    }
    
}



struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
