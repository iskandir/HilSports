//
//  LoginView.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 29.08.21.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    var body: some View {
        HStack{
            VStack{
                Text("Login")
            } .padding(.horizontal)

            VStack{
                HStack{
                    Text("Username:")
                        .frame(width: 100, alignment: .leading)
                    TextField("Username...", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth: 200)
                }
                .padding(.horizontal)
                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                HStack{
                    Text("Password:")
                        .frame(width: 100, alignment: .leading)
                    SecureField("Password...", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth: 200)
                }
                .padding(.horizontal)
                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            }
        Spacer()
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
