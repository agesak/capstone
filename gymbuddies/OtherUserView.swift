//
//  OtherUserView.swift
//  gymbuddies
//
//  Created by Kareha on 1/31/21.
//

import SwiftUI
import Firebase
import URLImage



struct OtherUserView: View {
    
    var toUser:User
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
//                                 ,
//                                trailing: (Button(
//                                            action: {print("will do this")}
//                                            ) {Text("Edit")})
            )
            .navigationBarBackButtonHidden(true)
        }
        
    }
}

struct OtherUserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
            
    }
}


struct MainOtherUserView: View {
    
    var toUser:User
    @Binding var show : Bool
    @Binding var chat : Bool
    @State var sizeOfImage: CGFloat = UIScreen.main.bounds.height/3
    
    init(toUser: User, chat: Binding<Bool>, show: Binding<Bool>){
        self._chat = chat
        self._show = show
        self.toUser = toUser
    }

    var body: some View {
        
        VStack {
            
            ZStack{
                Image("barbell-header")
                    .resizable()
                    .frame(height: sizeOfImage)
                    .opacity(0.1)
                    .ignoresSafeArea()
                
                VStack{
                    Spacer().frame(height: 90)
                    HStack{
                       if URL(string: toUser.pic) != nil {
                        URLImage(url: URL(string: toUser.pic)!) { image in
                               image
                                   .resizable()
                                   .aspectRatio(contentMode: .fit)
                           }.frame(width: 100.0, height: 100.0)
                       } else {
                           Image(systemName: "photo")
                       }
                      Spacer()
                        
                        VStack(alignment: .leading) {
                            HStack(){
                                Text("\(toUser.name)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Text("\(toUser.pronouns)")
                                    .fontWeight(.bold)
                            }
                            Text("\(toUser.location)")
                        }
                        Spacer()
                    }
                }
            }
            Spacer().frame(height: 30)
            
            HStack{
                Spacer()

                Image("barbell-icon")
                    .resizable()
                    .frame(width: 30.0, height: 30.0)

                Spacer()

                Image("barbell-icon")
                    .resizable()
                    .frame(width: 30.0, height: 30.0)

                Spacer()

                Image("barbell-icon")
                    .resizable()
                    .frame(width: 30.0, height: 30.0)

                Spacer()
            }
            
            VStack(alignment: .leading){
            Text("About Me")
                .font(.title)
                .fontWeight(.semibold)
                .padding([.top, .leading])
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer().frame(height: 10)
                
                Text("I am your forever first lady. I started the Just Move campaign that featured a song with Beyoncé. I am missed by the reasonable American public.")
                    .fixedSize(horizontal: false, vertical: true)
                    .padding([.leading, .bottom])
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            VStack(alignment: .leading){
                HStack(){
                    Text("Workout Style:")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("\(toUser.style)")
                    Spacer()
                }
                HStack(){
                    Text("Preferred Time:").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("\(toUser.times)")
                }
                
                HStack(){
                    Text("Preferred Frequency:").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("\(toUser.frequency)")
                }
            }.padding(.leading)
            
            Spacer().frame(height: 60)
            
            NavigationLink(destination: ChatView(name: toUser.name, uid: toUser.id, chat: self.$chat), isActive: self.$show) {
                            Text("Message")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 250, height: 50)
                            .background(Color(red: 135.0 / 255.0, green: 206.0 / 255.0, blue: 250.0 / 255.0))
                            .cornerRadius(10.0)}
            Spacer().frame(height: 200)
        }
    }
}

//struct OtherUserView: View {
//    
//    var toUser:User
//    
//    var body: some View {
//        VStack{
//            Text(toUser.name)
//            
//            URLImage(url: URL(string: toUser.pic)!) { image in
//                image
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//            }.frame(width: 100.0, height: 100.0)
//            
//            NavigationLink(
//                destination: MessageView(toUser: toUser),
//                label: {Text("Message")}
//            )
//        }
//    }
//}

//struct OtherUserView_Previews: PreviewProvider {
//    static var previews: some View {
//        OtherUserView(user: user.name)
//    }
//}
