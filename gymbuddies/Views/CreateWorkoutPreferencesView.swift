//
//  CreateWorkoutPreferencesView.swift
//  gymbuddies
//
//  Created by Kareha on 2/4/21.
//

import SwiftUI
import Firebase

struct SelectorView: View {

    var fieldName : String
    @Binding var stateListVar: [String]
    @Binding var stateIndexVar: Int
    @Binding var pickingVar : Bool

    var body: some View {
        HStack{
            Text(fieldName).font(.title2).fontWeight(.bold).padding(.leading)
            Spacer()
            HStack{
                Text(stateListVar[stateIndexVar])
                Image(systemName: pickingVar ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6).padding(.trailing)
            }.onTapGesture {
                self.pickingVar.toggle()
                print("tapped")
                print(self.pickingVar)
            }
        }
        if Bool(pickingVar){
            Section {
                Picker(selection: self.$stateIndexVar, label: Text("")) {
                    ForEach(0 ..< stateListVar.count) {
                        Text(self.stateListVar[$0])
                    }
                }
            }
        }
        Divider().padding(.horizontal)
    }
}

struct CreateWorkoutPreferencesView: View {
    
    @State var times = ["Morning", "Afternoon", "Evening"]
    @State private var timesIndex = 0
    
    @State var style = ["HIIT", "Crossfit", "Running", "Yoga"]
    @State private var styleIndex = 0
    
    @State var frequency = ["1x/week", "2x/week", "3x/week", "4x/week", "5-6x/week"]
    @State private var frequencyIndex = 0
    
    @State private var isprofileValid: Bool = false
    @State private var shouldShowProfileAlert: Bool = false
    
    @State var selectStyle = false
    @State var selectTimes = false
    @State var selectFrequency = false
    
    let user = Auth.auth().currentUser
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        ZStack{
            
            Image("barbell-cropped").resizable().opacity(0.1).ignoresSafeArea()
//            .aspectRatio(contentMode: .fill)
        
            VStack(){
//                Spacer().frame(height: 50)
                Text("Workout Style?")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                Spacer().frame(height: 100)
                SelectorView(fieldName: "Style?", stateListVar: self.$style, stateIndexVar: self.$styleIndex, pickingVar: self.$selectStyle)
                SelectorView(fieldName: "When?", stateListVar: self.$times, stateIndexVar: self.$timesIndex, pickingVar: self.$selectTimes)
                SelectorView(fieldName: "How Often?", stateListVar: self.$frequency, stateIndexVar: self.$frequencyIndex, pickingVar: self.$selectFrequency)
                Spacer().frame(height: 90)
//                Form{
//                    Section {
//                        Picker(selection: $styleIndex, label: Text("Preferred Workout Style")) {
//                            ForEach(0 ..< style.count) {
//                                Text(self.style[$0])
//                            }
//                        }
//                    }
//
//
//                    Section{
//                            Picker(selection: $timesIndex, label: Text("When?")) {
//                                ForEach(0 ..< times.count) {
//                                    Text(self.times[$0])
//                                }
//                            }
//                        }
//
//
//                    Section{
//
//                        Picker(selection: $frequencyIndex, label: Text("How Often?")) {
//                            ForEach(0 ..< frequency.count) {
//                                Text(self.frequency[$0])
//                            }
//                        }
//                    }
//                }
//                .foregroundColor(Color.black)
//                .navigationBarTitle("Workout Style?")
                
                NavigationLink(
                    destination: SelectIconPhotoView(),
                    isActive: self.$isprofileValid) {
                    ButtonView(buttonText: "Continue")
                            .onTapGesture {
                                let userDictionary = [
                                    "times": self.times[self.timesIndex],
                                    "style": self.style[self.styleIndex],
                                    "frequency": self.frequency[self.frequencyIndex]
                                ]
                                let docRef = Firestore.firestore().document("users/\(user!.uid)")
                                docRef.updateData(userDictionary as [String : Any]){ (error) in
                                        if let error = error {
                                            print("error = \(error)")
                                            self.isprofileValid = false
                                        } else {
                                            print("it ran")
                                            self.isprofileValid = true
                                        }
                                    }
                            }
                    }
                Spacer().frame(height: 100)
            }
        }.alert(isPresented: $shouldShowProfileAlert) {
            Alert(title: Text("Error Creating Profile"))}
    }
}

struct CreateWorkoutPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        CreateWorkoutPreferencesView()
    }
}
