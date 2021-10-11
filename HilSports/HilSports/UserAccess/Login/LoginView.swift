//
//  LoginView.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 29.08.21.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var loginModel : LoginModel
    
    @State private var username = ""
    @State private var password = ""
    
    @State var showAlert = false
    var body: some View {
        HStack(alignment: .center){
            VStack{
                Text("Login")
                    .font(.title)
            } .padding(.horizontal)
            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)

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
                
                Button("SignIn"){
                    guard !username.isEmpty, !password.isEmpty else {
                        showAlert = true
                        return
                    }
                    //loginModel.signIn(username: username, password: password)
                    
                    
                    print("test")
                }.buttonStyle(AuthenticationButtonStyle())
                .alert(isPresented: self.$showAlert){
                    Alert(title: Text("Username and password needs to be filled"))
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
