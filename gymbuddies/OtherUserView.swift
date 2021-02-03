//
//  OtherUserView.swift
//  gymbuddies
//
//  Created by Kareha on 1/31/21.
//

import SwiftUI

struct OtherUserView: View {
    
    var toUser:User
//    var currentUser = [User]()
    
    var body: some View {
        VStack{
            Text(toUser.name)
            
            NavigationLink(
                destination: MessageView(toUser: toUser),
                label: {Text("Message")}
            )
        }
    }
}

//struct OtherUserView_Previews: PreviewProvider {
//    static var previews: some View {
//        OtherUserView(user: user.name)
//    }
//}
