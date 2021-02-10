//
//  scratch.swift
//  gymbuddies
//
//  Created by Kareha on 2/9/21.
//

import SwiftUI

struct scratch: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
        
        ZStack{
        
            
            if colorScheme == .dark {
                Image("barbell-cropped").resizable().ignoresSafeArea().opacity(0.1)
            } else {
                Image("barbell-cropped").resizable().ignoresSafeArea().opacity(0.1)
            }
            
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
            .background(Color(red: 75.0 / 255.0, green: 0 / 255.0, blue: 130.0 / 255.0).cornerRadius(25))
            .padding([.leading, .bottom, .trailing])
        }
    }
}

//struct scratch : View {
//    @State var sizeOfImage: CGFloat = UIScreen.main.bounds.height/2.5
//
//    var body: some View {
//
//
//
//        VStack {
//
//            ZStack(alignment: .bottom){
//                Image("barbell-header")
//                    .resizable()
//                    .frame(height: sizeOfImage)
//                    .opacity(0.1)
//                    .ignoresSafeArea()
//
////                Spacer().frame(height: 150)
//
//
//                VStack{
////                    Spacer().frame(height: 90)
//                    HStack{
//
//                        Image("cat")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 100.0, height: 100.0)
////                            .padding(.leading)
//
//                        Spacer()
//
//                        VStack(alignment: .leading) {
//                            HStack(){
//                                Text("Test")
//                                    .font(.title2)
//                                    .fontWeight(.bold)
////                                    .foregroundColor(Color(red: 135.0 / 255.0, green: 206.0 / 255.0, blue: 250.0 / 255.0))
//                                Text("(she/her)")
//                                    .font(.title2)
////                                    .fontWeight(.bold)
//                            }
//
////                            Text("30")
//                            Text("Seattle, WA")
//                        }.padding(.trailing, 40)
//                        Spacer()
//                    }
//
//                }
//            }.padding(.bottom, 10)
////            Spacer().frame(height: 30)
//
//            HStack{
//                Spacer()
//                Image("barbell-icon")
//                    .resizable()
//                    .frame(width: 30.0, height: 30.0)
//                Spacer()
//
//                Image("barbell-icon")
//                    .resizable()
//                    .frame(width: 30.0, height: 30.0)
//                Spacer()
//
//                Image("barbell-icon")
//                    .resizable()
//                    .frame(width: 30.0, height: 30.0)
//                Spacer()
//            }
//
//            VStack(alignment: .leading){
//            Text("About Me")
//                .font(.title)
//                .fontWeight(.semibold)
//                .padding(.leading)
////                .padding([.top, .leading])
//                .frame(maxWidth: .infinity, alignment: .leading)
//
////                Spacer().frame(height: 10)
//
//                VStack{
//                Text("I am your forever first lady. I started the Just Move campaign that featured a song with Beyoncé. I am missed by the reasonable American public.")
//                    .fixedSize(horizontal: false, vertical: true)
//                    .padding([.leading, .bottom])
//                    .padding(.top, 10)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .overlay(
//                        RoundedCorner(radius: 10.0, corners: [.allCorners])
//                             .stroke(Color.secondary)
//                             .shadow(color: .secondary, radius: 3, x: 0, y: 0))
//
////                    .padding([.leading, .bottom])
////                    .padding(.top, 10)
////                    .frame(maxWidth: .infinity, alignment: .leading)
////                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
//                }.padding(.horizontal)
//            }
//
//            VStack(alignment: .leading){
//                HStack(){
//                    Text("Age:")
//                        .fontWeight(.bold)
//                    Text("30")
//                    Spacer()
//                }
//                Spacer().frame(height: 10)
//
//                HStack(){
//                    Text("Workout Style:")
//                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                    Text("Crossfit")
//                    Spacer()
//                }
//                Spacer().frame(height: 10)
//
//                HStack(){
//                    Text("Preferred Time:").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                    Text("Afternoon")
//                }
//                Spacer().frame(height: 10)
//
//                HStack(){
//                    Text("Preferred Frequency:").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                    Text("4x/week")
//                }
//                Spacer().frame(height: 10)
//
//            }.padding(.leading)
//            .padding(.top, 10)
//
//            Spacer().frame(height: 10)
//
//
//            Button(action: {
//                print("yay")
//                    }) {
//                        Text("Edit")
//                        .font(.title)
//                        .fontWeight(.bold)
//                        .foregroundColor(.white)
//                        .padding()
//                        .frame(width: 250, height: 50)
//                        .background(Color(red: 135.0 / 255.0, green: 206.0 / 255.0, blue: 250.0 / 255.0))
//                        .cornerRadius(10.0)
//                    }
//            Spacer().frame(height: 200)
//        }
//    }
//}

struct scratch_Previews: PreviewProvider {
    static var previews: some View {
        scratch()
    }
}

//struct RoundedCorner2: Shape {
//    var radius: CGFloat = .infinity
//    var corners: UIRectCorner = .allCorners
//    func path(in rect: CGRect) -> Path {
//        let path = UIBezierPath(roundedRect: rect,
//            byRoundingCorners: corners, cornerRadii: CGSize(width:
//            radius, height: radius))
//        return Path(path.cgPath)
//    }
//}
//
//extension View {
//    func cornerRadius2(_ radius: CGFloat, corners: UIRectCorner) -> some View {
//        clipShape( RoundedCorner(radius: radius, corners: corners) )
//     }
//}
