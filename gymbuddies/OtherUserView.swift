//
//  OtherUserView.swift
//  gymbuddies
//
//  Created by Kareha on 1/31/21.
//

import SwiftUI
import URLImage

struct OtherUserView: View {
    
    var toUser:User
    
    var body: some View {
        VStack{
            Text(toUser.name)
            
            URLImage(url: URL(string: toUser.pic)!) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }.frame(width: 100.0, height: 100.0)
            
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
