//
//  MessageView.swift
//  gymbuddies
//
//  Created by Kareha on 2/1/21.
//

import Foundation
import SwiftUI
import Firebase

struct MessageView: View {
    
    @ObservedObject var viewModel = MessagesViewModel()
    
    var toUser:User?
    var currentUser = [User]()
    
    @State var messageField : String = ""
    var body: some View {
        VStack {
            List(viewModel.messages){ message in
                HStack {
                    Text(message.msg)
                }
            }
            HStack {
                TextField("Enter message...", text: $messageField)
                Button(action: {viewModel.sendMessage(messageContent: messageField)}, label: {
                    Text("Send")
                })
            }
        }.onAppear(perform:
            completeViewModelSetUp
        )
    }
    
    func completeViewModelSetUp() {
        viewModel.setUsers(user1: toUser!, user2: currentUser[0])
    }
}

//struct MessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageView()
//    }
//}

struct Message: Codable, Identifiable{
    var id: String?
    var from: String
    var to: String
    var msg: String
    var timeStamp: Date
}

class MessagesViewModel: ObservableObject {
    @Published var messages = [Message]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    
    var toUser:User?
    var currentUser:User?
    
    func sendMessage(messageContent: String) {
        if (user != nil) {
            db.collection("chat").addDocument(data: [
                                                    "timeStamp": Date(),
                                                    "msg": messageContent,
                                                "from": currentUser!.id,
                                                "to": toUser!.id])
        }
    }
    
    func setUsers(user1: User, user2: User){
        toUser = user1
        currentUser = user2
        fetchData()
    }

    
    func fetchData(){
        if (user != nil) {
            db.collection("chat").whereField("from", in: [currentUser!.id, toUser!.id]).addSnapshotListener({(snapshot, error) in
                guard let documents = snapshot?.documents else {
                    print("no documents")
                    return
                }
                
                self.messages = documents.map { docSnapshot -> Message in
                    let data = docSnapshot.data()
                    let docId = docSnapshot.documentID
                    let content = data["msg"] as? String ?? ""
                    let from = data["from"] as? String ?? ""
                    let to = data["to"] as? String ?? ""
                    let timeStamp = data["date"] as? Date ?? Date()
                    return Message(id: docId, from: from, to: to, msg: content, timeStamp: timeStamp)

                }
            }
            )
        }
    }
}
