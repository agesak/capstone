//
//  OtherUserView.swift
//  gymbuddies
//
//  Created by Kareha on 1/31/21.
//

import SwiftUI
import Firebase
import URLImage

struct MainOtherUserView: View {
    
    var toUser:User
    @Binding var show : Bool
    @Binding var chat : Bool
    @State var sizeOfImage: CGFloat = UIScreen.main.bounds.height/2.5
    
    init(toUser: User, chat: Binding<Bool>, show: Binding<Bool>){
        self._chat = chat
        self._show = show
        self.toUser = toUser
    }

    var body: some View {
        
        VStack {
            MainProfilePageView(user: toUser)
            NavigationLink(destination:
                            ChatView(name: toUser.name, uid: toUser.id, pic: toUser.pic, chat: self.$chat), isActive: self.$show)
                          {ButtonView(buttonText: "Message")}
            Spacer().frame(height: 150)
        }
    }
}

struct OtherUserProfileView: View {
    
    var toUser : User
    @State var showMenu = false
    @State var show = false
    @State var chat = true
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                MainOtherUserView(toUser: toUser, chat: self.$chat, show: self.$show)
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
                                            .imageScale(.large)})
            )
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct OtherUserView_Previews: PreviewProvider {
    static var previews: some View {
        OtherUserProfileView(toUser: User(id: "", age: "30", name: "Michelle Obama", location: "Seattle, WA", pronouns: "(she/her)", aboutMe: "I am your forever first lady. I started the Just Move campaign that featured a song with Beyoncé. I am missed by the reasonable American public.", frequency: "4x/week", style: "Crossfit", times: "Evening", pic: "https://gymbuddiescapstone.s3-us-west-1.amazonaws.com/yoga.png"))
    }
}
