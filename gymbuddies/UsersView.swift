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
        
//        return NavigationView{
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    MainView(showMenu: self.$showMenu)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                        .disabled(self.showMenu ? true : false)
//                        .navigationTitle("Users")
                    if self.showMenu {
                        MenuView()
                            .frame(width: geometry.size.width/2)
                            .transition(.move(edge: .leading))
                    }
                }
            }.navigationBarBackButtonHidden(true)
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


//class MainObservable : ObservableObject{
//
//    @Published var recents = [Recent]()
//    @Published var norecetns = false
//    @ObservedObject private var userData = getUserData()
//
//    init() {
//
//        let db = Firestore.firestore()
//        let uid = Auth.auth().currentUser?.uid
//
//        db.collection("users").document(uid!).collection("recents").order(by: "date", descending: true).addSnapshotListener { (snap, err) in
//
//            if err != nil{
//
//                print((err?.localizedDescription)!)
//                self.norecetns = true
//                return
//            }
//
//            if snap!.isEmpty{
//
//                self.norecetns = true
//            }
//
//            for i in snap!.documentChanges{
//
//                if i.type == .added{
//                    let id = i.document.documentID
//                    let name = i.document.get("name") as! String
//    //                let pic = i.document.get("pic") as! String
//                    let lastmsg = i.document.get("lastmsg") as! String
//                    let stamp = i.document.get("date") as! Timestamp
//
//                    let formatter = DateFormatter()
//                    formatter.dateFormat = "dd/MM/yy"
//                    let date = formatter.string(from: stamp.dateValue())
//
//                    formatter.dateFormat = "hh:mm a"
//                    let time = formatter.string(from: stamp.dateValue())
//
//                    self.recents.append(Recent(id: id, name: name, lastmsg: lastmsg, time: time, date: date, stamp: stamp.dateValue()))
//                }
//
//
//                if i.type == .modified{
//                    let id = i.document.documentID
//                    let lastmsg = i.document.get("lastmsg") as! String
//                    let stamp = i.document.get("date") as! Timestamp
//
//                    let formatter = DateFormatter()
//                    formatter.dateFormat = "dd/MM/yy"
//                    let date = formatter.string(from: stamp.dateValue())
//
//                    formatter.dateFormat = "hh:mm a"
//                    let time = formatter.string(from: stamp.dateValue())
//
//                    for j in 0..<self.recents.count{
//
//                        if self.recents[j].id == id{
//
//                            self.recents[j].lastmsg = lastmsg
//                            self.recents[j].time = time
//                            self.recents[j].date = date
//                            self.recents[j].stamp = stamp.dateValue()
//                        }
//                    }
//                }
//            }
//        }
//    }
//
//}
//
//
//struct Recent : Identifiable {
//
//    var id : String
//    var name : String
////    var pic : String
//    var lastmsg : String
//    var time : String
//    var date : String
//    var stamp : Date
//}

struct MainView: View {
    
    @ObservedObject private var userData = getUserData()
    @Binding var showMenu: Bool
    
    init(showMenu: Binding<Bool>) {
        self._showMenu = showMenu
        userData.getData()
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Text("Users")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
            VStack{
                //                for otherUser in userData.users {
                //                    NavigationLink(
                //                        destination : OtherUserView(toUser: otherUser)) {
                //                        UserCellView(user: otherUser)
                //                        }
                //                }
                

                
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
