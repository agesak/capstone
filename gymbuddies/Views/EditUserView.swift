//
//  EditUserView.swift
//  gymbuddies
//
//  Created by Kareha on 2/8/21.
//

import SwiftUI
import Firebase
import URLImage

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
    }
}

struct PickerView: View {

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
            Text(currentVar)
            Image(systemName: pickingVar ? "chevron.up" : "chevron.down").resizable().frame(width: 13, height: 6).padding(.trailing).onTapGesture {
                self.pickingVar.toggle()
            }
        }
        if Bool(pickingVar){
            Section {
                Picker(selection: self.$stateIndexVar, label: Text("")) {
                    ForEach(0 ..< stateListVar.count) {
                        Text(self.stateListVar[$0])
                    }
                }
                .onTapGesture {
                    currentVar = self.stateListVar[self.stateIndexVar]
                }
            }
        }
        Divider().padding(.horizontal)
    }
}



struct EditUserView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var currentUser : User
    @State var name : String = ""
    @State var pronouns : String = ""
    @State var age : String = ""
    @State var aboutMe : String = ""
    
    @State var frequency : String = ""
    @State var times : String = ""
    
    @State var styleChoices = ["HIIT", "Crossfit", "Running", "Yoga", "Pilates", "Powerlifting", "Bodybuilding", "Boxing", "Zumba", "Cycling"]
    @State var style = ""
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
        self._style = State(initialValue: currentUser.style)
        self._frequency = State(initialValue: currentUser.frequency)
        self._times = State(initialValue: currentUser.times)
    }
    

    var body: some View {
        
        NavigationView{
            
            ZStack{
            Image("barbell-cropped").resizable().ignoresSafeArea().opacity(0.1)
                
            ScrollView(.vertical, showsIndicators: true){
                
                VStack{
                    Text("Edit Profile")
                        .font(.largeTitle)
                    Group{
                    
                    VStack {
                        ZStack(alignment: .bottom) {
                            if URL(string: currentUser.pic) != nil {
                                URLImage(url: URL(string: currentUser.pic)!) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                }.frame(width: 150.0, height: 150.0)
                            } else {
                                Image(systemName: "photo")
                            }

                            NavigationLink(
                                destination: SelectIconPhotoView(),
                                label: {
                                    Text("Change Icon")
                                        .foregroundColor(.white)
                                        .frame(width: 150, height: 30)
                                        .background(Color.black)
                            })
                        }
                    }.padding(.bottom, 20)

                    EditFieldView(fieldName: "Name:", user: currentUser, stateVar: self.$name, defaultVal: currentUser.name)
                    EditFieldView(fieldName: "Pronouns:", user: currentUser, stateVar: self.$pronouns, defaultVal: currentUser.pronouns).autocapitalization(.none)
                    EditFieldView(fieldName: "Age:", user: currentUser, stateVar: self.$age, defaultVal: currentUser.age).autocapitalization(.none)
                    
                    HStack {
                        Text("About Me:")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text(self.aboutMe)
                            .foregroundColor(.clear)
                            .overlay(TextEditor(text: $aboutMe)
                                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                                        .frame(minHeight: 90.0))
                            .onAppear {self.aboutMe = currentUser.aboutMe}
                            .padding(.trailing)
                    }.padding([.leading, .top, .bottom])
                    
                    Divider().padding(.horizontal)
                    
                    PickerView(fieldName: "Workout Style", currentVarDefault: currentUser.style, currentVar: self.$style, stateListVar: self.$styleChoices, stateIndexVar: self.$styleIndex, pickingVar: self.$selectStyle)
                    PickerView(fieldName: "Preferred Frequency", currentVarDefault: currentUser.frequency, currentVar: self.$frequency, stateListVar: self.$frequencyChoices, stateIndexVar: self.$frequencyIndex, pickingVar: self.$selectFrequency)
                    PickerView(fieldName: "Preferred Time", currentVarDefault: currentUser.times, currentVar: self.$times, stateListVar: self.$timesChoices, stateIndexVar: self.$timesIndex, pickingVar: self.$selectTimes)

                    Button(action: {

                        let userDictionary = [
                                            "name": self.name,
                                            "pronouns": self.pronouns,
                                            "age": self.age,
                                            "aboutMe": self.aboutMe,
                                            "style":  self.style,
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
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            }
                    }) {
                        ButtonView(buttonText: "Update")
                    }.padding(.top, 30)
                }
                Spacer().frame(height: 100)
            }
                }
            }
        }
    }
}


struct EditUserView_Previews: PreviewProvider {
    static var previews: some View {
        EditUserView(currentUser: User(id: "", age: "30", name: "Michelle Obama", location: "Seattle, WA", pronouns: "(she/her)", aboutMe: "I am your forever first lady. I started the Just Move campaign that featured a song with Beyoncé. I am missed by the reasonable American public.", frequency: "4x/week", style: "Crossfit", times: "Evening", pic: "https://gymbuddiescapstone.s3-us-west-1.amazonaws.com/pengiun.png"))
    }
}


