//
//  CreatePreferencesView.swift
//  gymbuddies
//
//  Created by Kareha on 1/28/21.
//

import SwiftUI
import Firebase

struct CreatePreferencesView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    let user = Auth.auth().currentUser
    @State var name : String = ""
    @State var age : String = ""
    @State var location : String = ""
    @State var pronouns : String = ""
    
    @State private var isprofileValid: Bool = false
    @State private var shouldShowProfileAlert: Bool = false
    
    private var db = Firestore.firestore()
    
    var body: some View {
        
        ZStack{
            
            if colorScheme == .dark {
//                "barbell_2nd_lighter"
                Image("barbell-cropped").resizable().aspectRatio(contentMode: .fill).opacity(0.1).ignoresSafeArea()
            } else {
                Image("barbell-cropped").resizable().aspectRatio(contentMode: .fill).opacity(0.1).ignoresSafeArea()
            }
            
            VStack{
            VStack(alignment: .leading){
                Text("First Tell Me Your...")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.leading)
                
                Spacer().frame(height: 50)
                    FieldView(fieldName: "Name", fieldString: "Michelle Obama", stateVar: self.$name)
                    FieldView(fieldName: "Age", fieldString: "25", stateVar: self.$age)
                    FieldView(fieldName: "Location", fieldString: "Seattle, WA", stateVar: self.$location)
                    FieldView(fieldName: "Pronouns", fieldString: "she/her", stateVar: self.$pronouns).autocapitalization(.none)
                Spacer().frame(height: 75)
            }
            NavigationLink(
                destination: CreateWorkoutPreferencesView(),
                isActive: self.$isprofileValid) {
                    Text("Continue")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 250, height: 50)
                        .background(Color(red: 135.0 / 255.0, green: 206.0 / 255.0, blue: 250.0 / 255.0))
                        .cornerRadius(10.0)
                        .onTapGesture {
                            let userDictionary = [
                                "name": self.name,
                                "age": self.age,
                                "location": self.location,
                                "pronouns": self.pronouns
                            ]
                            let docRef = Firestore.firestore().document("users/\(user!.uid)")
                            docRef.setData(userDictionary as [String : Any]){ (error) in
                                    if let error = error {
                                        print("error = \(error)")
                                        self.isprofileValid = false
                                    } else {
                                        print("profile updated")
                                        self.isprofileValid = true
                                    }
                                }
                        }
                }
            Spacer().frame(height: 70)
            }
        }.alert(isPresented: $shouldShowProfileAlert) {
                Alert(title: Text("Error Creating Profile"))}
    }
}

struct CreatePreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePreferencesView()
    }
}


struct FieldView : View {
    
    var fieldName: String
    var fieldString: String
    @Binding var stateVar: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(fieldName).font(.title).fontWeight(.medium)
            TextField(fieldString, text: $stateVar)
            Divider()
        }
        .padding(.leading)
    }
}
