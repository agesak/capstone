//
//  UsersView.swift
//  gymbuddies
//
//  Created by Kareha on 1/29/21.
//

import SwiftUI
import Firebase
import URLImage

struct User: Identifiable{
    var id: String = UUID().uuidString
    var age:String
    var name:String
    var location:String
    var pronouns:String
    var frequency:String
    var style:String
    var times:String
    var pic:String
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
    func getData(){
        let db = Firestore.firestore()
        
        db.collection("users").addSnapshotListener( {querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("error fetching documents: \(error!)")
                return
            }
            let allUsers = documents.map { (queryDocumentSnapshot) -> User in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let name = data["name"] as? String ?? ""
                let age = data["age"] as? String ?? ""
                let location = data["location"] as? String ?? ""
                let pronouns = data["pronouns"] as? String ?? ""
                let frequency = data["frequency"] as? String ?? ""
                let style = data["style"] as? String ?? ""
                let times = data["times"] as? String ?? ""
                let pic = data["pic"] as? String ?? ""
                return User(id: id, age: age, name: name, location: location, pronouns: pronouns, frequency: frequency, style: style, times: times, pic: pic)
            }
            
            self.users = allUsers.filter{user in return user.id != Auth.auth().currentUser!.uid}
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
    
    var body : some View {
        
        HStack{
            
            URLImage(url: URL(string: user.pic)!) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }.frame(width: 100.0, height: 100.0)
            
//            Image(systemName: "person")
//            AnimatedImage(url: URL(string: url)!).resizable().renderingMode(.original).frame(width: 55, height: 55).clipShape(Circle())
//
            VStack{
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text(user.name).foregroundColor(.black)
                        Text(user.location).foregroundColor(.gray)
                        
                        HStack{
    //                        ideally user.style, frequency, number of people?
                            Text(user.style)
                            Text(user.frequency)
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
