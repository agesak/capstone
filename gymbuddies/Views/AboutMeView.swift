//
//  AboutMeView.swift
//  gymbuddies
//
//  Created by Kareha on 2/10/21.
//

import SwiftUI
import Firebase

struct AboutMeView: View {
    
    @State private var isprofileValid: Bool = false
    @State private var shouldShowProfileAlert: Bool = false

    let user = Auth.auth().currentUser
    @State var aboutMe : String = ""
    
    var body: some View {
        ZStack{
            Image("barbell-cropped").resizable().opacity(0.1).ignoresSafeArea()
            
            VStack(){
                Text("Now a Bit About You")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("🤔")
                    .font(.system(size: 30))
                    
                Spacer().frame(height: 150)
                
                Text(self.aboutMe)
                    .foregroundColor(.clear)
                    .frame(maxWidth: .infinity)
                    .overlay(TextEditor(text: $aboutMe)
                                .frame(minHeight: 200.0)
                                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                                .padding(.horizontal))
                
                Text("Ex: I am a fun happy person who loves to do crossfit in the evenings with my great friends.")
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal)
                    .padding(.top, 100)

                Spacer().frame(height: 40)

                NavigationLink(
                    destination: CreateWorkoutPreferencesView(),
                    isActive: self.$isprofileValid) {
                    ButtonView(buttonText: "Continue")
                            .onTapGesture {
                                let userDictionary = [
                                    "aboutMe": self.aboutMe
                                ]
                                let docRef = Firestore.firestore().document("users/\(user!.uid)")
                                docRef.updateData(userDictionary as [String : Any]){ (error) in
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
                
                Spacer()
                .frame(height: 10)
            }
            
        }.navigationBarTitle("", displayMode: .inline)
        .alert(isPresented: $shouldShowProfileAlert) {
            Alert(title: Text("Error Updating About Me"))}
    }
}

struct AboutMeView_Previews: PreviewProvider {
    static var previews: some View {
        AboutMeView()
    }
}
