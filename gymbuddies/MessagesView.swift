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
    
    var body: some View {
        
        VStack{
//            if self.datas.recents.count == 0 {
//                Indicator()
//            }
//            else {
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 12) {
                    ForEach(datas.recents) { i in
                        RecentCellView(url: i.pic, name: i.name, time: i.time, date: i.date, lastmsg: i.lastmsg)
                    }
                }
            }
        }
//    }

    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}

class MainObservable : ObservableObject{
    
    @Published var recents = [Recent]()
    @Published var norecetns = false
    @ObservedObject private var userData = getUserData()
    
    init() {
        
        let db = Firestore.firestore()
//        let uid = Auth.auth().currentUser?.uid
        
        db.collection("users").document(userData.currentUser[0].id).collection("recents").order(by: "date", descending: true).addSnapshotListener { (snap, err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                self.norecetns = true
                return
            }
            
            for i in snap!.documentChanges{
                
                let id = i.document.documentID
                let name = i.document.get("name") as! String
                let pic = i.document.get("pic") as! String
                let lastmsg = i.document.get("lastmsg") as! String
                let stamp = i.document.get("date") as! Timestamp
                
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yy"
                let date = formatter.string(from: stamp.dateValue())
                
                formatter.dateFormat = "hh:mm a"
                let time = formatter.string(from: stamp.dateValue())
                
                self.recents.append(Recent(id: id, name: name, pic: pic, lastmsg: lastmsg, time: time, date: date, stamp: stamp.dateValue()))
                
            }
            
            
        }
    }
    
}

struct Recent : Identifiable {
    
    var id : String
    var name : String
    var pic : String
    var lastmsg : String
    var time : String
    var date : String
    var stamp : Date
}

struct RecentCellView : View {
    var url : String
    var name : String
    var time : String
    var date : String
    var lastmsg : String
    
    var body : some View {
        
        HStack{
            
            AnimatedImage(url: URL(string: url)!).resizable().renderingMode(.original).frame(width: 55, height: 55).clipShape(Circle())
            
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
