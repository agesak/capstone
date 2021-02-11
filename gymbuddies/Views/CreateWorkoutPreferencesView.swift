//
//  CreateWorkoutPreferencesView.swift
//  gymbuddies
//
//  Created by Kareha on 2/4/21.
//

import SwiftUI
import Firebase

struct CreateWorkoutPreferencesView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State var times = ["Morning", "Afternoon", "Evening"]
    @State private var timesIndex = 0
    
    @State var style = ["HIIT", "Crossfit", "Running", "Yoga"]
    @State private var styleIndex = 0
    
    @State var frequency = ["1x/week", "2x/week", "3x/week", "4x/week", "5-6x/week"]
    @State private var frequencyIndex = 0
    
    @State private var isprofileValid: Bool = false
    @State private var shouldShowProfileAlert: Bool = false
    
    let user = Auth.auth().currentUser
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        ZStack{
            
            if colorScheme == .dark {
                Image("barbell-cropped").resizable().aspectRatio(contentMode: .fill).opacity(0.1).ignoresSafeArea()
            } else {
                Image("barbell-cropped").resizable().aspectRatio(contentMode: .fill).opacity(0.1).ignoresSafeArea()
            }
        
            VStack{
                Spacer().frame(height: 130)
                Form{
                    Section {
                        Picker(selection: $styleIndex, label: Text("Preferred Workout Style")) {
                            ForEach(0 ..< style.count) {
                                Text(self.style[$0])
                            }
                        }
                    }
                    
                    
                    Section() {
                            Picker(selection: $timesIndex, label: Text("When?")) {
                                ForEach(0 ..< times.count) {
                                    Text(self.times[$0])
                                }
                            }
                        }
                    
                        
                    Section{
                        
                        Picker(selection: $frequencyIndex, label: Text("How Often?")) {
                            ForEach(0 ..< frequency.count) {
                                Text(self.frequency[$0])
                            }
                        }
                    }
                }
                .foregroundColor(Color.black)
                .navigationBarTitle("Workout Style?")
                
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
                Spacer().frame(height: 150)
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
