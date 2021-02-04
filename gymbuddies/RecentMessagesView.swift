//
//  RecentMessagesView.swift
//  gymbuddies
//
//  Created by Kareha on 2/3/21.
//

import SwiftUI
import Firebase

struct RecentMessagesView: View {
    
//    @State var showMenu = false
    
    var body: some View {
        
        MessagesView().environmentObject(MainObservable())
        
//        GeometryReader { geometry in
//            ZStack(alignment: .leading) {
//                MessagesView().environmentObject(MainObservable())
//                    .frame(width: geometry.size.width, height: geometry.size.height)
//                    .offset(x: self.showMenu ? geometry.size.width/2 : 0)
//                    .disabled(self.showMenu ? true : false)
//                if self.showMenu {
//                    MenuView()
//                        .frame(width: geometry.size.width/2)
//                        .transition(.move(edge: .leading))
//                }
//            }
//        }
////            .navigationBarBackButtonHidden(true)
//        .navigationBarItems(
//
//            leading: (Button(
//            action: {withAnimation {self.showMenu.toggle()}
//            }) {Image(systemName: "line.horizontal.3")
//            .imageScale(.large)}))
        
//        VStack {
//            MessagesView().environmentObject(MainObservable())
//        }
    }
}

struct RecentMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        RecentMessagesView()
    }
}

class MainObservable : ObservableObject{
    
    @Published var recents = [Recent]()
    @Published var norecetns = false
    
    init() {
        
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        
        db.collection("users").document(uid!).collection("recents").order(by: "date", descending: true).addSnapshotListener { (snap, err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                self.norecetns = true
                return
            }
            
            if snap!.isEmpty{
                
                self.norecetns = true
            }
            
            for i in snap!.documentChanges{
                
                if i.type == .added{
                    let id = i.document.documentID
                    let name = i.document.get("name") as! String
    //                let pic = i.document.get("pic") as! String
                    let lastmsg = i.document.get("lastmsg") as! String
                    let stamp = i.document.get("date") as! Timestamp
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd/MM/yy"
                    let date = formatter.string(from: stamp.dateValue())
                    
                    formatter.dateFormat = "hh:mm a"
                    let time = formatter.string(from: stamp.dateValue())
                    
                    self.recents.append(Recent(id: id, name: name, lastmsg: lastmsg, time: time, date: date, stamp: stamp.dateValue()))
                }
                
                
                if i.type == .modified{
                    let id = i.document.documentID
                    let lastmsg = i.document.get("lastmsg") as! String
                    let stamp = i.document.get("date") as! Timestamp
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd/MM/yy"
                    let date = formatter.string(from: stamp.dateValue())
                    
                    formatter.dateFormat = "hh:mm a"
                    let time = formatter.string(from: stamp.dateValue())
                    
                    for j in 0..<self.recents.count{
                        
                        if self.recents[j].id == id{
                            
                            self.recents[j].lastmsg = lastmsg
                            self.recents[j].time = time
                            self.recents[j].date = date
                            self.recents[j].stamp = stamp.dateValue()
                        }
                    }
                }
            }
        }
    }
    
}


struct Recent : Identifiable {
    
    var id : String
    var name : String
//    var pic : String
    var lastmsg : String
    var time : String
    var date : String
    var stamp : Date
}
