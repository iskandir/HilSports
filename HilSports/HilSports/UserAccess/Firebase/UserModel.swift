//
//  RegistrationModel.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 31.08.21.
//

import Foundation

class UserModel : ObservableObject{
    //Published is used when you wanna reach the target to update your variable everytime its status has been changed
    @Published var username : String = ""
    @Published var password : String = ""
    @Published var email : String = ""
    
    static let shared = UserModel(username: "", password: "", email: "")
    
    init(username: String, password: String, email: String){
        self.username = username
        self.password = password
        self.email = email
    }
}

