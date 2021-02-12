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
    @ObservedObject private var userData = getAllUsers()
    
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





struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}


struct UserCellProfileView : View {
    
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
        .background(Color(red: 135.0 / 255.0, green: 206.0 / 255.0, blue: 250.0 / 255.0).opacity(0.4).cornerRadius(10))
        .padding([.leading, .bottom, .trailing])
    }
}

//red: 65.0 / 255.0, green: 105 / 255.0, blue: 225.0 / 255.0

struct MainView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var userData = getAllUsers()

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
                if userData.empty {
                    VStack{
                        Spacer().frame(height: 180)
                        Text("No Users Yet :(")
                            .font(.title)
                        Spacer().frame(height: 80)
                        NavigationLink(
                            destination : CurrentUserProfileView()){
                            ButtonView(buttonText: "Go Home")
                            }
                        Spacer().frame(height: 100)
                    }
                } else {
                VStack{
                    ForEach(userData.users){otherUser in
                        NavigationLink(
                            destination : OtherUserProfileView(toUser: otherUser)) {
                            UserCellProfileView(user: otherUser)
                            }
                        }
                    }
                }
            }
        }
    }
}
