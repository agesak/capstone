//
//  MessagesView.swift
//  gymbuddies
//
//  Created by Kareha on 2/2/21.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct MessagesView: View {
    
    @EnvironmentObject var datas : MainObservable
    @State var show = false
    @State var chat = false
    @State var uid = ""
    @State var name = ""
    @State var pic = ""
    @State var location = ""
    
    
    var body: some View {
        ZStack{
            
            NavigationLink(destination: ChatView(name: self.name, uid: self.uid, chat: self.$chat), isActive: self.$chat) {
                
                Text("")}
                
                
                VStack{
                    if self.datas.recents.count == 0 {
//                        Indicator()
                        if self.datas.norecetns{
                            Text("No Chat History")
                        }
                    }
                    else {
                    
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 12) {
                                ForEach(datas.recents) { i in
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
                }.navigationBarTitle("Home",displayMode: .inline)
                .navigationBarItems(
                    leading: Button(action: {}, label: {
                                    Text("Sign Out")}),
                    trailing: Button(action: {self.show.toggle()},
                                     label: {Image(systemName: "square.and.pencil").resizable().frame(width: 25, height: 25)})
                )
        }.sheet(isPresented: self.$show) {
            newChatView(name: self.$name, uid: self.$uid, location: self.$location, show: self.$show, chat: self.$chat)}
}



struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}




struct RecentCellView : View {
//    var url : String
    var name : String
    var time : String
    var date : String
    var lastmsg : String
    
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
    @Binding var show : Bool
    @Binding var chat : Bool
    
    var body : some View{
        
        VStack(alignment: .leading){

                if self.datas.users.count == 0{
                    
                    if self.datas.empty{
                        
                        Text("No Users Found")
                    }
//                    else{
//
//                        Indicator()
//                    }
                    
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
                                    self.show.toggle()
                                    self.chat.toggle()
                                    
                                    
                                }) {
                                    
                                    UserCellView(name: i.name, location: i.location)
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
                let email = i.get("email") as! String
                
                
//                MARK - maybe this breaks?
                if id != self.user?.uid {
                    
                    self.users.append(User(id: id, age: age, name: name, location: location, email: email))

                }
                
            }
            
        }
        
    }
    
}



//struct User: Identifiable{
//    var id: String = UUID().uuidString
//    var age:String
//    var name:String
//    var location:String
//    var email:String
//}


struct UserCellView : View {
    
//    var url : String
    var name : String
    var location : String
    
    var body : some View{
            
        HStack{
            
            Image(systemName: "person")
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
                                if i.user == uid {
                                    
                                    Spacer()
                                    Text(i.msg).padding().clipShape(ChatBubble(mymsg: true)).foregroundColor(.white)
                                        .background(Color.blue)
                                    
                                } else {
                                    
                                    Text(i.msg).padding().clipShape(ChatBubble(mymsg: true)).foregroundColor(.white)
                                        .background(Color.green)
                                    
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
                        sendMsg(user: self.name, uid: self.uid, date: Date(), msg: self.txt)
                        self.txt = ""
                    }) {
                        Text("Send")
                    }
                }.navigationBarTitle("\(name)", displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                        self.chat.toggle()
                    }, label: {
                        Image(systemName: "arrow.left").resizable().frame(width: 20, height: 15)
                    }))
            
            }.onAppear {
                self.getMsgs()
            }
    }
    
//    }
    
    func getMsgs(){
        
        let db = Firestore.firestore()
        
        let uid = Auth.auth().currentUser?.uid
        
        
        db.collection("msgs").document(uid!).collection(self.uid).order(by: "date", descending: false).getDocuments { (snap, err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                self.nomsgs = true
                return
            }
            
            if snap!.isEmpty{

                self.nomsgs = true
            }
            
            for i in snap!.documents{
                
                let id = i.documentID
                let msg = i.get("msg") as! String
                let user = i.get("user") as! String
                
                self.msgs.append(Msg(id: id, msg: msg, user: user))
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
    
    func path(in rect: CGRect) -> Path {
            
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight,mymsg ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: 16, height: 16))
        
        return Path(path.cgPath)
    }
}


func sendMsg(user: String, uid: String, date: Date, msg: String){
    let db = Firestore.firestore()
    
    let myuid = Auth.auth().currentUser?.uid
    
    db.collection("users").document(uid).collection("recents").document(myuid!).getDocument { (snap, err) in
     
        if err != nil{
            
            print((err?.localizedDescription)!)
            // if there is no recents records....
            
//            setRecents(user: user, uid: uid, pic: pic, msg: msg, date: date)
            return
        }
        
        if !snap!.exists{
            setRecents(user: user, uid: uid, msg: msg, date: date)
        } else {
            updateRecents(uid: uid, lastmsg: msg, date: date)
        }
        
    }
    updateDB(uid: uid, msg: msg, date: date)
}

func setRecents(user: String, uid: String, msg: String, date: Date){
    
    
    let db = Firestore.firestore()
    
    let myuid = Auth.auth().currentUser?.uid
    
    
//    MARK - this should prbly be name
    let name = Auth.auth().currentUser?.email
    
    db.collection("users").document(uid).collection("recents").document(myuid!).setData(["name":name!, "lastmsg":msg, "date":date]) { (err) in
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
