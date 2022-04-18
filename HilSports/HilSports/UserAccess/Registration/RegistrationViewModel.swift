//
//  RegistrationViewModel.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 22.12.21.
//

import Foundation
import SwiftUI
import Firebase
class RegistrationViewModel : ObservableObject {
    
    private let db = Firestore.firestore()
    @State private var email : String = ""
    
    typealias CompletionHandler = (_ success:Bool) -> Void

    @Published var registrationUser : RegistrationModel = RegistrationModel(username: "", password: "", email: "")
    
    //User Signup does work correctly
    func signUp(registrationUser : RegistrationModel) -> Bool
        {
            @State var sucessMessage : Bool = false
            let db = Firestore.firestore()
            let docRef = db.collection("databaseUser").document(registrationUser.email)
            
            let docData: [String: Any] = ["username" : registrationUser.username,
                                          "email" : registrationUser.email,
                                          "password" : registrationUser.password]
            
            docRef.setData(docData)
            { error in
                if let error = error {
                    print("Error writing document: \(error)")
                    return sucessMessage = false
                } else {
                    print("SignUp!")
                    return sucessMessage = true
                }
            }
            return sucessMessage
        }
    
    func doesUserExist(email : String, completionHandler: CompletionHandler) -> Bool{
        let db = Firestore.firestore()
        @State var userExistVar : Bool = false
        print("doesUserExist")
        
        db.collection("databaseUser").getDocuments(){(querySnapshot, err) in
            if let err = err {
                print("error: \(err)!");
                userExistVar = true
            } else {
                let counter = querySnapshot!.count
                print("Counter is: \(counter)")
                for document in querySnapshot!.documents{
                    if (email == document.documentID)
                    {
                        print("User does exist!\nReturn Error!")
                        userExistVar = true
                        
                    } else {
                        print("User registration starts")
                        userExistVar = false
                    }
                }
                let completionFlag = true
                completionHandler(completionFlag)
            }
        }
        
        return userExistVar
        
    }

}
