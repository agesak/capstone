//
//  Users.swift
//  gymbuddies
//
//  Created by Kareha on 2/10/21.
//

import SwiftUI

struct User: Identifiable{
    var id: String = UUID().uuidString
    var age:String = ""
    var name:String = ""
    var location:String = ""
    var pronouns:String = ""
    var aboutMe: String = ""
    var frequency:String = ""
    var style:String = ""
    var times:String = ""
    var pic:String = ""
}
