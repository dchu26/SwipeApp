//
//  ContentView.swift
//  Swipe
//
//  Created by David Chu on 5/5/23.
//

import SwiftUI
import WrappingHStack
import Introspect

private var inviteList: [Person] = []
private var textColor: Color = Color(red: 0.71, green: 0.71, blue: 0.71)

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
                .font(.system(.body, design: .rounded))
                .background(Color(red: 0.584, green: 0.373, blue: 1.0))
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .foregroundColor(.white)
                .bold()
                .buttonStyle(.bordered)
                .offset(y: 20)
            }
            .padding()
            .background(Color(red: 0.2, green: 0.2, blue: 0.2))
        }
    }
}

struct CardView: View {
    var person: Person
    
    @State private var offset = CGSize.zero
    @State private var color: Color = .black
    
    var body: some View {
        GeometryReader { geometry in
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
            RoundedRectangle(cornerRadius: 20)
            /*Initializes the size of the card
             */
                .frame(width: geometry.size.width, height: geometry.size.height)
                .foregroundColor(color)
            //HStack is where the contents of the card should be displayed
            VStack {
                Image(person.photo)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width/2, height: geometry.size.width/2)
                    .clipShape(Circle())
                    .padding()
                
                VStack(alignment: .leading) {
                    Text(person.name)
                        .font(.system(.title, design: .rounded))
                        .foregroundColor(.white)
                        .bold()
                        .padding(.leading)
                    Text(person.role)
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(textColor)
                        .padding(.leading)
                    Text(person.location)
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(textColor)
                        .padding(.leading)
                        .padding(.bottom)
                    Text("About")
                        .font(.system(.title3, design: .rounded))
                        .foregroundColor(.white)
                        .bold()
                        .padding(.leading)
                    Text(person.about)
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(textColor)
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.bottom)
                    Text("Company name")
                        .font(.system(.title3, design: .rounded))
                        .foregroundColor(.white)
                        .bold()
                        .padding(.leading)
                    Text(person.company)
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(textColor)
                        .padding(.leading)
                        .padding(.bottom)
                    Text("Tags")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.white)
                        .bold()
                        .padding(.leading)
                    
                    
                    WrappingHStack{
                        ForEach(person.tags, id: \.self){ tag in
                            Text(tag)
                                .foregroundColor(.white)
                                .padding(5)
                                //.fixedSize(horizontal: true, vertical: false)
                                .overlay(RoundedRectangle(cornerRadius: 3)
                                    .stroke(Color(red: 0.584, green: 0.373, blue: 1.0), lineWidth: 2))
                                .padding(3)
                        }
                    }
                
                    
                    /*
                     
                     WrappingHStack{
                         ForEach(p.tags, id: \.self){ tag in
                             Text(tag)
                                 .foregroundColor(.white)
                                 .padding(5)
                                 .fixedSize(horizontal: true, vertical: false)
                                 .overlay(RoundedRectangle(cornerRadius: 3)
                                     .stroke(Color(red: 0.584, green: 0.373, blue: 1.0), lineWidth: 2))
                                 .padding(3)
                         }
                     }

                     
                     WrappingHStack{
                         ForEach(person.tags, id: \.self){ tag in
                             Text(tag)
                                 .foregroundColor(.white)
                                 .padding(3)
                                 .background(Rectangle().stroke())
                                 .padding(3)
                         }
                     }
                     */
    
                    HStack {
                        Spacer()
                        NavigationLink(destination: InfoView(p: person)){
                            Text("More...")
                        }
                        .bold()
                        .font(.system(.body, design: .rounded))
                        .background(Color(red: 0.584, green: 0.373, blue: 1.0))
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .foregroundColor(.white)
                        .buttonStyle(.bordered)
                        .padding(.trailing)
                    }
                }
                .padding(.leading)
            }
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
        
        /*
        //Swiping left
        if (width < -150 && width > -500 && height < 150 && height > -150){
            offset = CGSize(width: -500, height: 0)
        }
        //Swiping right
        else if (width > 150 && width < 500 && height < 150 && height > -150){
            offset = CGSize(width: 500, height: 0)
        }
        */
        
        //Swiping down, saves to list, add else if you want to modify swiping left and right actions
        if (width > -100 && width < 100 && height < 500 && height > 150){
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
        List{
            ForEach(inviteList, id: \.name) { list in
                NavigationLink(destination: InfoView(p: list), label: {
                    Image(list.photo)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .clipped()
                    VStack(alignment: .leading){
                        Text(list.name)
                            .font(.system(.body, design: .rounded))
                    }
                })
            }.onDelete{ index in
                inviteList.remove(atOffsets: index)
            }
        }
            .background(Color(red: 0.2, green: 0.2, blue: 0.2))
        //}
    }
}

//View for more detail on a person
struct InfoView: View {
    var p: Person
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading){
                    Image(p.photo)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width / 2, height: geometry.size.width / 2)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1.5))
                        .offset(x: geometry.size.width / 4)
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text(p.name)
                                .font(.system(.title, design: .rounded))
                                .foregroundColor(.white)
                                .bold()
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Text(p.role)
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(textColor)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Text(p.location)
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(textColor)
                                .padding(.bottom)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Text("About")
                                .font(.system(.title3, design: .rounded))
                                .foregroundColor(.white)
                                .bold()
                            
                            Text(p.about)
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(textColor)
                                .padding(.bottom)
                                .multilineTextAlignment(.leading)
                            //Necessary for making the interpreter not collapse the text
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Text("Company name")
                                .font(.system(.title3, design: .rounded))
                                .foregroundColor(.white)
                                .bold()
                            
                            Text(p.company)
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(textColor)
                                .padding(.bottom)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Text("Socials")
                                .font(.system(.title3, design: .rounded))
                                .foregroundColor(.white)
                                .bold()
                        }
                        
                        WrappingHStack{
                            Text(p.phone)
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(.white)
                                .padding(5)
                                .fixedSize(horizontal: true, vertical: false)
                                .overlay(RoundedRectangle(cornerRadius: 3)
                                    .stroke(Color(red: 0.584, green: 0.373, blue: 1.0), lineWidth: 2))
                                .padding(3)
                            Text(p.email)
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(.white)
                                .padding(5)
                                .fixedSize(horizontal: true, vertical: false)
                                .overlay(RoundedRectangle(cornerRadius: 3)
                                    .stroke(Color(red: 0.584, green: 0.373, blue: 1.0), lineWidth: 2))
                                .padding(3)
                            Text(p.linkedin)
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(.white)
                                .padding(5)
                                .fixedSize(horizontal: true, vertical: false)
                                .overlay(RoundedRectangle(cornerRadius: 3)
                                    .stroke(Color(red: 0.584, green: 0.373, blue: 1.0), lineWidth: 2))
                                .padding(3)
                            Text(p.whatsapp)
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(.white)
                                .padding(5)
                                .fixedSize(horizontal: true, vertical: false)
                                .overlay(RoundedRectangle(cornerRadius: 3)
                                    .stroke(Color(red: 0.584, green: 0.373, blue: 1.0), lineWidth: 2))
                                .padding(3)
                            Text(p.telegram)
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(.white)
                                .padding(5)
                                .fixedSize(horizontal: true, vertical: false)
                                .overlay(RoundedRectangle(cornerRadius: 3)
                                    .stroke(Color(red: 0.584, green: 0.373, blue: 1.0), lineWidth: 2))
                                .padding(3)
                            }
                        }
                            
                        Text("Tags")
                            .font(.system(.title3, design: .rounded))
                            .foregroundColor(.white)
                            .bold()
                    
                        Spacer()
                    
                        WrappingHStack{
                            ForEach(p.tags, id: \.self){ tag in
                                Text(tag)
                                    .foregroundColor(.white)
                                    .padding(5)
                                    //.fixedSize(horizontal: true, vertical: false)
                                    .overlay(RoundedRectangle(cornerRadius: 3)
                                        .stroke(Color(red: 0.584, green: 0.373, blue: 1.0), lineWidth: 2))
                                    .padding(3)
                                    
                            }
                        }
                    }
                }
            .padding(.leading)
            }
        .background(.black)
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
