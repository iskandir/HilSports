//
//  RegistrationViewModel.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 22.12.21.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

class RegistrationViewModel : ObservableObject {
    
    private let db = Firestore.firestore()
    @State private var email : String = ""
    typealias CompletionHandler = (_ success:Bool) -> Void
    typealias CompletionHaendler = (_ sucessMessage: Bool) -> Void

    @Published var registrationUser : RegistrationModel = RegistrationModel(username: "", password: "", email: "")
    
    //User Signup does work correctly
    func signUp(registrationUser : RegistrationModel,completionHaendler: @escaping CompletionHaendler)
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
    
    
    func doesUserExist(email : String, completionHandler: @escaping CompletionHandler) {
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
}
