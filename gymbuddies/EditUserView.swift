//
//  EditUserView.swift
//  gymbuddies
//
//  Created by Kareha on 2/8/21.
//

import SwiftUI
import Firebase
import URLImage


class Picker_Model:ObservableObject{
    @Published var indexVal = 0
}

//class Picker_Model2:ObservableObject{
//    var varInterest : String
//    var arrayInterest : [String]
//    @Published var val : Int
//
//    init(varInterest: String, arrayInterest: [String]){
//        self.varInterest = varInterest
//        self.arrayInterest = arrayInterest
//        self.val = arrayInterest.firstIndex(of: varInterest)!
//    }
////    @Published var indexVal = 1
//}


struct EditUserView: View {
    
    @ObservedObject var pickerModal = Picker_Model()
//    @ObservedObject var model2 = Picker_Model2(varInterest: <#T##String#>, arrayInterest: <#T##[String]#>)
    @Environment(\.presentationMode) var presentationMode
    
    var currentUser : User
    @State var name : String = ""
    @State var pronouns : String = ""
//    @State var about_me : String = ""
    
    @State var frequency : String = ""
    @State var times : String = ""
    
    @State var styleChoices = ["HIIT", "Crossfit", "Running", "Yoga"]
    @State var style = ""
    @State private var styleIndex = 0
    
    @State var timesChoices = ["Morning", "Afternoon", "Evening"]
    @State private var timesIndex = 0
    
    @State var frequencyChoices = ["1x/week", "2x/week", "3x/week", "4x/week", "5-6x/week"]
    @State private var frequencyIndex = 0
    
    @State var shouldShowUpdateAlert = false
    
    @State var selectStyle = false
    @State var styleChanged = false
    @State var selectTimes = false
    @State var selectFrequency = false
    
    init(currentUser: User){
        self.currentUser = currentUser
        self._style = State(initialValue: currentUser.style )
    }
//    init(todoList: TodoList) {
//            self.todoList = todoList
//            self._title = State(initialValue: todoList.title ?? "")
//            self._color = State(initialValue: todoList.color ?? "None")
//        }
    var body: some View {
        
        NavigationView{
            
            
            VStack{
                Text("Edit Profile")
                    .font(.largeTitle)
                VStack {
                    ZStack(alignment: .bottom) {
                        if URL(string: currentUser.pic) != nil {
                            URLImage(url: URL(string: currentUser.pic)!) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }.frame(width: 100.0, height: 100.0)
                        } else {
                            Image(systemName: "photo")
                        }

                        NavigationLink(
                            destination: SelectIconPhoto(),
                            label: {
                                Text("Change Icon")
                                    .foregroundColor(.white)
                                    .frame(width: 100, height: 30)
                                    .background(Color.black)
                        })
                    }
                }

                EditFieldView(fieldName: "Name:", user: currentUser, stateVar: self.$name, defaultVal: currentUser.name)
                EditFieldView(fieldName: "Pronouns:", user: currentUser, stateVar: self.$pronouns, defaultVal: currentUser.pronouns).autocapitalization(.none)
                
//                Text("you picked: \(self.style == "" ? currentUser.style : styleChoices[self.pickerModal.indexVal])")
//                Text(styleChoices[self.pickerModal.indexVal])
//                VStack {
//                            Picker(selection: self.$pickerModal.indexVal,
//                                   label: Text("")) {
//                                ForEach(0 ..< self.styleChoices.count)     {Text(self.styleChoices[$0]).tag($0)}
//                            }
//                }
//
                
                HStack{
                    Text("Workout Style").font(.title2).fontWeight(.bold).padding(.leading)
                    Spacer()
                    Text(self.style)
//                    Text("\(self.style == "" ? currentUser.style : styleChoices[self.pickerModal.indexVal])")
                    Image(systemName: self.selectStyle ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6).padding(.trailing).onTapGesture {
                        self.selectStyle.toggle()
                    }
                }
                if self.selectStyle{
                    Section {
                        Picker(selection: self.$pickerModal.indexVal, label: Text("")) {
                            ForEach(0 ..< self.styleChoices.count) {
                                Text(self.styleChoices[$0])
                            }
                        }.onTapGesture {
                            self.style = self.styleChoices[self.pickerModal.indexVal]
                            self.styleChanged.toggle()
//                            self.$styleIndex = self.pickerModal.indexVal
                        }
                    }
                }
                
                
   
//                self.pickerModal.indexVal = styleChoices.firstIndex(of: self.style) ?? 0
                
//                PickerView(fieldName: "Workout Style", currentVarDefault: currentUser.style, currentVar: self.$style, stateListVar: self.$styleChoices, stateIndexVar: self.$styleIndex, pickingVar: self.$selectStyle)
//                PickerView(fieldName: "Preferred Frequency", currentVarDefault: currentUser.frequency, currentVar: self.$frequency, stateListVar: self.$frequencyChoices, stateIndexVar: self.$frequencyIndex, pickingVar: self.$selectFrequency)
//                PickerView(fieldName: "Preferred Time", currentVarDefault: currentUser.times, currentVar: self.$times, stateListVar: self.$timesChoices, stateIndexVar: self.$timesIndex, pickingVar: self.$selectTimes)
                
                
//                onPickerChange(variable: self.style)
                
                
//                PickerView(fieldName: "Workout Style", currentVarDefault: currentUser.style, currentVar: self.$style,
//                           stateListVar: self.$styleChoices, stateIndexVar: self.$styleIndex, pickingVar: self.$selectStyle)
//                PickerView(fieldName: "Preferred Frequency", chosenVar: self.frequencyChoices[self.frequencyIndex], stateListVar: self.$frequencyChoices, stateIndexVar: self.$frequencyIndex, pickingVar: self.$selectFrequency)
//                PickerView(fieldName: "Preferred Time", chosenVar: self.timesChoices[self.timesIndex], stateListVar: self.$timesChoices, stateIndexVar: self.$timesIndex, pickingVar: self.$selectTimes).padding(.bottom)


                Button(action: {
                    if !styleChanged {
                        self.style = currentUser.style
                        self.styleIndex = self.styleChoices.firstIndex(of: self.style)!
                        self.pickerModal.indexVal = self.styleIndex
                    }
                    let userDictionary = [
                                        "name": self.name,
                                        "pronouns": self.pronouns,
//                        self.pickerModal.indexVal
                        "style":  self.style
//                        ,
//                                        "frequency": self.frequencyChoices[self.frequencyIndex],
//                                        "times": self.timesChoices[self.timesIndex]
                                        ]
                    
                    print(self.style)
                    let docRef = Firestore.firestore().document("users/\(currentUser.id)")
                    docRef.updateData(userDictionary as [String : Any]){ (error) in
                            if let error = error {
                                print("error = \(error)")
                            } else {
                                print("updated profile")
                                self.shouldShowUpdateAlert = true
                                print(self.style)
                                print(self.pickerModal.indexVal)
                                print(self.styleChoices.firstIndex(of: self.style))
                                self.presentationMode.wrappedValue.dismiss()
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
                
                
                Spacer().frame(height: 150)
            }
//            .alert(isPresented: $shouldShowUpdateAlert) {
//                Alert(title: Text("Profile Updated"))}
        }
    }
}



//                PickerView(fieldName: "Workout Style", currentVarDefault: currentUser.style, currentVar: self.$style,
//                           stateListVar: self.$styleChoices, stateIndexVar: self.$styleIndex, pickingVar: self.$selectStyle)

struct PickerView: View {
    @ObservedObject var pickerModal = Picker_Model()

    var fieldName : String
    var currentVarDefault : String
    @Binding var currentVar : String
    @Binding var stateListVar: [String]
    @Binding var stateIndexVar: Int
    @Binding var pickingVar : Bool

    var body: some View {
        HStack{
            Text(fieldName).font(.title2).fontWeight(.bold).padding(.leading)
            Spacer()
            Text("\(currentVar == "" ? currentVarDefault : stateListVar[self.pickerModal.indexVal])")
            Image(systemName: pickingVar ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6).padding(.trailing).onTapGesture {
                self.pickingVar.toggle()
            }
        }
        if Bool(pickingVar){
            
            Section {
                Picker(selection: self.$pickerModal.indexVal, label: Text("")) {
                    ForEach(0 ..< stateListVar.count) {
                        Text(self.stateListVar[$0])
                    }
                }
//                .onTapGesture {
                    
//                    currentVar = self.stateListVar[self.pickerModal.indexVal]
//                    stateIndexVar = self.pickerModal.indexVal
//                    print(stateIndexVar)
//                }
            }
        }
        Divider().padding(.horizontal)
        
        
//        HStack{
//            Text(fieldName).font(.title2).fontWeight(.bold).padding(.leading)
//            Spacer()
//            Text(self.$stateListVar[self.pickerModal.indexVal])
////            Text("you picked: \(styleChoices[self.pickerModal.styleIndex])")
//            VStack {
//                        Picker(selection: self.$pickerModal.indexVal,
//                               label: Text("")) {
//                            ForEach(0 ..< self.stateListVar.count)     {Text(self.styleChoices[$0]).tag($0)}
//                        }
//            }
//        }
//        HStack{
//            Text(fieldName).font(.title2).fontWeight(.bold).padding(.leading)
//            Spacer()
//            Text(currentVar == "" ? currentVarDefault : currentVar)
//            Image(systemName: pickingVar ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6).padding(.trailing).onTapGesture {
//                self.pickingVar.toggle()
//            }
//        }
//        if Bool(pickingVar){
//            Section {
//                Picker(selection: $stateIndexVar, label: Text("")) {
//                    ForEach(0 ..< stateListVar.count) {
//                        Text(self.stateListVar[$0])
//                    }
//                }
//                }.onTapGesture {
//                    self.currentVar = self.stateListVar[self.stateIndexVar]
//            }
//        }
//        Divider().padding(.horizontal)
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
        EditUserView(currentUser: User(id: "", age: "30", name: "Michelle Obama", location: "Seattle, WA", pronouns: "(she/her)", frequency: "4x/week", style: "Crossfit", times: "Evening", pic: "https://gymbuddiescapstone.s3-us-west-1.amazonaws.com/pengiun.png"))
    }
}


