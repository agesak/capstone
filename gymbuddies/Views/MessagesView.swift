//
//  MessagesView.swift
//  gymbuddies
//
//  Created by Kareha on 2/2/21.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI
import URLImage

struct MainMessagesView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @EnvironmentObject var datas : MainObservable
    @Binding var show : Bool
    @Binding var chat : Bool
    @Binding var uid : String
    @Binding var name : String
    @Binding var pic :String
    @Binding var location : String
    
    var body: some View {
        
        ZStack{
            if colorScheme == .dark {
                Image("barbell-cropped").resizable().ignoresSafeArea().opacity(0.1)
            } else {
                Image("barbell-cropped").resizable().ignoresSafeArea().opacity(0.1)
            }
            NavigationLink(destination: ChatView(name: self.name, uid: self.uid, pic: self.pic, chat: self.$chat), isActive: self.$chat) {
                Text("")}
            Spacer()
            VStack{
                if self.datas.recents.count == 0 {
                    if self.datas.norecents{
                        Spacer()
                        Text("No Chat History")
                        Spacer()
                    }
                }
                else {
                    Spacer()
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 12) {
                            ForEach(datas.recents.sorted(by: {$0.stamp > $1.stamp})) { i in
                                Button(action: {
                                    
                                        self.uid = i.id
                                        self.name = i.name
                                        self.pic = i.pic
                                        self.chat.toggle()
                                }) {
                                    RecentCellView(name: i.name, time: i.time, date: i.date, lastmsg: i.lastmsg, pic: i.pic)
                                }
                            }
                        }
                    }.padding(.top, 5)
                }
            }
        }
    }
}

struct MessagesView: View {
    
    @EnvironmentObject var datas : MainObservable
    @State var show = false
    @State var chat = false
    @State var uid = ""
    @State var name = ""
    @State var pic = ""
    @State var location = ""
    @State var showMenu = false
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                MainMessagesView(show: self.$show, chat: self.$chat, uid: self.$uid, name: self.$name, pic: self.$pic, location: self.$location)
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
        .navigationBarTitle("Messages", displayMode: .inline)
        .navigationBarItems(leading: (Button(
            action: {withAnimation {self.showMenu.toggle()}
            }) {Image(systemName: "line.horizontal.3")
            .imageScale(.large)}),
            trailing: Button(action: {self.show.toggle()},
                             label: {Image(systemName: "square.and.pencil").resizable().frame(width: 25, height: 25)}))
        .sheet(isPresented: self.$show) {
            newChatView(name: self.$name, pic: self.$pic, uid: self.$uid, location: self.$location, show: self.$show, chat: self.$chat)}
    }
}



struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
