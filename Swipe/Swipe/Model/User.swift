//
//  User.swift
//  Swipe
//
//  Created by David Chu on 7/24/23.
//

import Foundation

class User: ObservableObject {
    var firstName: String
    var lastName: String
    var bio: String
    
    init() {
        self.firstName = ""
        self.lastName = ""
        self.bio = ""
    }
    
    func editFirstName(fName: String){
        self.firstName = fName
    }
    
    func editLast(lName: String){
        self.lastName = lName
    }
    
    func editBio(newBio: String){
        self.bio = newBio
    }

    func getUser() -> User{
        return self
    }
    
    func getFirstName() -> String{
        return self.firstName
    }
    
    func getLastName() -> String{
        return self.lastName
    }
    
    func getBio() -> String{
        return self.bio
    }
    
}
