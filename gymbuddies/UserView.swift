//
//  UserView.swift
//  gymbuddies
//
//  Created by Kareha on 1/27/21.
//

//current user's profile
import SwiftUI
import Firebase
import URLImage

struct UserView: View {
    
    @State var showMenu = false
    @State var show = true
    @State var chat = true
    private var db = Firestore.firestore()
    @ObservedObject var userData = getCurrentUser()

    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                MainUserView(chat: self.$chat, show: self.$show)
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
                                            .imageScale(.large)}),
                                trailing: (Button(
                                            action: {print("will do this")}
                                            ) {Text("Edit")}))
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
    
    @Binding var show : Bool
    @Binding var chat : Bool
    @State var name : String = ""
    @State var sizeOfImage: CGFloat = UIScreen.main.bounds.height/3
    @ObservedObject var userData = getCurrentUser()
    
    init(chat: Binding<Bool>, show: Binding<Bool>){
        self._chat = chat
        self._show = show
        userData.getUser()
        
        print(userData.user.pic)
    }
    
    
    var body: some View {
        
        VStack {
            
//                       I HAVE NO IDEA WHY THIS IF STATEMENT IS NECESSARY BUT WITHOUT IT EVERYTHING BREAKS
//        if URL(string: userData.user.pic) != nil {
//            URLImage(url: URL(string: userData.user.pic)!) { image in
//                image
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//            }.frame(width: 100.0, height: 100.0)
//        } else {
//            Text("idk it was nil?")
//        }

        Text(userData.user.name)
            

            Image("barbell-header")
                .resizable()
                .frame(height: sizeOfImage)
                .opacity(0.1)
                .ignoresSafeArea()
            
            HStack{
            
//                I HAVE NO IDEA WHY THIS IF STATEMENT IS NECESSARY BUT WITHOUT IT EVERYTHING BREAKS
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
                        Text("Michelle Obama")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("(she/her)")
                            .fontWeight(.bold)
                    }
                    
                    
                    Text("Seattle, WA")
                        
                }
                
                Spacer()
                
                
            }
            
//            Spacer()
            
//            HStack{
//                Spacer()
//                
//                Image("barbell-icon")
//                    .resizable()
//                    .frame(width: 30.0, height: 30.0)
//                
//                Spacer()
//                
//                Image("barbell-icon")
//                    .resizable()
//                    .frame(width: 30.0, height: 30.0)
//                
//                Spacer()
//                
//                Image("barbell-icon")
//                    .resizable()
//                    .frame(width: 30.0, height: 30.0)
//                
//                Spacer()
//            }
            
            VStack(alignment: .leading){
            Text("About Me")
                .font(.title)
                .fontWeight(.medium)
                .padding([.top, .leading])
                .frame(maxWidth: .infinity, alignment: .leading)
//                . multilineTextAlignment(.leading)
                
                Text("I am your forever first lady. I started the Just Move campaign that featured a song with Beyoncé. I am missed by the reasonable American public.")
                    .padding([.leading, .bottom])
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            //                .alignmentGuide(.leading) { dimension in
            //                    dimension[.top]
            //                }
            
            ////                .scaledToFill()
            //            , alignment: .top
            //
            //                .aspectRatio(contentMode: .fit)
            //                .frame(width: 200, height: 200, alignment: .top)
            //                .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            //                    sizeOfImage = UIScreen.main.bounds.height/2  }
            
            VStack(alignment: .leading){
                HStack(){
                    Text("Workout Style:")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                        .frame(alignment: .leading)
                    Text("\(userData.user.style)")
                    Spacer()
                }
                HStack(){
                    Text("Preferred Time:").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("\(userData.user.times)")
                }
                
                HStack(){
                    Text("Preferred Frequency:").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("\(userData.user.frequency)")
                }
            }
//            .padding(.leading)
            
            NavigationLink(destination: ChatView(name: userData.user.name, uid: userData.user.id, chat: self.$chat), isActive: self.$show) {
                Text("")}
            
//            NavigationLink({
//                Text("Message")
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//                    .padding()
//                    .frame(width: 250, height: 50)
//                    //                for custom divide rbg by 255
//                    .background(Color(red: 135.0 / 255.0, green: 206.0 / 255.0, blue: 250.0 / 255.0))
//                    .cornerRadius(10.0)
//
//            }, destination: ChatView(name: userData.user.name, uid: userData.user.id, chat: self.chat), tag: self.show
            
            
            //            NavigationLink(
            //               destination: SignInView(),
            //               label: {
            //                   Text("Message")
            //                   .font(.title)
            //                   .fontWeight(.bold)
            //                   .foregroundColor(.white)
            //                   .padding()
            //                 .frame(width: 250, height: 50)
            //   //                for custom divide rbg by 255
            //                   .background(Color(red: 135.0 / 255.0, green: 206.0 / 255.0, blue: 250.0 / 255.0))
            //                 .cornerRadius(10.0)
            //               })
            
//            selection:
            Spacer()
            
            
        }
    }
}


