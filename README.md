# Swipe

## Project Specs and Functionalities

- Initially, there is a deck of cards with profiles on them. You can swipe up to discard the profile, or swipe down to save this profile to a list of people you want to invite. If you want to learn more about the person, you can click the "More..." button and if you want to see your list, you can click the "Saved List" button.
- You can delete a profile from your saved list by navigating to your saved list and swiping left on the entry that you want to discard, and then press "Delete", which will remove the person from the list.
- As of right now, the profiles are all coded into a json file in the project and are static, with no API calls or database schema, so the program will work in areas with no internet connectivity. 
- For a visual demonstration of how the app works, scroll down to the latest version and watch the gif.

## Project Requirements

- Will have to contain a stack of “cards” initially
    - Temporarily will use placeholder data in the form of a json file or something similar
- Store data as “cards”
    - Can perform actions on these cards through swiping (up, down, left, right)
    - Possible options for swipe commands listed below
        - A. Ability to move back and forth between cards
            - Up = Discard
            - Down = Save into invite list
            - Left = Previous card
            - Right = Next card
        - B. No ability to move back and forth between cards
            - Left = Discard
            - Right = Save into invite list
        - C. Add an undecided option
            - Left = Discard
            - Right = Save into invite List
            - Up/Down = Undecided
- Be able to see your list of saved cards
    - Potentially be able to further refine the list if necessary through swiping

## Extra Goals

- Animation for swiping
    - Card goes in the direction of the swipe
- Maybe an animation for flipping the card when tapping it
    - This would only be applicable if flipping the card to reveal more information about the person is important to the design of the project (i.e., more information about their background or accomplishments, etc. that would not fit on the first side)
- Any other UI improvements that may make the project look more visually appealing and intuitive for the user
    - Including but not limited to color choices, design decisions, etc…


## Visual Progress

- v1
    - Cards are only able to be swiped left and right
<img src='http://g.recordit.co/K0TIsjIolk.gif' title='Demo v1' width='' alt='Demo'>

- v2
    - Cards can be swiped up, down, left, and right
<img src='http://g.recordit.co/vNTsK5PxP2.gif' title='Demo v2' width='' alt='Demo v2'>

- v3
    - Cards can be saved and more information about the card can be displayed from the save list
<img src='http://g.recordit.co/3Vajs3cUYE.gif' title='Demo v3' width='' alt='Demo v3'>

- v4
    - Full information about the person is displayed in the InfoView
    - More information displayed on the initial CardView
<img src='http://g.recordit.co/76Zk1KRIlp.gif' title='Demo v4' width='' alt='Demo v4'>

- v5
    - More information can be accessed from the initial CardView
    - UI updated to look cleaner and more modern
<img src='http://g.recordit.co/99R8vbfLnQ.gif' title='Demo v5' width='' alt='Demo v5'>
