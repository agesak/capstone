//
//  Messages.swift
//  gymbuddies
//
//  Created by Kareha on 2/9/21.
//

import SwiftUI


struct Recent : Identifiable {
    var id : String
    var name : String
    var pic : String
    var lastmsg : String
    var time : String
    var date : String
    var stamp : Date
}


struct Msg : Identifiable {
    var id : String
    var msg : String
    var user : String
}
