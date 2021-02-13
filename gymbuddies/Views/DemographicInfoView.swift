//
//  CreatePreferencesView.swift
//  gymbuddies
//
//  Created by Kareha on 1/28/21.
//

import SwiftUI
import Firebase

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

struct DemographicInfoView: View {
    
    let user = Auth.auth().currentUser
    @ObservedObject var toUpdate = updateUser(userInfo: [:])
    @State var name : String = ""
    @State var age : String = ""
    @State var location : String = ""
    @State var pronouns : String = ""
    
//     = false
    @State private var isprofileValid: Bool = false
    @State private var shouldShowProfileAlert: Bool = false
    
    var body: some View {
        
        ZStack{
            Image("barbell-cropped").resizable().aspectRatio(contentMode: .fill).opacity(0.1).ignoresSafeArea()

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
                destination: AboutMeView(),
                isActive: self.$isprofileValid) {
                ButtonView(buttonText: "Continue")
                        .onTapGesture {
//                            self.isprofileValid = toUpdate.create(userInfo: [
//                                "name": self.name,
//                                "age": self.age,
//                                "location": self.location,
//                                "pronouns": self.pronouns])
//                            print(self.isprofileValid)
                            
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
        DemographicInfoView()
    }
}



