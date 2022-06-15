//
//  ProfileView.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 27.08.21.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var user : UserModel
    @State var editProfile = false
    
    var body: some View {
        VStack
        {
            Header()
            ProfileText()
                
        }
        Spacer()
        Button(
            action: { self.editProfile = true},
            label: {
                Label("Edit Profile", systemImage: "pencil")
            })
        .padding()
        .sheet(isPresented: $editProfile, content: {
            EditUserData().environmentObject(user)
        })
    }
}

struct ProfileText : View
{
    
    @EnvironmentObject var user : UserModel
    @State var age = 3;
    @State var sports = ""
    
    var body : some View
    {
        VStack(spacing: 15)
        {
            VStack(spacing: 5)
            {
                Text("\(user.username)")
                    .bold()
                    .font(.title)
                Text("@\(user.email)")
                    .font(.body)
                    .foregroundColor(.secondary)
            }.padding()
        }
        Text("\(user.aboutYou)")
            .multilineTextAlignment(.trailing)
            .frame(maxHeight: .infinity, alignment: .topLeading)
            .padding()
        HStack
        {
            Text("Age: ")
                .padding()
            Spacer()
            if Int(user.age) ?? 0 < 2
            {
                Text("\(user.age) year old")
                    .padding()
            } else
            {
                Text("\(user.age) years old")
                    .padding()
            }
            
            
        }
        HStack
        {
            Text("Favorite Sports")
                .padding()
            Spacer()
            Text(user.favSports.joined(separator: ", "))
                .multilineTextAlignment(.trailing)
                .padding()
        }
        
        Spacer()
    }
}

struct Header : View
{
    var body : some View
    {
        ZStack(alignment: .top) {
                   Rectangle()
                        .foregroundColor(.green)
                        .edgesIgnoringSafeArea(.top)
                        .frame(height: 100)
                   Image(systemName: "person.crop.circle")
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
        }
    }
}
