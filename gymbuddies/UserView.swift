//
//  UserView.swift
//  gymbuddies
//
//  Created by Kareha on 1/27/21.
//

//current user's profile
import SwiftUI
import Firebase

struct UserView: View {
    
    @State var showMenu = false
    private var db = Firestore.firestore()
    
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


struct MainUserView: View {
    
    let user = Auth.auth().currentUser
    @State var name : String = ""
    
    var body: some View {
        VStack {
            
            Text("hello world")
            
            if user != nil {
                Text(user!.email!)
                Text(user!.uid)
                Text("Profile Information")
                VStack(alignment: .leading){
                    Text("Name").font(.headline).fontWeight(.light)
                    TextField("Enter your Name", text: $name)
                    .autocapitalization(.none)
                    Divider()
                }

                Button(action: {
                    let userDictionary = [
                        "name": self.name,
                    ]

                    let docRef = Firestore.firestore().document("users/\(user!.uid)")
                        print("setting data")
                        docRef.setData(userDictionary){ (error) in
                            if let error = error {
                                print("error = \(error)")
                            } else {
                                self.name = ""
                            }
                        }
                }) { Text("Update Profile")}
            }
        }
    }
}
