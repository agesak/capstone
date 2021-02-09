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
                MainView(show: self.$show, chat: self.$chat, uid: self.$uid, name: self.$name, pic: self.$pic, location: self.$location)
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
        .navigationBarItems(leading: (Button(
            action: {withAnimation {self.showMenu.toggle()}
            }) {Image(systemName: "line.horizontal.3")
            .imageScale(.large)}),
            trailing: Button(action: {self.show.toggle()},
                             label: {Image(systemName: "square.and.pencil").resizable().frame(width: 25, height: 25)}))
        .sheet(isPresented: self.$show) {
            newChatView(name: self.$name, uid: self.$uid, location: self.$location, pic: self.$pic, show: self.$show, chat: self.$chat)}
}



struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}

    
struct MainView: View {
    
    @EnvironmentObject var datas : MainObservable
    @Binding var show : Bool
    @Binding var chat : Bool
    @Binding var uid : String
    @Binding var name : String
    @Binding var pic :String
    @Binding var location : String
    
    var body: some View {
        
        ZStack{
            NavigationLink(destination: ChatView(name: self.name, uid: self.uid, chat: self.$chat), isActive: self.$chat) {
                Text("")}
                
            Spacer()
                
            VStack{
                Spacer()
                if self.datas.recents.count == 0 {
                    if self.datas.norecetns{
                        Text("No Chat History")
                    }
                }
                else {
                    Spacer()
                    ScrollView(.vertical, showsIndicators: false) {
                        Text("Messages")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        VStack(spacing: 12) {
                            ForEach(datas.recents.sorted(by: {$0.stamp > $1.stamp})) { i in
                                Button(action: {
                                    
                                        self.uid = i.id
                                        self.name = i.name
                                        self.chat.toggle()
                                }) {
                                        
                                    RecentCellView(name: i.name, time: i.time, date: i.date, lastmsg: i.lastmsg)
                                }
                            }
                        }
                    }
                }
            }
//            .sheet(isPresented: self.$show) {
//                newChatView(name: self.$name, uid: self.$uid, location: self.$location, show: self.$show, chat: self.$chat)}
        }
    }
}



struct RecentCellView : View {
    var name : String
    var time : String
    var date : String
    var lastmsg : String
//    var pic : String
    
    var body : some View {
        
        HStack{
            
            Image(systemName: "person")
//            AnimatedImage(url: URL(string: url)!).resizable().renderingMode(.original).frame(width: 55, height: 55).clipShape(Circle())
//
            VStack{
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text(name).foregroundColor(.black)
                        Text(lastmsg).foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                         Text(date).foregroundColor(.gray)
                         Text(time).foregroundColor(.gray)
                    }
                }
                
                Divider()
            }
        }
        
    }
}


struct newChatView : View {
    
    @ObservedObject var datas = getAllUsers()
    @Binding var name : String
    @Binding var uid : String
    @Binding var location : String
    @Binding var pic : String
    @Binding var show : Bool
    @Binding var chat : Bool
    
    var body : some View{
        
        VStack(alignment: .leading){

                if self.datas.users.count == 0{
                    
                    if self.datas.empty{
                        
                        Text("No Users Found")
                    }
                    
                }
                else{
                    
                    Text("Select To Chat").font(.title).foregroundColor(Color.black.opacity(0.5))
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack(spacing: 12){
                            
                            ForEach(datas.users){i in
                                
                                Button(action: {
                                    
                                    self.uid = i.id
                                    self.name = i.name
                                    self.location = i.location
                                    self.pic = i.pic
                                    self.show.toggle()
                                    self.chat.toggle()
                                    
                                    
                                }) {
                                    
                                    UserCellView(name: i.name, location: i.location, pic: i.pic)
                                }
                                
                                
                            }
                            
                        }
                        
                    }
              }
        }.padding()
        
    }
    
}

class getAllUsers : ObservableObject{
    @Published var users = [User]()
    @Published var empty = false
    private let user = Auth.auth().currentUser
    
    
    init() {
        
        let db = Firestore.firestore()
        
        db.collection("users").getDocuments { (snap, err) in

            if err != nil{
                
                print((err?.localizedDescription)!)
                self.empty = true
                return
            }
            
            
            for i in snap!.documents{
                
                let id = i.documentID
                let name = i.get("name") as! String
                let age = i.get("age") as! String
                let location = i.get("location") as! String
                let pronouns = i.get("pronouns") as! String
                let frequency = i.get("frequency") as! String
                let style = i.get("style") as! String
                let times = i.get("times") as! String
                let pic = i.get("pic") as! String
//                let email = i.get("email") as! String
                
                
//                MARK - maybe this breaks?
                if id != self.user?.uid {
                    
                    self.users.append(User(id: id, age: age, name: name, location: location, pronouns: pronouns, frequency: frequency, style: style, times: times, pic: pic))

                }
                
            }
            
        }
        
    }
    
}


struct UserCellView : View {

    var name : String
    var location : String
    var pic : String
    
    var body : some View{
            
        HStack{
            
            if URL(string: pic) != nil {
             URLImage(url: URL(string: pic)!) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }.frame(width: 55.0, height: 55.0)
            } else {
                Image(systemName: "person")
            }
            
//            Image(systemName: "person")
//            AnimatedImage(url: URL(string: url)!).resizable().renderingMode(.original).frame(width: 55, height: 55).clipShape(Circle())
            
            VStack{
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text(name).foregroundColor(.black)
                        Text(location).foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                }
                
                Divider()
            }
            }
        }
    }
}


struct ChatView : View {
    
    var name : String
    var uid : String
    @Binding var chat : Bool
    @State var msgs = [Msg]()
    @State var txt = ""
    @State var nomsgs = false
    
    @ObservedObject var userData = getCurrentUser()
    
    init(name: String, uid: String, chat: Binding<Bool>){
        self._chat = chat
        self.name = name
        self.uid = uid
        userData.getUser()
//        print(userData.user.pic)
    }
    
    
//    struct AmountView : View {
//        @Binding var amount: Double
//
//        private var includeDecimal = false
//
//        init(amount: Binding<Double>) {
//
//            // self.$amount = amount // beta 3
//            self._amount = amount // beta 4
//
//            self.includeDecimal = round(self.amount)-self.amount > 0
//        }
//    }
    
    var body : some View{
        
        VStack{
            

    //            if msgs.count == 0{
    //                Spacer()
    //                Indicator()
    //                Spacer()
    //            } else {
            
            if msgs.count == 0{
                if self.nomsgs{
                    Text("Start New Conversation !!!").foregroundColor(Color.black.opacity(0.5)).padding(.top)
                    
                    Spacer()
                }
            } else {
                
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 8){
                        ForEach(self.msgs){i in
                            HStack{
                                if i.user != uid {
                                    
                                    Spacer()
                                    Text(i.msg)
                                        .padding()
                                        .background(Color.blue)
                                        .clipShape(ChatBubble(mymsg: true))
                                        .foregroundColor(.white)
                                        
                                } else {
                                    
                                    Text(i.msg)
                                        .padding()
                                        .background(Color.green)
                                        .clipShape(ChatBubble(mymsg: true))
                                        .foregroundColor(.white)
                                        
                                    Spacer()
                                    
                                }
                            }
                        }
                    }
                }
            }
                
                HStack{
                    TextField("Enter Message", text: self.$txt).textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        sendMsg(user: self.name, uid: self.uid, date: Date(), msg: self.txt, myName: userData.user.name)
                        self.txt = ""
                    }) {
                        Text("Send")
                    }
                }.navigationBarTitle("\(name)", displayMode: .inline)
//                .navigationBarItems(leading: Button(action: {
//                        self.chat.toggle()
//                    }, label: {
//                        Image(systemName: "arrow.left").resizable().frame(width: 20, height: 15)
//                    }))
            
            }.onAppear {
                self.getMsgs()
            }
    }
    
//    }
    
    func getMsgs(){
        
        let db = Firestore.firestore()
        
        let uid = Auth.auth().currentUser?.uid
        
        db.collection("msgs").document(uid!).collection(self.uid).order(by: "date", descending: false).addSnapshotListener { (snap, err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                self.nomsgs = true
                return
            }
            
            if snap!.isEmpty{
                
                self.nomsgs = true
            }
            
            for i in snap!.documentChanges{
                
                if i.type == .added{
                    
                    
                    let id = i.document.documentID
                    let msg = i.document.get("msg") as! String
                    let user = i.document.get("user") as! String
                    
                    self.msgs.append(Msg(id: id, msg: msg, user: user))
                }

            }
        }
    }
}


struct Msg : Identifiable {
    
    var id : String
    var msg : String
    var user : String
}


struct ChatBubble : Shape {
    
    var mymsg : Bool
    //    from UserView
    
    func path(in rect: CGRect) -> Path {
            
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight,mymsg ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: 16, height: 16))
        
        return Path(path.cgPath)
    }
}


func sendMsg(user: String, uid: String, date: Date, msg: String, myName: String){
    let db = Firestore.firestore()
    
    let myuid = Auth.auth().currentUser?.uid
    
    db.collection("users").document(uid).collection("recents").document(myuid!).getDocument { (snap, err) in
     
        if err != nil{
            
            print((err?.localizedDescription)!)
            // if there is no recents records....
            
            setRecents(user: user, uid: uid, msg: msg, date: date, myName: myName)
            return
        }
        
        if !snap!.exists{
            setRecents(user: user, uid: uid, msg: msg, date: date, myName: myName)
        } else {
            updateRecents(uid: uid, lastmsg: msg, date: date)
        }
        
    }
    updateDB(uid: uid, msg: msg, date: date)
}


func setRecents(user: String, uid: String, msg: String, date: Date, myName: String){
    
    let db = Firestore.firestore()
    
    let myuid = Auth.auth().currentUser?.uid
    
    db.collection("users").document(uid).collection("recents").document(myuid!).setData(["name":myName, "lastmsg":msg, "date":date]) { (err) in
        if err != nil{
            
            print((err?.localizedDescription)!)
            return
        }
    }
    
    db.collection("users").document(myuid!).collection("recents").document(uid).setData(["name":user, "lastmsg":msg, "date":date]) { (err) in
        
        if err != nil{
            
            print((err?.localizedDescription)!)
            return
        }
    }
}

func updateRecents(uid: String, lastmsg: String, date: Date){
    let db = Firestore.firestore()
    let myuid = Auth.auth().currentUser?.uid
    db.collection("users").document(uid).collection("recents").document(myuid!).updateData(["lastmsg":lastmsg,"date":date])
    db.collection("users").document(myuid!).collection("recents").document(uid).updateData(["lastmsg":lastmsg,"date":date])
}


func updateDB(uid: String, msg: String, date: Date){
    
    let db = Firestore.firestore()
    let myuid = Auth.auth().currentUser?.uid
    
    db.collection("msgs").document(uid).collection(myuid!).document().setData(["msg":msg, "user":myuid!, "date":date]) { (err) in
        
        if err != nil{
            print((err?.localizedDescription)!)
            return
        }
    }
    
    db.collection("msgs").document(myuid!).collection(uid).document().setData(["msg":msg, "user":myuid!, "date":date]) { (err) in
        
        if err != nil{
            print((err?.localizedDescription)!)
            return
        }
    }
}
