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
  // Stores the width of the button
  int buttonSizeWidth = 400;
  // Stores the height of the button
  int buttonSizeHeight = 50;
  // Stores a boolean that determines whether the user's mouse is over the buttons
  boolean overOptionOne, overOptionTwo;
  // The background image of the screen
  PImage bg;
  PFont buttonFont;
  
  // The default constructor for the mainMenu
  mainMenu() {
    // Sets the x,y coords of the buttons
    option1X = width/2 - buttonSizeWidth/2;
    option1Y = height/2;
    option2X = width/2 - buttonSizeWidth/2;
    option2Y = height/2;
    // Loads the background image into the bg variable
    bg = loadImage("assets/TitleScreen.png");
    buttonFont = loadFont("data/Impact-20.vlw");
  }
  
  void optionOne() {
    // Button number one
    if (overOptionOne) {
      // If the mouse is over option one
      // Change the colour of the button
      fill(255,0,0);
      if (mousePressed) {
        // If the mouse is pressed change the screen variable to start the game
        screen = 1;
      }
    } else fill(200,200,200); // if the user's mouse is not over the button, display the defualt colour
    // Set the stroke to white
    stroke(255);
    // Draw the rectangle at the x,y coords of the button
    rectMode(CORNER);
    rect(option1X, option1Y, buttonSizeWidth, buttonSizeHeight);
    textFont(buttonFont);
    // Set the size of the text
    textSize(25);
    // Set the text to align to the centre of it's bounding box
    textAlign(CENTER);
    // Fill the text as black
    fill(0);
    // Display the text in the middle of the button
    text("Local Multiplayer", option1X + buttonSizeWidth/2, option1Y + buttonSizeHeight/1.5);
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
  }
  
  void update() {
    // Check if the current x,y coords of the mouse are over any of the buttons
    //println(x,y);
    if ( overOptionOne(option1X, option1Y, buttonSizeWidth, buttonSizeHeight) ) {
      overOptionOne = true;
      overOptionTwo = false;
    } else if (overOptionTwo(option2X, option2Y, buttonSizeWidth, buttonSizeHeight) ) {
      overOptionTwo = true;
      overOptionOne = false;
    } else overOptionOne = overOptionTwo = false;
  }
  
  boolean overOptionOne(int x, int y, int width, int height)  {
    // If the mouse is in between the ends of the button return true
    if (mouseX >= x && mouseX <= x+width && 
        mouseY >= y && mouseY <= y+height) {
      return true;
    } else return false;
  }
  
  boolean overOptionTwo(int x, int y, int width, int height)  {
    // If the mouse is in between the ends of the button return true
    if (mouseX >= x && mouseX <= x+width && 
        mouseY >= y && mouseY <= y+height) {
      return true;
    } else return false;
  }
  
}
     