//
//  JSONManager.swift
//  Swipe
//
//  Created by David Chu on 5/8/23.
//

import Foundation

struct Person: Codable {
    var firstName: String
    //Name of file should be put there
    static let allPeople: [Person] = Bundle.main.decode(file: "example.json")
    
    //For sample preview
    static let samplePerson: Person = allPeople[0]
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
