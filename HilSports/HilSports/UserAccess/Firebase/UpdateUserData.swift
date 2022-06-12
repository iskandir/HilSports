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
                            //Set user information here
                            for document in querySnapshot!.documents{
                                print("THIS IS: \(document.documentID) is \(document.data())")
                                user.email = document.get("email") as! String
                                
                            }
                        }
                    }
                }
        }
    
    //TODO: function to change UserData if necessary
    func changeUserData(username: String, completionHandler : @escaping CompletionHandler)
    {
        
    }
    
}
