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
                 To do: Make the card size dynamic so that it fits the size of any iOS device regardless of the dimensions
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
                        changeColor(width: offset.width)
                    }
                } .onEnded { _ in
                    withAnimation{
                        swipeCard(width: offset.width)
                        changeColor(width: offset.width)
                    }
                }
        )
    }
    
    //Function for handling the swiping of the card horizontally
    func swipeCard(width: CGFloat){
        switch width{
        case -500...(-150):
            print("\(person) removed")
            offset = CGSize(width: -500, height: 0)
        case 150...(500):
            print("\(person) added")
            offset = CGSize(width: 500, height: 0)
        default:
            offset = .zero
        }
    }
    
    //Function for changing the color of the card when dragged left or right
    func changeColor(width: CGFloat){
        switch width{
        case -500...(-130):
            color = .red
        case 130...(500):
            color = .green
        //Currently, default color of the background of the card is set to black
        default:
            color = .black
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(person: "One")
    }
}

