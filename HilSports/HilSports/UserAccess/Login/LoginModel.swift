//
//  LoginModel.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 27.08.21.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class LoginModel : ObservableObject {/*
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
*/
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
                    let name = data["name"] as? String ?? ""
                    return User(name: name)
                }
            }
        }
}

struct User: Codable, Identifiable {
    var id: String = UUID().uuidString
    var name : String?
    var password : String?
    var email : String?
}
