//
//  ContentView.swift
//  Swipe
//
//  Created by David Chu on 5/5/23.
//

import SwiftUI

private var inviteList: [Person] = []

struct ContentView: View {
    
    //Temporarily using an array of strings as placeholders, will change later to accommodate for data to be read
    
    //private var people: [String] = ["One", "Two", "Three", "Four", "Five"].reversed()
    
    private var people: [Person] = Person.allPeople.reversed()
    
    var body: some View {
        //NavigationView for the entire screen
        NavigationView {
            VStack {
                ZStack{
                    //Makes a cardView for each person in the list of people
                    ForEach(people, id: \.name){ person in
                        CardView(person: person)
                    }
                }
                //Button to see invite list
                NavigationLink(destination: ListView()){
                    Text("Saved List")
                }
                .background(.blue)
                .clipShape(Capsule())
                .foregroundColor(.white)
                .buttonStyle(.bordered)
            }
            .padding()
            
        }
    }
}

struct CardView: View {
    var person: Person
    
    @State private var offset = CGSize.zero
    @State private var color: Color = .black
    
    var body: some View {
        //GeometryReader { geometry in
            ZStack{
                //VStack {
                    /*
                     Image("person_1")
                         .resizable()
                         .scaledToFill()
                         .frame(width: geometry.size.width, height: geometry.size.height * 0.75) // 3
                         .clipped()
                     */
                    //Rectangle is where the card itself will be changed
                    Rectangle()
                    /*Initializes the size of the card
                     */
                        .frame(width: 400, height: 600)
                        .border(.white, width: 6.0)
                        .cornerRadius(4)
                        .foregroundColor(color.opacity(0.9))
                        .shadow(radius: 4)
                    //HStack is where the contents of the card should be displayed
                    VStack{
                        Image(person.photo)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 300)
                            .clipped()
                        Text(person.name)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .bold()
                            .multilineTextAlignment(.center)
                        Text(person.company)
                            .font(.title2)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                        Text(person.about)
                            .font(.body)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                }
            //}
        //}
        //This portion creates the card movement effect; changing the height and width multiplier changes the speed of the swipe effect
        .offset(x: offset.width, y: offset.height * 1.5)
        //Currently set to a rotation effect, which can be changed
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    //Animation for changing the color
                    withAnimation{
                        changeColor(height: offset.height)
                    }
                    //When the card is fully swiped
                } .onEnded { _ in
                    withAnimation{
                        //swipeCard(width: offset.width)
                        //swipeCardUp(height: offset.height)
                        swipeCardHandler(width: offset.width, height: offset.height)
                        changeColor(height: offset.height)
                    }
                }
        )
    }
    
    /*
    //Function for handling the swiping of the card horizontally, original function for testing swiping mechanic
    mutating func swipeCard(width: CGFloat){
        switch width{
        case -500...(-150):
            print("\(person) removed")
            offset = CGSize(width: -500, height: 0)
        case 150...(500):
            print("\(person) added")
            offset = CGSize(width: 500, height: 0)
        //Defaults the card to the center of the screen
        default:
            offset = .zero
        }
    }
    
    //Function for handling the swiping of the card vertically, originally used to test swiping up mechanic
    func swipeCardUp(height: CGFloat){
        switch height{
        case -500...(-150):
            print("\(person) removed")
            offset = CGSize(width: 0, height: -800)
        case 150...(500):
            print("\(person) added")
            offset = CGSize(width: 0, height: 800)
        //Defaults the card to the center of the screen
        default:
            offset = .zero
        }
    }
    */
    
    //Function for handling the swiping of the card in 4 directions
    func swipeCardHandler(width: CGFloat ,height: CGFloat){
        //Cases for handling width and height, defaults to an offset of zero
        
        //Swiping left
        if (width < -150 && width > -500 && height < 150 && height > -150){
            offset = CGSize(width: -500, height: 0)
        }
        //Swiping right
        else if (width > 150 && width < 500 && height < 150 && height > -150){
            offset = CGSize(width: 500, height: 0)
        }
        //Swiping down, saves to list
        else if (width > -100 && width < 100 && height < 500 && height > 150){
            inviteList.append(person)
            print(inviteList)
            //print("\(person) Added")
            offset = CGSize(width: 0, height: 700)
        }
        //Swiping up, discards
        else if (width > -100 && width < 100 && height < -150 && height > -500){
            //print("\(person) Removed")
            offset = CGSize(width: 0, height: -700)
        }
        //Defaults to center of the screen, i.e. user does not swipe in an accepted direction
        else{
            offset = .zero
        }
        
    }
    
    //Function for changing the color of the card when dragged left or right
    func changeColor(height: CGFloat){
        switch height{
        //Swiping up is to discard
        case -500...(-130):
            color = .red
        //Swiping down is to save
        case 130...(500):
            color = .green
        //Currently, default color of the background of the card is set to black
        default:
            color = .black
        }
    }
}

//View for inviteList
struct ListView: View {
    var body: some View {
        //Where we can see their image and name, click for more info
        //Do not need to make another NavigationView, this is simply here to test the initial view
        //NavigationView {
            List(inviteList, id: \.name) { list in
                NavigationLink(destination: InfoView(p: list), label: {
                    Image(list.photo)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .clipped()
                    VStack(alignment: .leading){
                        Text(list.name)
                    }
                })
            }
        //}
    }
}

//View for more detail on a person
struct InfoView: View {
    var p: Person
    var body: some View {
        VStack{
            Image(p.photo)
            Text(p.name)
                .bold()
            Text("**Company**: \(p.company)")
            Text("**Location**: \(p.location)" )
            Text("**Phone**: \(p.phone)")
            Text("**Email**: \(p.email)")
            Text("**LinkedIn**: \(p.linkedin)")
            Text("**WhatsApp**: \(p.whatsapp)")
            Text("**Telegram**: \(p.telegram)")
            Text("**Tags**: \(p.tags.joined(separator: ", "))")
                .multilineTextAlignment(.center)
        }
    }
}

//Preview
struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(p: Person.samplePerson)
    }
}

//Preview
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}


//Preview
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(person: Person.samplePerson)
    }
}

//Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

