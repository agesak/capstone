//
//  OtherUserView.swift
//  gymbuddies
//
//  Created by Kareha on 1/31/21.
//

import SwiftUI
import Firebase
import URLImage

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
            
            ZStack(alignment: .bottom){
                Image("barbell-header")
                    .resizable()
                    .frame(height: sizeOfImage)
                    .opacity(0.1)
                    .ignoresSafeArea()
                
                VStack{
                    HStack{
                       if URL(string: toUser.pic) != nil {
                        URLImage(url: URL(string: toUser.pic)!) { image in
                               image
                                   .resizable()
                                   .aspectRatio(contentMode: .fit)
                           }.frame(width: 100.0, height: 100.0)
                        .padding(.leading)
                       } else {
                           Image(systemName: "photo")
                            .padding(.leading)
                       }
                      Spacer()
                        
                        VStack(alignment: .leading) {
                            HStack(){
                                Text("\(toUser.name)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Text("\(toUser.pronouns)")
                                    .font(.title2)
                            }
                            Text("\(toUser.location)")
                        }
                        Spacer()
                    }
                }
            }.padding(.bottom, 10)
            
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
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer().frame(height: 10)
                
                Text(toUser.aboutMe)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding([.leading, .bottom])
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .overlay(
                        RoundedCorner(radius: 10.0, corners: [.allCorners])
                             .stroke(Color.secondary)
                             .shadow(color: .secondary, radius: 3, x: 0, y: 0))
            }.padding(.horizontal)
            
            VStack(alignment: .leading){
                HStack(){
                    Text("Age:")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("\(toUser.age)")
                    Spacer()
                }
                Spacer().frame(height: 10)
                
                HStack(){
                    Text("Workout Style:")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("\(toUser.style)")
                    Spacer()
                }
                Spacer().frame(height: 10)
                
                HStack(){
                    Text("Preferred Time:").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("\(toUser.times)")
                }
                Spacer().frame(height: 10)
                
                HStack(){
                    Text("Preferred Frequency:").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("\(toUser.frequency)")
                }
                Spacer().frame(height: 10)
            }.padding(.leading)
            
            Spacer().frame(height: 10)
            
            NavigationLink(destination: ChatView(name: toUser.name, uid: toUser.id, pic: toUser.pic, chat: self.$chat), isActive: self.$show) {
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
