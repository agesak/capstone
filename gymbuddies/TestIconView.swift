//
//  TestIconView.swift
//  gymbuddies
//
//  Created by Kareha on 2/4/21.
//

import SwiftUI
import Firebase
import URLImage

struct TestIconView: View {
    var body: some View {
        VStack{
            let urly = URL(string: "https://gymbuddiescapstone.s3-us-west-1.amazonaws.com/cat.png")!
            
            URLImage(url: urly,
                     empty: {
                        EmptyView()
                     },
                     inProgress: { progress in
                        Image(systemName: "photo")
                     },
                     failure: { error, retry in
                        Text("Failed")
                     },
                     content: { image, info in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                     })
//            URLImage(url: urly) { image in
//                image
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//            }
        }
    }
}

struct TestIconView_Previews: PreviewProvider {
    static var previews: some View {
        TestIconView()
    }
}
