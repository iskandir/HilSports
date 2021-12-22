//
//  LoginModel.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 27.08.21.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class LoginModel : ObservableObject {
    
    @Published var user = [User]()
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("user").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.user = documents.map { (queryDocumentSnapshot) -> User in
                let data = queryDocumentSnapshot.data()
                let username = data["username"] as? String ?? ""
                let password = data["password"] as? String ?? ""
                return User(id: .init(), username: username, password: password)
            }
        }
    }
    func userLogin(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) {(result, error) in
            if error != nil {
                print("Error writing document: \(String(describing: error))")
            } else {
                print("Document successfully written!")
            }
        }
    }
}

struct User: Codable, Identifiable {
    var id: String = UUID().uuidString
    var username : String?
    var password : String?
    var email : String?
}
