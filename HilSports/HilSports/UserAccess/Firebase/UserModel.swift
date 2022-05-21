//
//  RegistrationModel.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 31.08.21.
//

import Foundation

class UserModel : ObservableObject{
    var username : String
    var password : String
    var email : String
    
    init(username: String, password: String, email: String){
        self.username = username
        self.password = password
        self.email = email
    }
}
