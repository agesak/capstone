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
//    @State var style : String = ""
    @State var frequency : String = ""
    @State var times : String = ""
    
    @State var styleChoices = ["HIIT", "Crossfit", "Running", "Yoga"]
    @State private var styleIndex = 0
    
    @State var timesChoices = ["Morning", "Afternoon", "Evening"]
    @State private var timesIndex = 0
    
    @State var frequencyChoices = ["1x/week", "2x/week", "3x/week", "4x/week", "5-6x/week"]
    @State private var frequencyIndex = 0
    
    @State var shouldShowUpdateAlert = false
    
    @State var selectStyle = false
    @State var selectTimes = false
    @State var selectFrequency = false
    
    init(currentUser: User){
        self.currentUser = currentUser
    }
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            
            EditFieldView(fieldName: "Name:", user: currentUser, stateVar: self.$name, defaultVal: currentUser.name)
            EditFieldView(fieldName: "Pronouns:", user: currentUser, stateVar: self.$pronouns, defaultVal: currentUser.pronouns)
            

            
            PickerView(fieldName: "Workout Style", stateListVar: self.$styleChoices, stateIndexVar: self.$styleIndex, pickingVar: self.$selectStyle)
            PickerView(fieldName: "Preferred Frequency", stateListVar: self.$frequencyChoices, stateIndexVar: self.$frequencyIndex, pickingVar: self.$selectFrequency)
            PickerView(fieldName: "Preferred Time", stateListVar: self.$timesChoices, stateIndexVar: self.$timesIndex, pickingVar: self.$selectTimes)

            

            
//            to do- icon
            
            
            Button(action: {
                let userDictionary = [
                                    "name": self.name,
                                    "pronouns": self.pronouns,
                                    "style":  self.styleChoices[self.styleIndex],
                                    "frequency": self.frequencyChoices[self.frequencyIndex],
                                    "times": self.timesChoices[self.timesIndex]
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
//            }
            
            
        }.alert(isPresented: $shouldShowUpdateAlert) {
            Alert(title: Text("Profile Updated"))}
    }
}


struct PickerView: View {

    var fieldName : String
    @Binding var stateListVar: [String]
    @Binding var stateIndexVar: Int
    @Binding var pickingVar : Bool

    var body: some View {

        HStack{
            Text(fieldName).font(.title2).fontWeight(.bold).padding(.leading)
            Spacer()
            Text("Select")
            Image(systemName: pickingVar ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6).padding(.trailing).onTapGesture {
                self.pickingVar.toggle()
            }
        }
        if Bool(pickingVar){
            Section {
                Picker(selection: $stateIndexVar, label: Text("")) {
                    ForEach(0 ..< stateListVar.count) {
                        Text(self.stateListVar[$0])
                    }
                }
            }
        }
        Divider().padding(.horizontal)
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


