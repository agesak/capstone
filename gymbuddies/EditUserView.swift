//
//  EditUserView.swift
//  gymbuddies
//
//  Created by Kareha on 2/8/21.
//

import SwiftUI

struct EditUserView: View {
    
    var currentUser : User
    @State var name : String = ""
    
//    var model:String    // Actual a more complex view model
//    @State var editedValue: String
//
//    init(model: String) {
//        self.model = model
//        self._editedValue = State(wrappedValue: model) // _editedValue is State<String>
//    }
    
//    name: String
    init(currentUser: User){
        self.currentUser = currentUser
//        self.name = name
//        self._show = show
//        self.toUser = toUser
    }
    
    var body: some View {
        
        
        Text("Name").font(.headline).fontWeight(.light)
        TextField("Enter your Email Address", text: $name)
            .onAppear {self.name = currentUser.name}
    }
}

//struct EditUserView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditUserView()
//    }
//}
