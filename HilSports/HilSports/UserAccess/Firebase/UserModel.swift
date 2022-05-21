//
//  RegistrationModel.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 31.08.21.
//

import Foundation

class UserModel : ObservableObject{
    @Published var username : String = ""
    @Published var password : String = ""
    @Published var email : String = ""
    

}

