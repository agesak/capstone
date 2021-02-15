//
//  UserProfile.swift
//  gymbuddies
//
//  Created by Kareha on 2/11/21.
//

import SwiftUI
import URLImage

struct userIconView : View {
    
    var imageName: String
    
    var body : some View {
        Image(imageName)
            .resizable()
            .frame(width: 30.0, height: 30.0)
        Spacer()
    }
}

struct userDemographicView : View {

    var textFieldName : String
    var textValue : String
    
    var body : some View {
        HStack(){
            Text(textFieldName)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Text(textValue)
            Spacer()
        }
        Spacer().frame(height: 10)
    }
}

struct MainProfilePageView : View {
    
    var user : User
    @State var sizeOfImage: CGFloat = UIScreen.main.bounds.height/2.5
    
    var body : some View {
        
        VStack {
            
            ZStack(alignment: .bottom){
                Image("barbell-header")
                    .resizable()
                    .frame(height: sizeOfImage)
                    .opacity(0.1)
                    .ignoresSafeArea()
                
                VStack{
                    HStack{
                       if URL(string: user.pic) != nil {
                           URLImage(url: URL(string: user.pic)!) { image in
                               image
                                   .resizable()
                                   .aspectRatio(contentMode: .fit)
                           }.frame(width: 150.0, height: 150.0)
                           .padding([.leading, .bottom])
                       } else {
                           Image(systemName: "photo")
                            .padding(.leading)
                       }
                    
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            HStack(){
                                Text("\(user.name)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Text("\(user.pronouns)")
                                    .font(.title2)
                            }
                            Text("\(user.location)")
                        }.padding(.trailing, 40)
                        Spacer()
                    }
                }
            }.padding(.bottom, 10)
        }
        
        HStack{
            Spacer()
            userIconView(imageName: "barbell-icon")
            userIconView(imageName: "barbell-icon")
            userIconView(imageName: "barbell-icon")
        }
        
        VStack(alignment: .leading){
        Text("About Me")
            .font(.title)
            .fontWeight(.semibold)
            .padding(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer().frame(height: 10)
            
            Text(user.aboutMe)
                .fixedSize(horizontal: false, vertical: true)
                .padding([.leading, .bottom])
                .padding(.top, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay(
                    RoundedCorner(radius: 10.0, corners: [.allCorners])
                         .stroke(Color.secondary)
                         .shadow(color: .secondary, radius: 3, x: 0, y: 0))
        }.padding(.horizontal)
        
        VStack(alignment: .leading){
            userDemographicView(textFieldName: "Age:", textValue: user.age)
            userDemographicView(textFieldName: "Workout Style:", textValue: user.style)
            userDemographicView(textFieldName: "Preferred Time:", textValue: user.times)
            userDemographicView(textFieldName: "Preferred Frequency:", textValue: user.frequency)
        }.padding(.leading)
        .padding(.top, 10)
        
        Spacer().frame(height: 10)
    }
    
}


