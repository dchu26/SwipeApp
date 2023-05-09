//
//  ContentView.swift
//  Swipe
//
//  Created by David Chu on 5/5/23.
//

import SwiftUI

struct ContentView: View {
    
    //Temporarily using an array of strings as placeholders, will change later to accommodate for data to be read
    
    //private var people: [String] = ["One", "Two", "Three", "Four", "Five"].reversed()
    
    private var people: [Person] = Person.allPeople.reversed()
    
    var body: some View {
        VStack {
            ZStack{
                ForEach(people, id: \.firstName){ person in
                    CardView(person: person)
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

