//
//  SelectIconPhoto.swift
//  gymbuddies
//
//  Created by Kareha on 2/4/21.
//

import SwiftUI
//import Combine
import Firebase
import URLImage



struct SelectIconPhoto: View {
    
    @State private var isprofileValid: Bool = false
    @State private var shouldShowProfileAlert: Bool = false
    @State var selectedPhoto : String = ""
    
    let user = Auth.auth().currentUser
    let catUrl = "https://gymbuddiescapstone.s3-us-west-1.amazonaws.com/cat.png"
    let pengiunUrl = "https://gymbuddiescapstone.s3-us-west-1.amazonaws.com/pengiun.png"
    
    func setPhotoUrl(url: String) {
        self.selectedPhoto = url
    }
    
 
    var body: some View {
        VStack{
            
            VStack{
                
                Button(action: {setPhotoUrl(url: catUrl)}) {
                    URLImage(url: URL(string: catUrl)!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }.frame(width: 100.0, height: 100.0)
                }.background(self.selectedPhoto == catUrl ? Color.blue : Color.white)
                
                
                Button(action: {setPhotoUrl(url: pengiunUrl)}) {
                    URLImage(url: URL(string: pengiunUrl)!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }.frame(width: 100.0, height: 100.0)
                }.background(self.selectedPhoto == pengiunUrl ? Color.blue : Color.white)
                
//                Image("cat").resizable().scaledToFit().frame(width: 100.0, height: 100.0)
//                Image("pengiun").resizable().scaledToFit().frame(width: 100.0, height: 100.0)
            }.navigationBarTitle("Select Profile Icon")
            NavigationLink(
                destination: UserView(),
                isActive: self.$isprofileValid) {
                    Text("Finish!")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 250, height: 50)
                        .background(Color.purple)
                        .cornerRadius(10.0)
                        .onTapGesture {
                            let userDictionary = [
                                "pic": self.selectedPhoto
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
        }
    }
}

struct SelectIconPhoto_Previews: PreviewProvider {
    static var previews: some View {
        SelectIconPhoto()
    }
}
