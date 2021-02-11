//
//  AboutMeView.swift
//  gymbuddies
//
//  Created by Kareha on 2/10/21.
//

import SwiftUI
import Firebase



struct AboutMeView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var isprofileValid: Bool = false
    @State private var shouldShowProfileAlert: Bool = false

    let user = Auth.auth().currentUser
    @State var aboutMe : String = ""
    
    var body: some View {
        ZStack{
            if colorScheme == .dark {
                Image("barbell-cropped").resizable().aspectRatio(contentMode: .fill).opacity(0.1).ignoresSafeArea()
            } else {
                Image("barbell-cropped").resizable().opacity(0.1).ignoresSafeArea()
            }
            
            VStack(){
//            Spacer().frame(height: 10)
            
            
            Text("Now a Bit About You")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            
//            ScrollView {
                Spacer().frame(height: 80)
                
                Text(self.aboutMe).foregroundColor(.clear).padding(8)
                .frame(maxWidth: .infinity)
                .overlay(
//                    CustomTextField(text: $aboutMe, onCommit: ("Return") -> Void)
                    TextEditor(text: $aboutMe)
                        .frame(minHeight: 50.0)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                        .padding(.horizontal)
                        
                        
                )
                
//            }
                
                
//                Spacer().frame(height: 20)
                
                Spacer()
            
//                TextField("ugh", text: $aboutMe)
                
                Text("Ex: I am a fun happy person who loves to do crossfit in the evenings with my great friends.")
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal)
                    .padding(.top, 150)

                
            Spacer().frame(height: 50)
            
            
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
                                "aboutMe": self.aboutMe
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
                
                Spacer()
                .frame(height: 100)
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
