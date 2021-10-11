//
//  RegistrationView.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 30.08.21.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var registrationModel : RegistrationModel
    
    @State private var name : String = ""
    @State private var password : String = ""
    @State private var email : String = ""
    @State private var username : String = ""
    
    var body: some View {
        TextField("Name", text: $name)
        TextField("password", text: $password)
        TextField("email", text: $email)
        TextField("username", text: $username)
        
        Button("Registration"){
            print("Hello Registration")
            guard !username.isEmpty, !password.isEmpty else {
                return
            }
            registrationModel.addUser(name: self.name, email: self.email, password: self.password)
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
