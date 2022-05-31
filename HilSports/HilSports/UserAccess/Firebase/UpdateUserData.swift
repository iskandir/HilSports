//
//  UserData.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 25.05.22.
//

import SwiftUI
import Firebase

struct UpdateUserData
{
    typealias CompletionHandler = (_ success: Bool) -> Void
    private let db = Firestore.firestore()
    
    @StateObject var user = UserModel()
    
    func setUserData(username : String, completionHandler: @escaping CompletionHandler) -> String
    {
        var setUserDataCompleted = false
        var email = ""
        let dbAccess = db.collection("databaseUserData").document("\(username)")
        dbAccess.getDocument{(document, error) in
            if let document = document, document.exists {
                //TODO: Add multiple user values here
                if let err = error {
                    print("Error \(err)")
                    completionHandler(setUserDataCompleted)
                    email = "error"
                } else {
                    setUserDataCompleted = true
                    email = document.get("email") as! String
                    print("Email is: \(email)")
                    completionHandler(setUserDataCompleted) 
                }
            }
        }
        print("Mail is : \(email)")
        return email
    }
    
    //TODO: function to change UserData if necessary
    func changeUserData(username: String, completionHandler : @escaping CompletionHandler)
    {
        
    }
    
}
