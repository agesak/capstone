//
//  UserView.swift
//  gymbuddies
//
//  Created by Kareha on 1/27/21.
//

import SwiftUI
import Firebase
import URLImage

struct UserView: View {
    
    @State var showMenu = false
    
    private var db = Firestore.firestore()
    @ObservedObject var userData = getCurrentUser()

    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
//                MainUserView(showEditPage: self.$showEditPage)
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
        UserView()
            
    }
}

class getCurrentUser : ObservableObject{
    @Published var user = User()

    func getUser(){
        let db = Firestore.firestore()
        
        db.document("users/\(Auth.auth().currentUser!.uid)")
        .addSnapshotListener({ documentSnapshot, error in
            guard let document = documentSnapshot else {
            print("Error fetching document: \(error!)")
            return
          }
            let data = document.data()
            self.user = User(id: document.documentID, age: data!["age"] as! String, name: data!["name"] as! String, location: data!["location"] as! String, pronouns: data!["pronouns"] as! String, frequency: data!["frequency"] as! String, style: data!["style"] as! String, times: data!["times"] as! String, pic: data!["pic"] as! String)
          })
    }
}

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
                       } else {
                           Image(systemName: "photo")
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
//                            Text("30")
                            Text("\(userData.user.location)")
                        }.padding(.trailing, 40)
                        Spacer()
                    }
                }
            }.padding(.bottom, 10)
//            Spacer().frame(height: 30)
            
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
//                .padding([.top, .leading])
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer().frame(height: 10)
                
                Text("I am your forever first lady. I started the Just Move campaign that featured a song with Beyoncé. I am missed by the reasonable American public.")
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
//                    Text("4x/week")
                    Text("\(userData.user.frequency)")
                }
                Spacer().frame(height: 10)
                
            }.padding(.leading)
            .padding(.top, 10)
            
            Spacer().frame(height: 10)
            

            Button(action: {
                self.showEditPage.toggle()
                    }) {
                        Text("Edit")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 250, height: 50)
                        .background(Color(red: 135.0 / 255.0, green: 206.0 / 255.0, blue: 250.0 / 255.0))
                        .cornerRadius(10.0)
                    }.sheet(isPresented: $showEditPage) {
                        EditUserView(currentUser: userData.user)
                    }
            
            Spacer().frame(height: 200)
        }
    }
}
