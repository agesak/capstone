//
//  scratch.swift
//  gymbuddies
//
//  Created by Kareha on 2/9/21.
//

import SwiftUI

struct scratch: View {
    var body: some View {
        HStack{
            Image("cat")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80.0, height: 80.0)

            VStack{
                HStack{
                    VStack(alignment: .leading, spacing: 6) {

                        HStack{
                            Text("Tester").fontWeight(.bold).foregroundColor(.black)
                            Text("(she/her)").foregroundColor(.black)
                        }
                        Text("Seattle, WA").foregroundColor(.gray)

                        HStack{
                            Text("Crossfit")
                            Text("3x/week")
                        }
                    }
                    Spacer()
                }
//                Divider()
            }
        }.padding(10)
        .background(Color(red: 220.0 / 255.0, green: 220.0 / 255.0, blue: 220.0 / 255.0).cornerRadius(25))
        .padding([.leading, .bottom, .trailing])
    }
}

struct scratch_Previews: PreviewProvider {
    static var previews: some View {
        scratch()
    }
}
