//
//  UserProfile.swift
//  gymbuddies
//
//  Created by Kareha on 2/11/21.
//

import SwiftUI

struct userIconView : View {
    var imageName: String
    var body : some View {
        Image(imageName)
            .resizable()
            .frame(width: 30.0, height: 30.0)
        Spacer()
    }
}



