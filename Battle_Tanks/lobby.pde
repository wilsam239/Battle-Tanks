class lobby {
  PApplet battle_tanks;
  // Stores the x and y values for the first button
  int option1X, option1Y;
  // Stores the x and y values for the second button
  int option2X, option2Y;
  int buttonSizeWidth = 390;
  // Stores the height of the button
  int buttonSizeHeight = 60;
  // Stores a boolean that determines whether the user's mouse is over the buttons
  boolean overOptionOne, overOptionTwo;
  // The background image of the screen
  PImage bg;
  PFont buttonFont;
  PImage regular, hover;
  boolean selectionMade, connectionMade, host, user;
  
  lobby(PApplet sketch) {
    battle_tanks = sketch;
    option1X = option2X = width/2 - buttonSizeWidth/2;
    option1Y = height/2 - 50;
    option2Y = option1Y + 3*buttonSizeHeight/2;
    // Loads the background image into the bg variable
    bg = loadImage("assets/screens/TitleScreen2.png");
    buttonFont = loadFont("data/Impact-20.vlw");
    regular = loadImage("assets/buttons/regular.png");
    hover = loadImage("assets/buttons/onhover.png");
    selectionMade = connectionMade = host = user = false;
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
        Host = new host(battle_tanks);
        host = true;
        nwgs = new networkGame(true);
        selectionMade = true;
        //delay(100);
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
    text("Host A Game", option1X + buttonSizeWidth/2, option1Y + buttonSizeHeight/1.5);
  }
  void optionTwo() {
    // Button number two
    if (overOptionTwo) {
      // If the mouse is over option two
      // Change the button to the hover image
      image(hover,option2X, option2Y);
      fill(255);
      if (mousePressed) {
        User = new user(battle_tanks);
        nwgs = new networkGame(false);
        selectionMade = true;
        user = true;
        // Delay the input by 100 milliseconds
        delay(100);
        screen = 4;
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
    text("Join A Game", option2X + buttonSizeWidth/2, option2Y + buttonSizeHeight/1.5);
    //delay(1000);
  }
  
  void draw() {
    // Display the background image
    background(bg);
    update();
    if(!selectionMade) {
      // Call the optionOne function to display the first button
      optionOne();
      optionTwo();
    } else if (selectionMade && !connectionMade && host) {
      optionThree();
    //} else if (selectionMade && connectionMade && user) {
      //optionFour();
    } else if (selectionMade && connectionMade) {
      optionFive();
    }
      
      
    
  }
  
  void optionThree() {
    image(regular, option1X, option1Y);
    fill(0);
    textFont(buttonFont);
    // Set the size of the text
    textSize(25);
    // Set the text to align to the centre of it's bounding box
    textAlign(CENTER);
    // Display the text in the middle of the button
    text("Awaiting Connection", option1X + buttonSizeWidth/2, option1Y + buttonSizeHeight/1.5);
    
  }
  
  /*void optionFour() {
    image(regular, option1X, option1Y);
    fill(0);
    textFont(buttonFont);
    // Set the size of the text
    textSize(25);
    // Set the text to align to the centre of it's bounding box
    textAlign(CENTER);
    // Display the text in the middle of the button
    text("Conencted to Server!", option1X + buttonSizeWidth/2, option1Y + buttonSizeHeight/1.5);
  }*/
  
  void optionFive() {
    image(regular, option1X, option1Y);
    fill(0);
    textFont(buttonFont);
    // Set the size of the text
    textSize(25);
    // Set the text to align to the centre of it's bounding box
    textAlign(CENTER);
    // Display the text in the middle of the button
    text("Client Connected!", option1X + buttonSizeWidth/2, option1Y + buttonSizeHeight/1.5);
    delay(1000);
    screen = 4;
  }
  
  void update() {
    // Check if the current x,y coords of the mouse are over any of the buttons
    if ( overOption(option1X, option1Y, buttonSizeWidth, buttonSizeHeight) ) {
      overOptionOne = true;
      overOptionTwo = false;
    } else if (overOption(option2X, option2Y, buttonSizeWidth, buttonSizeHeight) ) {
      overOptionTwo = true;
      overOptionOne = false;
    } else overOptionOne = overOptionTwo = false;
  }
  
  boolean overOption(int x, int y, int width, int height)  {
    // If the mouse is in between the ends of the button return true
    if (mouseX >= x && mouseX <= x+width && 
        mouseY >= y && mouseY <= y+height) {
      return true;
    } else return false;
  }
  
}