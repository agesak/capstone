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

//class ImageLoader: ObservableObject {
//    var didChange = PassthroughSubject<Data, Never>()
//    var data = Data() {
//        didSet {
//            didChange.send(data)
//        }
//    }
//
//    init(urlString:String) {
//        guard let url = URL(string: urlString) else { return }
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data else { return }
//            DispatchQueue.main.async {
//                self.data = data
//            }
//        }
//        task.resume()
//    }
//}
//
//struct ImageView: View {
//
//    @ObservedObject var imageLoader:ImageLoader
//    @State var image:UIImage = UIImage()
//
//    init(withURL url:String) {
//        imageLoader = ImageLoader(urlString:url)
//    }
//
//    var body: some View {
//
//            Image(uiImage: image)
//                .resizable()
//                .scaledToFit()
////                .aspectRatio(contentMode: .fit)
//                .frame(width:100, height:100)
//                .onReceive(imageLoader.didChange) { data in
//                self.image = UIImage(data: data) ?? UIImage()
//        }
//    }
//}



struct SelectIconPhoto: View {
    
    @State private var isprofileValid: Bool = false
    @State private var shouldShowProfileAlert: Bool = false
    
    let user = Auth.auth().currentUser
    
    var body: some View {
        VStack{
            
            VStack{
//                ImageView(withURL: "https://gymbuddiescapstone.s3-us-west-1.amazonaws.com/cat.png")
//                AsyncImage(url: URL(string: "https://gymbuddiescapstone.s3-us-west-1.amazonaws.com/cat.png")!,
//                               placeholder: { Text("") },
//                               image: { Image(uiImage: $0).resizable() })
                URLImage(url: URL(string: "https://gymbuddiescapstone.s3-us-west-1.amazonaws.com/cat.png")!) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                       .frame(idealHeight: UIScreen.main.bounds.width / 2 * 3)
                Image("cat").resizable().scaledToFit().frame(width: 100.0, height: 100.0)
                Image("pengiun").resizable().scaledToFit().frame(width: 100.0, height: 100.0)
            }.navigationBarTitle("Select Icon")
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
                                "pic": "will be a link to their pic"
                            ]
//                            let docRef = Firestore.firestore().document("users/\(user!.uid)")
//                            docRef.setData(userDictionary as [String : Any]){ (error) in
//                                    if let error = error {
//                                        print("error = \(error)")
//                                        self.isprofileValid = false
//                                    } else {
//                                        print("profile updated")
//                                        self.isprofileValid = true
//                                    }
//                                }
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
