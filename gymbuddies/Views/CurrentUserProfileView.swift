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
        
            ZStack(alignment: .bottom){
                Image("barbell-header")
                    .resizable()
                    .frame(height: sizeOfImage)
                    .opacity(0.1)
                    .ignoresSafeArea()
                
                VStack{
                    HStack{
                       if URL(string: userData.user.pic) != nil {
                           URLImage(url: URL(string: userData.user.pic)!) { image in
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
                                Text("\(userData.user.name)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Text("\(userData.user.pronouns)")
                                    .font(.title2)
                            }
                            Text("\(userData.user.location)")
                        }.padding(.trailing, 40)
                        Spacer()
                    }
                }
            }.padding(.bottom, 10)
            
            HStack{
                Spacer()
                userIconView(imageName: "barbell-icon")
                userIconView(imageName: "barbell-icon")
                userIconView(imageName: "barbell-icon")
            }
            
            VStack(alignment: .leading){
            Text("About Me")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer().frame(height: 10)
                
                Text(userData.user.aboutMe)
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
                        .fontWeight(.bold)
                    Text("\(userData.user.age)")
                    Spacer()
                }
                Spacer().frame(height: 10)
                
                HStack(){
                    Text("Workout Style:")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("\(userData.user.style)")
                    Spacer()
                }
                Spacer().frame(height: 10)
                
                HStack(){
                    Text("Preferred Time:").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("\(userData.user.times)")
                }
                Spacer().frame(height: 10)
                
                HStack(){
                    Text("Preferred Frequency:").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("\(userData.user.frequency)")
                }
                Spacer().frame(height: 10)
                
            }.padding(.leading)
            .padding(.top, 10)
            
            Spacer().frame(height: 10)
            

            Button(action: {
                self.showEditPage.toggle()
                    }) {
                ButtonView(buttonText: "Edit")
                    }.sheet(isPresented: $showEditPage) {
                        EditUserView(currentUser: userData.user)
                    }
            
            Spacer().frame(height: 200)
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




