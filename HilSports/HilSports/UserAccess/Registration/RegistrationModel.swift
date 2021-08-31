//
//  RegistrationModel.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 31.08.21.
//

import Foundation
import FirebaseAuth

class RegistrationModel : ObservableObject {
    let auth = Auth.auth()
    
    
    func signUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password) {
          result, error in
            guard result != nil, error == nil else {
                return
            }
            //SignUp Success
        }
    }
}
