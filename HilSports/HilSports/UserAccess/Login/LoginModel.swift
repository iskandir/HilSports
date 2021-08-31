//
//  LoginModel.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 27.08.21.
//

import SwiftUI
import FirebaseAuth

class LoginModel : ObservableObject {
    let auth = Auth.auth()
    var isSignedIn : Bool{
        return auth.currentUser != nil
    }


    func signIn(username: String, password: String){
        auth.signIn(withEmail: username, password: password){ result, error in
            guard result != nil, error == nil else {
                return
            }
            //SignIn Success
        }
    }


    
}
