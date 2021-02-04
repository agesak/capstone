//
//  MenuView.swift
//  gymbuddies
//
//  Created by Kareha on 1/27/21.
//

import SwiftUI


struct MenuView: View {
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
            Spacer()
        }.padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .edgesIgnoringSafeArea(.all)
            }
        }


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}


