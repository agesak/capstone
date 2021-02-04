//
//  ThisUserView.swift
//  gymbuddies
//
//  Created by Kareha on 2/3/21.
//

import SwiftUI
import Firebase

//struct ThisUserView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}


//ARCHIVE!!!
struct ThisUserView: View {
    
    @State var showMenu = false
    
    var body: some View {

//        NavigationView{
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
//                    showMenu: self.$showMenu
                    MainThisUserView()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                        .disabled(self.showMenu ? true : false)
                    if self.showMenu {
                        MenuView()
                            .frame(width: geometry.size.width/2)
                            .transition(.move(edge: .leading))
                    }
                }
//            }
//            .navigationBarTitle("User", displayMode: .inline)
            .navigationBarItems(leading: (Button(
                                            action: {withAnimation {self.showMenu.toggle()}
                                            }) {Image(systemName: "line.horizontal.3")
                                            .imageScale(.large)}),
                                trailing: (Button(
                                            action: {print("will do this")}
                                            ) {Text("Edit")}))
            .navigationBarBackButtonHidden(true)
//        }
//            .navigationBarTitle("Users", displayMode: .inline)
            
        }
        
//        ScrollView(.vertical, showsIndicators: false){
//            MainView()
//        }.navigationBarBackButtonHidden(true)
        
    }
}






struct ThisUserView_Previews: PreviewProvider {
    static var previews: some View {
        ThisUserView()
    }
}



struct MainThisUserView: View {

    let user = Auth.auth().currentUser
    
    var body: some View {
        Text("Users")
//        ScrollView(.vertical, showsIndicators: false) {
//
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                this doesn't work?
//                .multilineTextAlignment(.leading)
//            VStack{
//                ForEach(userData.users){otherUser in
//                    NavigationLink(
//                        destination : OtherUserView(toUser: otherUser)) {
//                        UserCellView(user: otherUser)
                    }
//                }
//            }
//        }
//    }
}
