//
//  OtherUserView.swift
//  gymbuddies
//
//  Created by Kareha on 1/31/21.
//

import SwiftUI

struct OtherUserView: View {
    
    var user:User
    
    var body: some View {
        VStack{
            Text(user.name)
        }
    }
}

//struct OtherUserView_Previews: PreviewProvider {
//    static var previews: some View {
//        OtherUserView(user: user.name)
//    }
//}
