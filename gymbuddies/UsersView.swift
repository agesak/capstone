//
//  UsersView.swift
//  gymbuddies
//
//  Created by Kareha on 1/29/21.
//

import SwiftUI
import Firebase
import URLImage

struct UsersView: View {
    
    @State var showMenu = false
    @ObservedObject private var userData = getUserData()
    
    var body: some View {

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
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
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: (Button(
                action: {withAnimation {self.showMenu.toggle()}
                }) {Image(systemName: "line.horizontal.3")
                .imageScale(.large)}))
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
                let aboutMe = data["aboutMe"] as? String ?? ""
                let frequency = data["frequency"] as? String ?? ""
                let style = data["style"] as? String ?? ""
                let times = data["times"] as? String ?? ""
                let pic = data["pic"] as? String ?? ""
                return User(id: id, age: age, name: name, location: location, pronouns: pronouns, aboutMe: aboutMe, frequency: frequency, style: style, times: times, pic: pic)
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
            if URL(string: user.pic) != nil {
                URLImage(url: URL(string: user.pic)!) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }.frame(width: 80.0, height: 80.0)
            }

            VStack{
                HStack{
                    VStack(alignment: .leading, spacing: 6) {

                        HStack{
                            Text(user.name).fontWeight(.bold).foregroundColor(.black)
                            Text(user.pronouns).foregroundColor(.black)
                        }
                        Text(user.location).foregroundColor(.gray)

                        HStack{
                            Text(user.style).foregroundColor(.black)
                            Text(user.frequency).foregroundColor(.black)
                        }
                    }
                    Spacer()
                }
            }
        }.padding(10)
        .background(Color(red: 135.0 / 255.0, green: 206.0 / 255.0, blue: 250.0 / 255.0).cornerRadius(25))
        .padding([.leading, .bottom, .trailing])
    }
}

//red: 65.0 / 255.0, green: 105 / 255.0, blue: 225.0 / 255.0

struct MainView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject private var userData = getUserData()

    init() {
        userData.getData()
    }
    
    var body: some View {
        
        ZStack{
            
            if colorScheme == .dark {
                Image("barbell-cropped").resizable().ignoresSafeArea().opacity(0.1)
            } else {
                Image("barbell-cropped").resizable().ignoresSafeArea().opacity(0.1)
            }
        
            ScrollView(.vertical, showsIndicators: true) {
                Text("Users")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                if userData.users.count == 0 {
                    VStack{
                        Spacer().frame(height: 180)
                        Text("No Users Yet :(")
                            .font(.title)
                        Spacer().frame(height: 80)
                        NavigationLink(
                            destination : CurrentUserProfileView()){
                            Text("Go Home")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 250, height: 50)
                                .background(Color(red: 135.0 / 255.0, green: 206.0 / 255.0, blue: 250.0 / 255.0))
                                .cornerRadius(10.0)
                            }
                        Spacer().frame(height: 100)
                    }
                } else {
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
    }
}
