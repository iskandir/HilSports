//
//  RegistrationModel.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 31.08.21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegistrationModel : ObservableObject {
    private var db = Firestore.firestore()
    
    func addUser(username : String, email : String, password : String){
        do {
            _ = try db.collection("user").addDocument(data: ["email": email, "username" : username, "password" : password])
        } catch {
            print(error.localizedDescription)
        }
    }
}
