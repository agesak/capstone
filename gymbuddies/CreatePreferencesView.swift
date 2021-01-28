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
    
    private var db = Firestore.firestore()
    
    var body: some View {
        VStack {
                if user != nil {
                Text(user!.email!)
            }
            VStack(alignment: .leading){
                Text("Name").font(.headline).fontWeight(.light)
                TextField("Enter your Name", text: $name)
                .autocapitalization(.none)
                Divider()
            }
            
        }

    }
}

struct CreatePreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePreferencesView()
    }
}
