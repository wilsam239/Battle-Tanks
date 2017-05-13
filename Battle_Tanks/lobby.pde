/* 
      Function:
        lobby class
      Author:
        Sam.
      Description:
        This class is used to draw the network lobby in which a player can select
        to either host, or join a game. It simply displays the buttons required
        and tells the suer what is going on after clicking them. ie: Searching for
        client.
*/

class lobby {
  // The sketch
  PApplet battle_tanks;
  
  // Stores the x and y values for the first button
  int option1X, option1Y;
  
  // Stores the x and y values for the second button
  int option2X, option2Y;
  // Stores the width of a button
  int buttonSizeWidth = 390;
  
  // Stores the height of the button
  int buttonSizeHeight = 60;
  
  // Stores a boolean that determines whether the user's mouse is over the buttons
  boolean overOptionOne, overOptionTwo;
  
  // The background image of the screen
  PImage bg;
  
  // The font used for the buttons
  PFont buttonFont;
  
  // The images used for the buttons
  PImage regular, hover;
  
  // Booleans used to determine whether buttons should be shown or not
  boolean selectionMade, connectionMade, host, user;
  
  // The default contructor takes in the current sketch as a variable
  // Used to create Host or User classes which requrie the current sketch
  // to function correctly.
  lobby(PApplet sketch) {
    
    // Assign the sketch to the battle_tanks variable
    battle_tanks = sketch;
    
    // Set the X and Y positions of both buttons.
    option1X = option2X = width/2 - buttonSizeWidth/2;
    option1Y = height/2 - 50;
    option2Y = option1Y + 3*buttonSizeHeight/2;
    
    // Loads the background image into the bg variable
    bg = loadImage("assets/screens/TitleScreen2.png");
    
    // Loads the font used into the buttonFont variable
    buttonFont = loadFont("data/Impact-20.vlw");
    
    // Loads the buttons images into their respective variables
    regular = loadImage("assets/buttons/regular.png");
    hover = loadImage("assets/buttons/onhover.png");
    
    // Sets all booleans to be false
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
        
        // If the mouse is pressed change the screen variable to select the map
        // Create a new host and networkGame
        // Set the selectionMade variable to true
        Host = new host(battle_tanks);
        host = true;
        nwgs = new networkGame(true);
        selectionMade = true;
        screen = 2;
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
    text("HOST A GAME", option1X + buttonSizeWidth/2, option1Y + buttonSizeHeight/1.5);
  }
  void optionTwo() {
    // Button number two
    if (overOptionTwo) {
      // If the mouse is over option two
      // Change the button to the hover image
      image(hover,option2X, option2Y);
      fill(255);
      if (mousePressed) {
        
        // If the mouse is pressed create a new user and networkGame
        // Set the selectionMade variable to true
        User = new user(battle_tanks);
        nwgs = new networkGame(false);
        selectionMade = true;
        user = true;
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
    text("FIND A GAME", option2X + buttonSizeWidth/2, option2Y + buttonSizeHeight/1.5);
  }
  
  void draw() {
    // Display the background image
    background(bg);
    // Update the buttons to determine if they need to be changed to their hovered version
    update();
    
    // If no selection has been made, dispaly the first two buttons
    if(!selectionMade) {
      
      optionOne();
      optionTwo();
    } else if (selectionMade && !connectionMade && host) {
      
      // If a selection was made, and no connection has been made, and they are hosting
      // Display the third label (not a button)
      optionThree();
    } else if (selectionMade && connectionMade && user) {
      
      // If a selection was made, and a connection has been made, and they are connectiing to the host
      // Display the fourth label (not a button)
      optionFour();
    } else if (selectionMade && connectionMade && host) {
      
      // If a selection was made, and a connection has been made, and they are hosting
      // Display the fifth label (not a button)
      optionFive();
    }   
  }
  
  void optionThree() {
    
    // Display option three
    image(regular, option1X, option1Y);
    fill(0);
    textFont(buttonFont);
    // Set the size of the text
    textSize(25);
    // Set the text to align to the centre of it's bounding box
    textAlign(CENTER);
    // Display the text in the middle of the button
    text("SEARCHING FOR CLIENT...", option1X + buttonSizeWidth/2, option1Y + buttonSizeHeight/1.5);
  }
  
  void optionFour() {
    
    // Display option four
    image(regular, option1X, option1Y);
    fill(0);
    textFont(buttonFont);
    // Set the size of the text
    textSize(25);
    // Set the text to align to the centre of it's bounding box
    textAlign(CENTER);
    // Display the text in the middle of the button
    text("CONNECTED TO SERVER!", option1X + buttonSizeWidth/2, option1Y + buttonSizeHeight/1.5);
    
    // Once the user has connected they need to read the data from the server
    // The data tells the client that the host is ready and what map they are playing on
    // It then changes the screen to the network game
    String message[] = new String[2];
    message = User.data.split(",");
    nwgs.selectMap(int(message[1]));
    delay(1000);
    screen = 4;
    
    //Once the network game starts, stop the menu music, and start the game music.
    if (soundOn) {
      menuPlayer.pause();
      gamePlayer.rewind();
      gamePlayer.loop();
    }
    
  }
  
  void optionFive() {
    image(regular, option1X, option1Y);
    fill(0);
    textFont(buttonFont);
    // Set the size of the text
    textSize(25);
    // Set the text to align to the centre of it's bounding box
    textAlign(CENTER);
    // Display the text in the middle of the button
    text("CLIENT CONNECTED", option1X + buttonSizeWidth/2, option1Y + buttonSizeHeight/1.5);
    
    // Once the host has connected they need to send data to the client
    // The data tells the client that the host is ready and what map they are playing on
    // It then changes the screen to the network game
    Host.server.write("Ready," + nwgs.selectedMap+",\n");
    delay(1000);
    screen = 4;
    
    //Once the network game starts, stop the menu music, and start the game music.
    if (soundOn) {
      menuPlayer.pause();
      gamePlayer.rewind();
      gamePlayer.loop();
    }
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
