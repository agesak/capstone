//
//  EditUserView.swift
//  gymbuddies
//
//  Created by Kareha on 2/8/21.
//

import SwiftUI
import Firebase

struct EditUserView: View {
    
    var currentUser : User
    @State var name : String = ""
    @State var pronouns : String = ""
//    @State var about_me : String = ""
    @State var style : String = ""
    @State var frequency : String = ""
    @State var times : String = ""
    
    @State var shouldShowUpdateAlert = false
    
    init(currentUser: User){
        self.currentUser = currentUser
    }
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            EditFieldView(fieldName: "Name:", user: currentUser, stateVar: self.$name, defaultVal: currentUser.name)
            EditFieldView(fieldName: "Pronouns:", user: currentUser, stateVar: self.$pronouns, defaultVal: currentUser.pronouns)
            EditFieldView(fieldName: "Workout Style:", user: currentUser, stateVar: self.$style, defaultVal: currentUser.style)
            EditFieldView(fieldName: "Preferred Frequency:", user: currentUser, stateVar: self.$frequency, defaultVal: currentUser.frequency)
            EditFieldView(fieldName: "Preferred Time:", user: currentUser, stateVar: self.$times, defaultVal: currentUser.times)
            

            
//            to do- icon
            
            
            Button(action: {
                let userDictionary = [
                                    "name": self.name,
                                    "pronouns": self.pronouns,
                                    "style": self.style,
                                    "frequency": self.frequency,
                                    "times": self.times
                                    ]

                let docRef = Firestore.firestore().document("users/\(currentUser.id)")
                docRef.updateData(userDictionary as [String : Any]){ (error) in
                        if let error = error {
                            print("error = \(error)")
                        } else {
                            print("updated profile")
                            self.shouldShowUpdateAlert = true
                        }
                    }
            }) {
                Text("Update")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .frame(width: 250, height: 50)
                .background(Color(red: 135.0 / 255.0, green: 206.0 / 255.0, blue: 250.0 / 255.0))
                .cornerRadius(10.0)
                }
            
            
        }.alert(isPresented: $shouldShowUpdateAlert) {
            Alert(title: Text("Profile Updated"))}
    }
}

struct EditFieldView : View {
    
    var fieldName: String
    var user : User
    @Binding var stateVar: String
    var defaultVal: String
    
    var body: some View {
        
        HStack {
            Text(fieldName).font(.title2).fontWeight(.bold)
            TextField("", text: $stateVar)
                .onAppear {stateVar = defaultVal}
                .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
        }.padding(.leading)
        
        Divider().padding(.horizontal)
        
//        Spacer()
    }
}


struct EditUserView_Previews: PreviewProvider {
    static var previews: some View {
        EditUserView(currentUser: User(id: "", age: "30", name: "Michelle Obama", location: "Seattle, WA", pronouns: "(she/her)", frequency: "4x/week", style: "Crossfit", times: "Evening", pic: ""))
    }
}


