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
 
    func getData(){
        let db = Firestore.firestore()
        
        db.collection("users").addSnapshotListener( {querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("error fetching documents: \(error!)")
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



struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
