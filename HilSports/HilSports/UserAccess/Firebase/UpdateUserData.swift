//
//  UserData.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 25.05.22.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

class UpdateUserData : ObservableObject{
    private var db = Firestore.firestore()
    typealias CompletionHandler = (_ success: Bool) -> Void
    
    @EnvironmentObject var user : UserModel
    
    func setUserData(user: UserModel) {
       
            db.collection("databaseUserData")
            .whereField("username", isEqualTo: user.username)
                .getDocuments(){(querySnapshot,err) in
                    if let err = err {
                        print("Error \(err)")
                    } else {
                        if querySnapshot!.documents.isEmpty{

                        } else {
                            for document in querySnapshot!.documents{
                                print("THIS IS: \(document.documentID) is \(document.data())")
                                user.email = document.get("email") as! String
                               
                            }
                        }
                    }
                }
        
        }
    
    
    //TODO: setUserData is not working
    /*func setUserData(user: UserModel, completionHandler : @escaping CompletionHandler)
    {
        //completionHandler not finished
        var errorHandler = false
        print("START SETUSERDATA!")
        db.collection("databaseUserData")
            .whereField("username", isEqualTo: user.username)
            .getDocuments(){(querySnapshot,err) in
                if let err = err {
                    print("Error \(err)")
                } else {
                    if querySnapshot!.documents.isEmpty{
                        errorHandler = false
                        completionHandler(errorHandler)
                    } else {
                        for document in querySnapshot!.documents{
                            print("\(document.documentID) is \(document.data())")
                            
                        }
                    }
                }
            }
        
        
        db.collection("databaseUserData").whereField("username", isEqualTo: user.username)
            .getDocument{(document, err) in
            if let document = document, document.exists
            {
                let dataDes = document.data().map(String.init(describing:)) ?? "nil"
                print("document data: \(dataDes)")
                username = document.get("username") as! String
                email = document.get("email") as! String
                user.email = email
            } else
            {
                print("Doc does not exist")
            }
            
        }
        
        db.collection("databaseUserData").whereField("username", isEqualTo: user.username)
            .getDocument{(document,err) in
                //TODO: Add multiple user values here
                if let err = err {
                    print("Error \(err)")
                    email = "error"
                    
                } else {
                    let documentID = document.documentID
                    
                    user.email = email
                    print("Email is: \(email)")
                }
        }
    }*/
    
    //TODO: function to change UserData if necessary
    func changeUserData(username: String, completionHandler : @escaping CompletionHandler)
    {
        
    }
    
}
