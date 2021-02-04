//
//  UsersView.swift
//  gymbuddies
//
//  Created by Kareha on 1/29/21.
//

import SwiftUI
import Firebase
//import Foundation

struct User: Identifiable{
    var id: String = UUID().uuidString
    var age:String
    var name:String
    var location:String
    var email:String
}

struct UsersView: View {
    
    @State var showMenu = false
    @ObservedObject private var userData = getUserData()
    
    var body: some View {

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
//                    showMenu: self.$showMenu
                    MainView()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                        .disabled(self.showMenu ? true : false)
                    if self.showMenu {
                        MenuView()
                            .frame(width: geometry.size.width/2)
                            .transition(.move(edge: .leading))
                    }
                }
            }.navigationBarBackButtonHidden(true)
//            .navigationBarTitle("Users", displayMode: .inline)
            .navigationBarItems(leading: (Button(
                action: {withAnimation {self.showMenu.toggle()}
                }) {Image(systemName: "line.horizontal.3")
                .imageScale(.large)}))
//        }
        
//        ScrollView(.vertical, showsIndicators: false){
//            MainView()
//        }.navigationBarBackButtonHidden(true)
        
    }
}


class getUserData: ObservableObject {
    @Published var users = [User]()
//    @Published var currentUser = [User]()

//    func getCurrentUser() -> String {
//        let currentUserData = Auth.auth().currentUser
//        print("current user's email: \(currentUserData!.email!)")
//        return currentUserData!.email!
//    }
//
    func getData(){
        let db = Firestore.firestore()
//        let currentUserEmail = getCurrentUser()
        
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
                return User(id: id, age: age, name: name, location: location, email: email)
            }
            
            self.users = allUsers.filter{user in return user.id != Auth.auth().currentUser!.uid}
//            self.users = allUsers.filter{user in return user.email != currentUserEmail}
//            self.currentUser = allUsers.filter{user in return user.email == currentUserEmail}
        })
        
    }
    
}



struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}


struct UserCellView : View {
    var user : User
//    var name : String
//    var time : String
//    var date : String
//    var lastmsg : String
    
    var body : some View {
        
        HStack{
            
            Image(systemName: "person")
//            AnimatedImage(url: URL(string: url)!).resizable().renderingMode(.original).frame(width: 55, height: 55).clipShape(Circle())
//
            VStack{
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text(user.name).foregroundColor(.black)
                        Text(user.location).foregroundColor(.gray)
                        
                        HStack{
    //                        ideally user.style, frequency, number of people?
                            Text(user.email)
                            Text(user.age)
                        }
                    }
                    
                    Spacer()
                    
//                    VStack(alignment: .leading, spacing: 6) {
//
//                         Text(date).foregroundColor(.gray)
//                         Text(time).foregroundColor(.gray)
//                    }
                }
                
                Divider()
            }
        }
        
    }
}

struct MainView: View {
    
    @ObservedObject private var userData = getUserData()
//    @Binding var showMenu: Bool
    
//    showMenu: Binding<Bool>
    init() {
//        self._showMenu = showMenu
        userData.getData()
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Text("Users")
                .font(.largeTitle)
                .fontWeight(.bold)
//                this doesn't work?
                .multilineTextAlignment(.leading)
            VStack{
                ForEach(userData.users){otherUser in
                    NavigationLink(
                        destination : OtherUserView(toUser: otherUser)) {
                        UserCellView(user: otherUser)
                    }
                }
            }
        }
    }
}
