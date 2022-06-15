//
//  RegistrationModel.swift
//  HilSports
//
//  Created by Dennis Hasselbusch on 31.08.21.
//

import Foundation

class UserModel : ObservableObject{
    //Published is used when you wanna reach the target to update your variable everytime its status has been changed
    @Published var username : String = ""
    @Published var password : String = ""
    @Published var email : String = ""
    @Published var aboutYou : String = ""
    @Published var name : String = ""
    @Published var age : String = ""
    @Published var favSports : [String] = [""]
    @Published var image : String = ""
    @Published var peopleMet : Int = 0
    @Published var visitedActivities : Int = 0
    
    //MARK: init for simple debugging
    init(username: String, password: String, email: String){
        self.username = username
        self.password = password
        self.email = email
    }
    //MARK: init for debugging without image
    init(username: String, password: String, email: String, name: String, age: String, favSports: [String], peopleMet: Int, visitedActivities: Int){
        self.username = username
        self.password = password
        self.email = email
        self.name = name
        self.age = age
        self.favSports = favSports
        self.peopleMet = peopleMet
        self.visitedActivities = visitedActivities
    }
    //MARK: init for debugging with image
    init(username: String, password: String, email: String, aboutYou: String, name: String, age: String, favSports: [String], image: String, peopleMet: Int, visitedActivities: Int){
        self.username = username
        self.password = password
        self.email = email
        self.aboutYou = aboutYou
        self.name = name
        self.age = age
        self.favSports = favSports
        self.image = image
        self.peopleMet = peopleMet
        self.visitedActivities = visitedActivities
    }
}

