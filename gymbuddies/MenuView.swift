//
//  MenuView.swift
//  gymbuddies
//
//  Created by Kareha on 1/27/21.
//

import SwiftUI
import Firebase


struct MenuView: View {
    
    @State var isLinkActive = false
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink(
                destination: UserView(),
                label: {
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                        Text("Profile")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }.padding(.top, 100)
                    })
            NavigationLink(
                destination: RecentMessagesView(),
                label: {
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                        Text("Messages")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }.padding(.top, 30)
                    })
            NavigationLink(
                destination: UsersView(),
                label: {
                    HStack {
                        Image(systemName: "person.2")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                        Text("Browse Users")
                            .foregroundColor(.gray)
                            .font(.headline)
                    }.padding(.top, 30)
                    })
            NavigationLink(
                destination: HomeView(),
                isActive: self.$isLinkActive) {
                HStack {
                    Image(systemName: "hand.wave")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text("Sign Out")
                        .foregroundColor(.gray)
                        .font(.headline)
                }.padding(.top, 30)
                .onTapGesture {
                    self.isLinkActive = true
                    signOut()
                }
            }
//            .navigationBarBackButtonHidden(true)

        Spacer()
        }.padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .edgesIgnoringSafeArea(.all)
    }
    
    func signOut(){
        do {
            try Auth.auth().signOut()
            print("signed out")
//            print(Auth.auth().currentUser!)
//            self.session = nil
//            self.users = []
//            self.messages = [Message]()
//            self.messagesDictionary = [String:Message]()
        } catch {
            print("Error signing out")
            print(Auth.auth().currentUser!)
        }
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
