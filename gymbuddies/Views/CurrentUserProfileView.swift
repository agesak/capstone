//
//  UserView.swift
//  gymbuddies
//
//  Created by Kareha on 1/27/21.
//

import SwiftUI
import Firebase
import URLImage

struct MainUserView: View {
    
    @State var showEditPage = false
    @State var name : String = ""
    @State var sizeOfImage: CGFloat = UIScreen.main.bounds.height/2.5
    @ObservedObject var userData = getCurrentUser()

    init(){
        userData.getUser()
    }
    
    var body: some View {
        
        VStack {
            MainProfilePageView(user: userData.user)
            Button(action: {
                self.showEditPage.toggle()
                    }) {
                ButtonView(buttonText: "Edit")
                    }.sheet(isPresented: $showEditPage) {
                        EditUserView(currentUser: userData.user)
                    }
            Spacer().frame(height: 150)
        }
    }
}

struct CurrentUserProfileView: View {
    
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
                                            .imageScale(.large)}))
            .navigationBarBackButtonHidden(true)
        }
        
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserProfileView()
    }
}




