//
//  RecentMessagesView.swift
//  gymbuddies
//
//  Created by Kareha on 2/3/21.
//

import SwiftUI
import Firebase

struct RecentMessagesView: View {
    var body: some View {
        MessagesView().environmentObject(MainObservable())
    }
}

struct RecentMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        RecentMessagesView()
    }
}



