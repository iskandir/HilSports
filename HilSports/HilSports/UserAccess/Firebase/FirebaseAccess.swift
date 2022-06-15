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

struct FirebaseAccess {
    private var db = Firestore.firestore()
    typealias CompletionHandler = (_ success:Bool) -> Void
    typealias CompletionHaendler = (_ sucessMessage: Bool) -> Void

    @State var registrationUser : UserModel = UserModel(username: "", password: "", email: "")
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
                                /* MARK: only for Debugging
                                print("\(document.documentID) is \(document.data())")*/
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
                                /* MARK: Only for Debugging
                                print("User \(username) does exist!")
                                print("\(document.documentID) is \(document.data())")
                                */
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
                    completionHandler(passwordCorrect)
                } else
                {
                    completionHandler(passwordCorrect)
                }
                
            } else {
                print("test")
            }
        }
    }
    //TODO: save sportitems into an array
    func getSportItems() -> [String]
    {
        var sportsArray = [""]
        print("Start getSportsItems()")
        
        db.collection("databaseStatistics").getDocuments(){(querySnapshot, error) in
            if let error = error {
                print("Error occured \(error)")
            } else {
                for document in querySnapshot!.documents
                {
                    print("\(document.documentID): \(document.data())")
                    print("\(document.data().count)")
                }
            }
        }
        
        return sportsArray
    }
}
