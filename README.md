# HundredDaysSwift

### Project 1: Storm Viewer - Image Viwer App
 - [Hundred days of swift link: Project 1](https://www.hackingwithswift.com/read/1/overview)
 - [Link to swift project 1](https://github.com/bkapadia01/HundredDaysSwift/tree/main/Project1)
 - In this project I produce an application that lets users scroll through a list of images, then select one to view. 
 - Challenge: 
   - Use Interface Builder to select the text label inside your table view cell and adjust its font size to something larger – experiment and see what looks good.
   - In your main table view, show the image names in sorted order, so “nssl0033.jpg” comes before “nssl0034.jpg”.
   - Rather than show image names in the detail title bar, show “Picture X of Y”, where Y is the total number of images and X is the selected picture’s position in the array. Make sure you count from 1 rather than 0.

 

### Project 2: Guess The Flag - Game using UIKit 
 - [Hundred days of swift link: Project 2](https://www.hackingwithswift.com/read/2/overview)
 - [Link to swift project 2](https://github.com/bkapadia01/HundredDaysSwift/tree/main/Project2)
 - In this project I produce a game that shows some random flags to users and asks them to choose which one belongs to a particular country.
 - Challenge:
   - Try showing the player’s score in the navigation bar, alongside the flag to guess.
   - Keep track of how many questions have been asked, and show one final alert controller after they have answered 10. This should show their final score.
   - When someone chooses the wrong flag, tell them their mistake in your alert message – something like “Wrong! That’s the flag of France,” for example. 


### Project 3: Social Media - Share to social media addition to Project 1
 - [Hundred days of swift link: Project 3](https://www.hackingwithswift.com/read/3/overview)
 - [Link to swift project 3](https://github.com/bkapadia01/HundredDaysSwift/tree/main/Project3)
 - In this project I modify project 1 to allow users to share images with their friends.
 - Challenge: 
   -  Try adding the image name to the list of items that are shared. The activityItems parameter is an array, so you can add strings and other things freely. Note: Facebook won’t let you share text, but most other share options will.
   -  Go back to project 1 and add a bar button item to the main view controller that recommends the app to other people.
   -  Go back to project 2 and add a bar button item that shows their score when tapped.


### Project 4: Easy Browser - Embed Web Kit application
 - [Hundred days of swift link: Project 4](https://www.hackingwithswift.com/read/4/overview)
 - [Link to swift project 4](https://github.com/bkapadia01/HundredDaysSwift/tree/main/Project4)
 - In this project I build on knowledge of UIBarButtonItem and UIAlertController by producing a simple web browser app.
 - Challenge:
   - If users try to visit a URL that isn’t allowed, show an alert saying it’s blocked.
   - Try making two new toolbar items with the titles Back and Forward. You should make them use webView.goBack and webView.goForward.
   - For more of a challenge, try changing the initial view controller to a table view like in project 1, where users can choose their website from a list rather than just having the first in the array loaded up front. 


### Project 5: Word Scramble - An anagram game
 - [Hundred days of swift link: Project 5](https://www.hackingwithswift.com/read/5/overview)
 - [Link to swift project 5](https://github.com/bkapadia01/HundredDaysSwift/tree/main/project5)
 - In this project i make a word game that deals with anagrams.
 - Challenge: 
   - Disallow answers that are shorter than three letters or are just our start word. For the three-letter check, the easiest thing to do is put a check into isReal() that returns false if the word length is under three letters. For the second part, just compare the start word against their input word and return false if they are the same.
   - Refactor all the else statements we just added so that they call a new method called showErrorMessage(). This should accept an error message and a title, and do all the UIAlertController work from there.
   - Add a left bar button item that calls startGame(), so users can restart with a new word whenever they want to.  


### Project 6: Auto-layout - Auto Layout using practical examples
 - [Hundred days of swift link: Project 6](https://www.hackingwithswift.com/read/6/overview)
 - [Link to swift project 6a](https://github.com/bkapadia01/HundredDaysSwift/tree/main/Project6a)
 - [Link to swift project 6b](https://github.com/bkapadia01/HundredDaysSwift/tree/main/project6b)
 - In this technique project I learn more about Auto Layout, the powerful and expressive way iOS lets you design your layouts by updating Project 2
 - Challenge:
   - Try replacing the widthAnchor of our labels with leadingAnchor and trailingAnchor constraints, which more explicitly pin the label to the edges of its parent.
   - Once you’ve completed the first challenge, try using the safeAreaLayoutGuide for those constraints. You can see if this is working by rotating to landscape, because the labels won’t go under the safe area.
   - Try making the height of your labels equal to 1/5th of the main view, minus 10 for the spacing. This is a hard one, but I’ve included hints below!  



### Project 7: Whitehouse Petitions -  Display and parse JSON of Whitehouse petitions
 - [Hundred days of swift link: Project 7](https://www.hackingwithswift.com/read/7/overview)
 - [Link to swift project 7](https://github.com/bkapadia01/HundredDaysSwift/tree/main/project7)
 - This project I take a data feed from a website and parse it into useful information for users.
 - Challenge: 
   - Add a Credits button to the top-right corner using UIBarButtonItem. When this is tapped, show an alert telling users the data comes from the We The People API of the Whitehouse.
   - Let users filter the petitions they see. This involves creating a second array of filtered items that contains only petitions matching a string the user entered. Use a UIAlertController with a text field to let them enter that string. This is a tough one, so I’ve included some hints below if you get stuck.
   - Experiment with the HTML – this isn’t a HTML or CSS tutorial, but you can find lots of resources online to give you enough knowledge to tinker with the layout a little. 

### Project 8: Seven Swifty Words - A Word-guessing game 
 - [Hundred days of swift link: Project 8](https://www.hackingwithswift.com/read/8/overview)
 - [Link to swift project 8](https://github.com/bkapadia01/HundredDaysSwift/tree/main/Project8)
 - I make a word game based on the popular indie game 7 Little Words.
 - Challenge: 
   - Use the techniques you learned in project 2 to draw a thin gray line around the buttons view, to make it stand out from the rest of the UI.
   - If the user enters an incorrect guess, show an alert telling them they are wrong. You’ll need to extend the submitTapped() method so that if firstIndex(of:) failed to find the guess you show the alert.
   - Try making the game also deduct points if the player makes an incorrect guess. Think about how you can move to the next level – we can’t use a simple division remainder on the player’s score any more, because they might have lost some points.
 


### Project 9: Grand Central Dispatch - Run complex tasks in background
 - [Hundred days of swift link: Project 9](https://www.hackingwithswift.com/read/9/overview)
 - [Link to swift project 8](https://github.com/bkapadia01/HundredDaysSwift/tree/main/Project8)
