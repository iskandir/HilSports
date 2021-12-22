//
//  RegistrationViewModel.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 22.12.21.
//

import Foundation
import Firebase
class RegistrationViewModel : ObservableObject {
    
    private let db = Firestore.firestore()
    @Published var registrationUser : RegistrationModel = RegistrationModel(username: "", password: "", email: "")
    
    func signUp(registrationUser : RegistrationModel)
        {
            do {
                let _ = try db.collection("databaseUser").document(registrationUser.email).setData(["username" : registrationUser.username,"email": registrationUser.email,  "password" : registrationUser.password])
            }
            catch{
                print(error)
            }
        }
}
