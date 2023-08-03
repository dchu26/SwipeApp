//
//  JSONManager.swift
//  Swipe
//
//  Created by David Chu on 5/8/23.
//

import Foundation

//struct for a person
struct Person: Codable {
    //Attributes of a person object
    var name: String
    var photo: String
    var about: String
    var company: String
    var email: String
    var telegram: String
    var whatsapp: String
    var phone: String
    var linkedin: String
    var tags: [String]
    var notes: String
    var location: String
    var role: String
    
    //Name of file should be put there
    static let allPeople: [Person] = Bundle.main.decode(file: "example.json")
    
    static let matches: [Person] = Bundle.main.decode(file: "example2.json")
    
    //For sample preview
    static let samplePerson: Person = allPeople[0]
    
    //Quick check if both Persons are the same
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.email == rhs.email && lhs.name == rhs.name && lhs.telegram == rhs.telegram
    }
    
}



extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else{
            fatalError("Could not find \(file) in the project!")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file) in the project!")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode \(file) in the project!")
        }
        
        return loadedData
    }
}
