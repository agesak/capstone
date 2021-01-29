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
    @State var gender : String = ""
    
    private var db = Firestore.firestore()
    
    var body: some View {
        NavigationView{
            VStack {
                    if user != nil {
                    Text(user!.email!)
                        Text(user!.uid)
                }
                Form {
                    Section(header: Text("Demographic Information")) {
                        TextField("Name", text: $name)
                        TextField("Age", text: $age)
                        TextField("Location", text: $gender)
                    }
                }
            }.navigationBarTitle("Profile Information")
        }
    }
}

struct CreatePreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePreferencesView()
    }
}
