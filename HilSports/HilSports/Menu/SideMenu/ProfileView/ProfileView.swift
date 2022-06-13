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
                Label("Edit", systemImage: "pencil")
            })
        .padding()
        .sheet(isPresented: $editProfile, content: {
            EditUserData()
        })
    }
}

struct ProfileText : View
{
    
    @EnvironmentObject var user : UserModel
    var body : some View
    {
        VStack(spacing: 15)
        {
            VStack(spacing: 5)
            {
                Text("\(user.username)")
                    .bold()
                    .font(.title)
                Text("\(user.email)")
                    .font(.body)
                    .foregroundColor(.secondary)
            }.padding()
            Text("Description")
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
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


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
