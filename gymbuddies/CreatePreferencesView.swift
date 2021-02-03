//
//  CreatePreferencesView.swift
//  gymbuddies
//
//  Created by Kareha on 1/28/21.
//

import SwiftUI
import Firebase

struct CreatePreferencesView: View {
    
    let user = Auth.auth().currentUser
    @State var name : String = ""
    @State var age : String = ""
    @State var location : String = ""
//    @State var pronouns : String = ""
    
    @State var times = ["Morning", "Afternoon", "Evening"]
    @State private var timesIndex = 0
    
    @State var style = ["HIIT", "Crossfit", "Running", "Yoga"]
    @State private var styleIndex = 0
    
    @State var frequency = ["1x/week", "2x/week", "3x/week", "4x/week", "5-6x/week"]
    @State private var frequencyIndex = 0
    
    @State private var isprofileValid: Bool = false
    @State private var shouldShowProfileAlert: Bool = false
    
    private var db = Firestore.firestore()
    
    var body: some View {
//        NavigationView{
            VStack {
//                    if user != nil {
//                    Text(user!.email!)
//                    Text(user!.uid)
//                }
                
                
                Form {
                    
                        Section(header: Text("Demographic Information")) {
                            TextField("Name", text: $name)
                            TextField("Age", text: $age)
                            TextField("Location", text: $location)
//                            TextField("Pronouns", text: $pronouns)
                        }

                    
                        Section(header: Text("Workout Preferences")) {
                                Picker(selection: $timesIndex, label: Text("Time of Day")) {
                                    ForEach(0 ..< times.count) {
                                        Text(self.times[$0])
                                    }
                                }
                            
                            Picker(selection: $styleIndex, label: Text("Preferred Workout Style")) {
                                ForEach(0 ..< style.count) {
                                    Text(self.style[$0])
                                }
                            }
                            
                            Picker(selection: $frequencyIndex, label: Text("Workout Frequency")) {
                                ForEach(0 ..< frequency.count) {
                                    Text(self.frequency[$0])
                                }
                            }
                        }.padding()
                        
                    
                }.navigationBarTitle("Profile Information")
                
                NavigationLink(
//                    will likely go to photo upload view
                    destination: UserView(),
                    isActive: self.$isprofileValid) {
                        Text("Continue")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 250, height: 50)
                            .background(Color.purple)
                            .cornerRadius(10.0)
                            .onTapGesture {
                                let userDictionary = [
                                    "name": self.name,
                                    "age": self.age,
                                    "location": self.location,
                                    "times": self.times[self.timesIndex],
                                    "style": self.style[self.styleIndex],
                                    "frequency": self.frequency[self.frequencyIndex],
                                    "email": user?.email!
                                ]
                                
//                                let docRef = db.collection("users").document("\(user!.uid)")
                                let docRef = Firestore.firestore().document("users/\(user!.uid)")
                                
//                                let docRef = Firestore.firestore().document("users/\(user!.uid)")
                                print("setting data")
                                docRef.setData(userDictionary as [String : Any]){ (error) in
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
                Spacer()
                
            }.alert(isPresented: $shouldShowProfileAlert) {
                Alert(title: Text("Error Creating Profile"))}
            .navigationBarBackButtonHidden(true)
        }
}

struct CreatePreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePreferencesView()
    }
}
