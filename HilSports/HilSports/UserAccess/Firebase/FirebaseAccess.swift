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

    @State var registrationUser : UserModel = UserModel()
    @EnvironmentObject var user : UserModel
    
    //User Signup does work correctly
    func signUp(registrationUser : UserModel,completionHaendler: @escaping CompletionHaendler)
    {
        var sucessMessage : Bool = false
        //access to different database
        let docRefUD = db.collection("databaseUserData").document(registrationUser.email)
        let docRefUP = db.collection("databaseUserPasswords").document(registrationUser.username)
        
        
        //docData for writing in databases
        let docUDData: [String: Any] = [
            "username" : registrationUser.username,
            "email" : registrationUser.email]
        let docUPData: [String: Any] = [
            "username" : registrationUser.username,
            "password" : registrationUser.password]
        
        
        
        docRefUD.setData(docUDData)
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
            
            docRefUP.setData(docUPData)
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
        var userExistVar = false
       
            db.collection("databaseUserData")
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
        var userExistVar = false
       
            db.collection("databaseUserData")
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
        var passwordCorrect : Bool = false
        
        let docRef = db.collection("databaseUserPasswords").document("\(username)")
        docRef.getDocument{(document, error) in
            if let document = document, document.exists {
                let passwordVal = document.get("password") as! String
                //TODO: Test cases for checking the database values
                /*
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                print("\(String(describing: document.data()))")
                //returns optional
                print("Password is: \(fieldVal)")
                */
                if(passwordVal == password)
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
