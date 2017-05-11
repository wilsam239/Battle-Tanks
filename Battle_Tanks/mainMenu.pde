/* 
      Function:
        mainMenu class
      Author:
        Sam
      Description:
        This class is used to draw the main menu, which is the first screen
        that the user sees when the program is run. It has interactable buttons.
*/
class mainMenu {
  // Stores the x and y values for the first button
  int option1X, option1Y;
  // Stores the x and y values for the second button
  int option2X, option2Y;
  int option3X, option3Y;
  // Stores the width of the button
  int buttonSizeWidth = 390;
  // Stores the height of the button
  int buttonSizeHeight = 60;
  // Stores a boolean that determines whether the user's mouse is over the buttons
  boolean overOptionOne, overOptionTwo, overOptionThree;
  // The background image of the screen
  PImage bg, loadingImg;
  PFont buttonFont;
  PImage regular, hover;
  
  // The default constructor for the mainMenu
  mainMenu() {
    // Sets the x,y coords of the buttons
    option1X = option2X = option3X = width/2 - buttonSizeWidth/2;
    option1Y = height/2 - 50;
    option2Y = option1Y + 3*buttonSizeHeight/2;
    option3Y = option2Y + 3*buttonSizeHeight/2;
    // Loads the background image into the bg variable
    bg = loadImage("assets/screens/TitleScreen2.png");
    buttonFont = loadFont("data/Impact-20.vlw");
    regular = loadImage("assets/buttons/regular.png");
    hover = loadImage("assets/buttons/onhover.png");
    
    //background(loadingImg);
  }
  
  void optionOne() {
    // Button number one
    if (overOptionOne) {
      // If the mouse is over option one
      // Change the button to the hover image
      image(hover,option1X, option1Y);
      fill(255);
      if (mousePressed) {
        // If the mouse is pressed change the screen variable to start the game
        screen = 2;
        delay(100);
      }
    } else {
      // if the user's mouse is not over the button, display the regular button
      image(regular, option1X, option1Y);
      fill(0);
    }
       
    textFont(buttonFont);
    // Set the size of the text
    textSize(25);
    // Set the text to align to the centre of it's bounding box
    textAlign(CENTER);
    // Display the text in the middle of the button
    text("Local Multiplayer", option1X + buttonSizeWidth/2, option1Y + buttonSizeHeight/1.5);
  }
  
  void optionTwo() {
    // Button number two
    if (overOptionTwo) {
      // If the mouse is over option two
      // Change the button to the hover image
      image(hover,option2X, option2Y);
      fill(255);
      if (mousePressed) {
        // If the mouse is pressed change the screen variable to start the game
        screen = 3;
        // Delay the input by 100 milliseconds
        delay(100);
      }
    } else {
       // if the user's mouse is not over the button, display the regular button
      image(regular, option2X, option2Y);
      fill(0);
    }
    textFont(buttonFont);
    // Set the size of the text
    textSize(25);
    // Set the text to align to the centre of it's bounding box
    textAlign(CENTER);
    // Display the text in the middle of the button
    text("Online Multiplayer", option2X + buttonSizeWidth/2, option2Y + buttonSizeHeight/1.5);
  }
  
  void optionThree() {
    // Button number three
    if (overOptionThree) {
      // If the mouse is over option one
      // Change the button to the hover image
      image(hover,option3X, option3Y);
      fill(255);
      if (mousePressed) {
        // If the mouse is pressed change the screen variable to start the game
        exit();
      }
    } else { 
      // if the user's mouse is not over the button, display the regular button
      image(regular, option3X, option3Y);
      fill(0);
    }
    textFont(buttonFont);
    // Set the size of the text
    textSize(25);
    // Set the text to align to the centre of it's bounding box
    textAlign(CENTER);
    // Fill the text as black
    // Display the text in the middle of the button
    text("Quit to Desktop", option3X + buttonSizeWidth/2, option3Y + buttonSizeHeight/1.5);
  }
  
  void draw() {
    // Display the background image
    background(bg);    
    /* Draws a grid to the screen
    for (int x = 0; x < width; x+=30) {
      for (int y = 0; y < height; y+=30) {
        line(0,y, width,y);
        line(x,0, x,height);
      }
    }*/
    // Call the update function and pass the mouse position in
    update();
    // Call the optionOne function to display the first button
    optionOne();
    optionTwo();
    optionThree();
  }
  
  void update() {
    // Check if the current x,y coords of the mouse are over any of the buttons
    if ( overOption(option1X, option1Y, buttonSizeWidth, buttonSizeHeight) ) {
      overOptionOne = true;
      overOptionTwo = false;
      overOptionThree = false;
    } else if (overOption(option2X, option2Y, buttonSizeWidth, buttonSizeHeight) ) {
      overOptionTwo = true;
      overOptionOne = false;
      overOptionThree = false;
    } else if (overOption(option3X, option3Y, buttonSizeWidth, buttonSizeHeight) ) {
      overOptionTwo = false;
      overOptionOne = false;
      overOptionThree = true;
    } else overOptionOne = overOptionTwo = overOptionThree = false;
  }
  
  boolean overOption(int x, int y, int width, int height)  {
    // If the mouse is in between the ends of the button return true
    if (mouseX >= x && mouseX <= x+width && 
        mouseY >= y && mouseY <= y+height) {
      return true;
    } else return false;
  }  
}
     