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
                                /* MARK: only for Debugging print("THIS IS: \(document.documentID) is \(document.data())")*/
                                user.email = document.get("email") as! String
                                user.name = document.get("name") as! String
                                user.age = document.get("age") as! String
                                user.favSports = document.get("favSports") as! [String]
                                user.aboutYou = document.get("aboutyou") as! String
                                //user.image = document.get("image") as! String
                                user.peopleMet = document.get("peopleMet") as! Int
                                user.visitedActivities = document.get("visitedActivities") as! Int
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
