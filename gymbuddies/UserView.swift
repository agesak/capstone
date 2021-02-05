//
//  UserView.swift
//  gymbuddies
//
//  Created by Kareha on 1/27/21.
//

//current user's profile
import SwiftUI
import Firebase
import URLImage

struct UserView: View {
    
    @State var showMenu = false
    private var db = Firestore.firestore()
    @ObservedObject var userData = getCurrentUser()
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                MainUserView()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                    .disabled(self.showMenu ? true : false)
                if self.showMenu {
                    MenuView()
                        .frame(width: geometry.size.width/2)
                        .transition(.move(edge: .leading))
                }
            }.navigationBarItems(leading: (Button(
                                            action: {withAnimation {self.showMenu.toggle()}
                                            }) {Image(systemName: "line.horizontal.3")
                                            .imageScale(.large)}),
                                trailing: (Button(
                                            action: {print("will do this")}
                                            ) {Text("Edit")}))
                        
                        .navigationBarBackButtonHidden(true)
        }
        
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
            
    }
}

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
            self.user = User(id: document.documentID, age: data!["age"] as! String, name: data!["name"] as! String, location: data!["location"] as! String, pronouns: data!["pronouns"] as! String, frequency: data!["frequency"] as! String, style: data!["style"] as! String, times: data!["times"] as! String, pic: data!["pic"] as! String)
          })
    }
}

struct MainUserView: View {
    
    
    @State var name : String = ""
    @ObservedObject var userData = getCurrentUser()
    
    init(){
        userData.getUser()
        print(userData.user.pic)
    }
    
    
    var body: some View {
        VStack {
        
//           I HAVE NO IDEA WHY THIS IF STATEMENT IS NECESSARY BUT WITHOUT IT EVERYTHING BREAKS
            if URL(string: userData.user.pic) != nil {
                URLImage(url: URL(string: userData.user.pic)!) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }.frame(width: 100.0, height: 100.0)
            } else {
                Text("idk it was nil?")
            }
            
            Text(userData.user.name)
            
            
            

            
//            if user != nil {
//                Text(user.)
//                Text(user!.uid)
//                Text("Profile Information")
//                VStack(alignment: .leading){
//                    Text("Name").font(.headline).fontWeight(.light)
//                    TextField("Enter your Name", text: $name)
//                    .autocapitalization(.none)
//                    Divider()
//                }
//
//                Button(action: {
//                    let userDictionary = [
//                        "name": self.name,
//                    ]
//
//                    let docRef = Firestore.firestore().document("users/\(user!.uid)")
//                        print("setting data")
//                        docRef.setData(userDictionary){ (error) in
//                            if let error = error {
//                                print("error = \(error)")
//                            } else {
//                                self.name = ""
//                            }
//                        }
//                }) { Text("Update Profile")}
//            }
        }
    }
}


