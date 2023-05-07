//
//  CardView.swift
//  Swipe
//
//  Created by David Chu on 5/5/23.
//

import SwiftUI

struct CardView: View {
    var person: String
    
    @State private var offset = CGSize.zero
    @State private var color: Color = .black
    
    var body: some View {
        ZStack{
            //Rectangle is where the card itself will be changed
            Rectangle()
                /*Initializes the size of the card
                */
                .frame(width: 320, height: 420)
                .border(.white, width: 6.0)
                .cornerRadius(4)
                .foregroundColor(color.opacity(0.9))
                .shadow(radius: 4)
            //HStack is where the contents of the card should be displayed
            HStack{
                Text(person)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                
            }
        }
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
    
    //Function for handling the swiping of the card horizontally, original function for testing swiping mechanic
    func swipeCard(width: CGFloat){
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
        //Swiping down
        else if (width > -100 && width < 100 && height < 500 && height > 150){
            offset = CGSize(width: 0, height: 500)
        }
        //Swiping up
        else if (width > -100 && width < 100 && height < -150 && height > -500){
            offset = CGSize(width: 0, height: -500)
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

//Preview
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(person: "test")
    }
}

