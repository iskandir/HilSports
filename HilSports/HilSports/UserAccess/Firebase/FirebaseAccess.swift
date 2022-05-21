//
//  FirebaseAccess.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 17.05.22.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

class FirebaseAccess : ObservableObject {
    private let db = Firestore.firestore()
    typealias CompletionHandler = (_ success:Bool) -> Void
    typealias CompletionHaendler = (_ sucessMessage: Bool) -> Void

    @Published var registrationUser : UserModel = UserModel(username: "", password: "", email: "")
    
    //User Signup does work correctly
    func signUp(registrationUser : UserModel,completionHaendler: @escaping CompletionHaendler)
    {
        var sucessMessage : Bool = false
        let db = Firestore.firestore()
        let docRef = db.collection("databaseUser").document(registrationUser.email)
        
        let docData: [String: Any] = [
            "username" : registrationUser.username,
            "email" : registrationUser.email,
            "password" : registrationUser.password]
        
        docRef.setData(docData)
        { error in
            if let error = error {
                print("Error writing document: \(error)")
                sucessMessage = false
                completionHaendler(sucessMessage)
            } else {
                print("SignUp!")
                sucessMessage = true
                completionHaendler(sucessMessage)
            }
        }
    }

    func doesEmailExist(email : String, completionHandler: @escaping CompletionHandler) {
        let db = Firestore.firestore()
        var userExistVar = false
       
            db.collection("databaseUser")
                .whereField("email", isEqualTo: email)
                .getDocuments(){(querySnapshot,err) in
                    if let err = err {
                        print("Error \(err)")
                    } else {
                        if querySnapshot!.documents.isEmpty{
                            userExistVar = false
                            completionHandler(userExistVar)
                        } else {
                            for document in querySnapshot!.documents{
                                userExistVar = true
                                print("\(document.documentID) is \(document.data())")
                                completionHandler(userExistVar)
                            }
                        }
                    }
                }
        
        }
    
    func doesUserExist(username : String, completionHandler: @escaping CompletionHandler) {
        let db = Firestore.firestore()
        var userExistVar = false
       
            db.collection("databaseUser")
                .whereField("username", isEqualTo: username)
                .getDocuments(){(querySnapshot,err) in
                    if let err = err {
                        print("Error \(err)")
                    } else {
                        if querySnapshot!.documents.isEmpty{
                            userExistVar = false
                            completionHandler(userExistVar)
                        } else {
                            for document in querySnapshot!.documents{
                                userExistVar = true
                                print("\(document.documentID) is \(document.data())")
                                completionHandler(userExistVar)
                            }
                        }
                    }
                }
        
        }
    func checkPassword(username : String, password : String, completionHandler: @escaping CompletionHandler)
    {
        let db = Firestore.firestore()
        var passwordCorrect : Bool = false
        
        let docRef = db.collection("databaseUser").document("\(username)")
        docRef.getDocument{(document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                print("\(String(describing: document.data()))")
                //returns optional
                let fieldVal = document.get("password") as! String
                print("Password is: \(fieldVal)")
                
                if(fieldVal == password)
                {
                    passwordCorrect = true
                    print("Password correct")
                    completionHandler(passwordCorrect)
                } else
                {
                    print("Password incorrect")
                    completionHandler(passwordCorrect)
                }
                
            } else {
                print("test")
            }
        }
    }
}
