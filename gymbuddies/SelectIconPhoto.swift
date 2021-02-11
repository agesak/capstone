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
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State private var isprofileValid: Bool = false
    @State private var shouldShowProfileAlert: Bool = false
    @State var selectedPhoto : String = ""
    
    let user = Auth.auth().currentUser
    let dogSunglassesURL = "https://gymbuddiescapstone.s3-us-west-1.amazonaws.com/dog-sunglasses.jpg"
    let pugUrl = "https://gymbuddiescapstone.s3-us-west-1.amazonaws.com/pug.jpg"
    let puppyMugUrl = "https://gymbuddiescapstone.s3-us-west-1.amazonaws.com/puppy-mug.jpg"
    let puppyToothsUrl = "https://gymbuddiescapstone.s3-us-west-1.amazonaws.com/puppyTooths.jpg"
    let twoRetrieversUrl = "https://gymbuddiescapstone.s3-us-west-1.amazonaws.com/two-retrievers.jpg"
    
    let kbsUrl = "https://gymbuddiescapstone.s3-us-west-1.amazonaws.com/kbs.jpg"
    let pinkKbsUrl = "https://gymbuddiescapstone.s3-us-west-1.amazonaws.com/pink-kbs.jpg"
    let rougueUrl = "https://gymbuddiescapstone.s3-us-west-1.amazonaws.com/rougue-vibes.jpg"
//    let dumbbellsUrl = "https://gymbuddiescapstone.s3-us-west-1.amazonaws.com/dumbbells.jpg"
    let glovesUrl = "https://gymbuddiescapstone.s3-us-west-1.amazonaws.com/gloves.jpg"
    let yogaVibesUrl = "https://gymbuddiescapstone.s3-us-west-1.amazonaws.com/yoga.jpg"
    

    
 
    var body: some View {
        
        ZStack{
            
            if colorScheme == .dark {
//                "barbell_2nd_lighter"
                Image("barbell-cropped").resizable().aspectRatio(contentMode: .fill).opacity(0.1).ignoresSafeArea()
            } else {
                Image("barbell-cropped").resizable().aspectRatio(contentMode: .fill).opacity(0.1).ignoresSafeArea()
            }
            
            VStack {
                
                Text("Adorable Puppies")
                    .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
                    .fontWeight(/*@START_MENU_TOKEN@*/.semibold/*@END_MENU_TOKEN@*/)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                ScrollView(.horizontal, showsIndicators: true){
                    HStack{
                    
                        IconView(photoUrl: puppyMugUrl, heightSize: 100.0, selectedPhoto: self.$selectedPhoto)
                        IconView(photoUrl: dogSunglassesURL, heightSize: 100.0, selectedPhoto: self.$selectedPhoto)
                        IconView(photoUrl: pugUrl, heightSize: 100.0, selectedPhoto: self.$selectedPhoto)
                        IconView(photoUrl: twoRetrieversUrl, heightSize: 100.0, selectedPhoto: self.$selectedPhoto)
                        IconView(photoUrl: puppyToothsUrl, heightSize: 100.0, selectedPhoto: self.$selectedPhoto)
                    }.padding(.horizontal)

                }
                
                VStack {
                    
                    Text("Workout")
                        .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
                        .fontWeight(/*@START_MENU_TOKEN@*/.semibold/*@END_MENU_TOKEN@*/)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    ScrollView(.horizontal, showsIndicators: true){
                        HStack{
                        
                            IconView(photoUrl: kbsUrl, heightSize: 200.0, selectedPhoto: self.$selectedPhoto)
                            IconView(photoUrl: pinkKbsUrl, heightSize: 150.0, selectedPhoto: self.$selectedPhoto)
                            IconView(photoUrl: rougueUrl, heightSize: 150.0, selectedPhoto: self.$selectedPhoto)
                            IconView(photoUrl: glovesUrl, heightSize: 100.0, selectedPhoto: self.$selectedPhoto)
                            IconView(photoUrl: yogaVibesUrl, heightSize: 150.0, selectedPhoto: self.$selectedPhoto)
                        }.padding(.horizontal)

                    }
                }
                
                Spacer().frame(height: 90)
                
                NavigationLink(
                    destination: UserView(),
                    isActive: self.$isprofileValid) {
                        Text("Finish!")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 250, height: 50)
                            .background(Color(red: 135.0 / 255.0, green: 206.0 / 255.0, blue: 250.0 / 255.0))
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
            }.navigationBarTitle("Select Profile Icon")
        }
    }
}

struct SelectIconPhoto_Previews: PreviewProvider {
    static var previews: some View {
        SelectIconPhoto()
    }
}


struct IconView : View{
    
    var photoUrl : String
//    tbh can get rid of this....
    var heightSize: CGFloat
    @Binding var selectedPhoto : String
    
    func setPhotoUrl(url: String) {
        self.selectedPhoto = url
    }
    
    var body: some View {
        
        Button(action: {setPhotoUrl(url: photoUrl)}) {
            URLImage(url: URL(string: photoUrl)!) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(5)
//                    .frame(height: 500)
            }.frame(width: 100.0, height: 100.0)
        }.background(self.selectedPhoto == photoUrl ? Color(red: 135.0 / 255.0, green: 206.0 / 255.0, blue: 250.0 / 255.0) : Color.clear)
        
    }
}
