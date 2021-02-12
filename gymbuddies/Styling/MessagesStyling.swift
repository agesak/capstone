//
//  MessagesStyling.swift
//  gymbuddies
//
//  Created by Kareha on 2/11/21.
//

import SwiftUI
import Firebase
import URLImage

struct RecentCellView : View {
    var name : String
    var time : String
    var date : String
    var lastmsg : String
    var pic : String
    
    var body : some View {
        
        HStack{
            if URL(string: pic) != nil {
             URLImage(url: URL(string: pic)!) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.leading)
                }.frame(width: 55.0, height: 55.0)
            } else {
                Image(systemName: "person")
                    .frame(width: 55.0, height: 55.0)
                    .padding(.leading)
            }

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
                }.padding(.trailing)
                Divider()
                    .padding(.trailing)
            }
        }
    }
}

struct newChatView : View {
    
    @ObservedObject var datas = getAllUsers()
    @Binding var name : String
    @Binding var pic : String
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
                    .frame(width: 55.0, height: 55.0)
            }
            
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

struct ChatView : View {
    
    var name : String
    var uid : String
    var pic : String
    
    @Binding var chat : Bool
    @State var msgs = [Msg]()
    @State var txt = ""
    @State var nomsgs = false
    @ObservedObject var userData = getCurrentUser()
    
    init(name: String, uid: String, pic: String, chat: Binding<Bool>){
        self._chat = chat
        self.name = name
        self.uid = uid
        self.pic = pic
        userData.getUser()
    }
    
    var body : some View{
        VStack{
            if msgs.count == 0{
                if self.nomsgs{
                    Text("Start New Conversation").foregroundColor(Color.black.opacity(0.5)).padding(.top, 5)
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
                                        .padding(.trailing, 10)
                                } else {
                                    Text(i.msg)
                                        .padding()
                                        .background(Color.green)
                                        .clipShape(ChatBubble(mymsg: false))
                                        .foregroundColor(.white)
                                        .padding(.leading, 10)
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
                        sendMsg(user: self.name, uid: self.uid, date: Date(), msg: self.txt, myName: userData.user.name, myPic: userData.user.pic, pic: self.pic)
                        self.txt = ""
                    }) {
                        Text("Send")
                    }
                }.navigationBarTitle("\(name)", displayMode: .inline)
                .padding([.horizontal, .bottom])
            }.onAppear {
                self.getMsgs()
            }
    }
    
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


func setRecents(user: String, uid: String, msg: String, date: Date, myName: String, myPic: String, pic: String){
    let db = Firestore.firestore()
    let myuid = Auth.auth().currentUser?.uid
    db.collection("users").document(uid).collection("recents").document(myuid!).setData(["name":myName, "lastmsg":msg, "date":date, "pic":myPic]) { (err) in
        if err != nil{
            print((err?.localizedDescription)!)
            return
        }
    }
    db.collection("users").document(myuid!).collection("recents").document(uid).setData(["name":user, "lastmsg":msg, "date":date, "pic":pic]) { (err) in
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


struct ChatBubble : Shape {
    var mymsg : Bool
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight,mymsg ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: 16, height: 16))
        return Path(path.cgPath)
    }
}


func sendMsg(user: String, uid: String, date: Date, msg: String, myName: String, myPic: String, pic: String){
    let db = Firestore.firestore()
    let myuid = Auth.auth().currentUser?.uid
    db.collection("users").document(uid).collection("recents").document(myuid!).getDocument { (snap, err) in
        if err != nil{
            print((err?.localizedDescription)!)
            setRecents(user: user, uid: uid, msg: msg, date: date, myName: myName, myPic: myPic, pic: pic)
            return
        }
        if !snap!.exists{
            setRecents(user: user, uid: uid, msg: msg, date: date, myName: myName, myPic: myPic, pic: pic)
        } else {
            updateRecents(uid: uid, lastmsg: msg, date: date)
        }
    }
    updateDB(uid: uid, msg: msg, date: date)
}
