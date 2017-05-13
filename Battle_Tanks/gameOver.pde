/* 
      Function:
        gameOver class
      Author:
        Sam.
      Description:
        Displays the game over screen when someone loses. 
        Also displays two buttons that take teh user to the menu
        exit the game.
*/
class gameOver {
  
  // Standard variables across screens now
  // Images, font, x and y positions
  // Height and width etc
  PImage bg, label, medRegular, medHover;
  PFont labelFont;
  int labelX, labelY, buttonX1, buttonY, buttonX2;
  int labelWidth = 390;
  int buttonWidth = 120;
  int buttonHeight = 60;
  int labelHeight = 60;
  int winningPlayer;
  boolean overButton1, overButton2;
  
  gameOver(int winner) {
    // The default contructor takes in the winning player
    winningPlayer = winner;
    // Loads the images into their variables
    bg = loadImage("assets/screens/TitleScreen2.png");
    label = loadImage("assets/buttons/regular.png");
    labelFont = loadFont("data/Impact-20.vlw");
    medRegular = loadImage("assets/buttons/m-regular.png");
    medHover = loadImage("assets/buttons/m-onhover.png");
    
    // Set the x,y position of both the label and buttons
    labelX = width/2 - labelWidth/2;
    labelY = height/2 - 50;
    buttonX1 = labelX - buttonWidth;
    buttonX2 = labelX + labelWidth;
    buttonY = height-80;
    overButton1 = overButton2 = false;
  }
  
  void draw() {
    // Draw the background
    background(bg);
    // Update the mouse position and boolean variables
    update();
    
    // FIll black and siaply winner label
    fill(0);
    image(label, labelX, labelY);
    textFont(labelFont);
    textSize(25);
    String labelText = "null";
    if (winningPlayer > 2) {
      labelText = "IT'S A DRAW!";
    } else {
      labelText = "PLAYER " + str(winningPlayer) + " WON!";  
    }
    
    text(labelText, labelX + labelWidth/2, labelY + labelHeight/1.5);
    // draw the buttons
    buttonOne();
    buttonTwo();
  }
  
  void buttonOne() {
    // Standard button by now
    if (overButton1) {
      image(medHover, buttonX1, buttonY);
      fill(255);
      if(mousePressed) {
        screen = 0;
      }
    } else {
      image(medRegular, buttonX1, buttonY);
      fill(0);
    }
    textFont(labelFont);
    // Set the size of the text
    textSize(25);
    // Set the text to align to the centre of it's bounding box
    textAlign(CENTER);
    // Display the text in the middle of the button
    text("MENU", buttonX1 + buttonWidth/2, buttonY + buttonHeight/1.5);
  }
  
  void buttonTwo() {
    // Another standard button
    if (overButton2) {
      image(medHover, buttonX2, buttonY);
      fill(255);
      if(mousePressed) {
        exit();
      }
    } else {
      image(medRegular, buttonX2, buttonY);
      fill(0);
    }
    textFont(labelFont);
    // Set the size of the text
    textSize(25);
    // Set the text to align to the centre of it's bounding box
    textAlign(CENTER);
    // Display the text in the middle of the button
    text("QUIT", buttonX2 + buttonWidth/2, buttonY + buttonHeight/1.5);
  }
  void update() {
    // Same update function as other classes
    if (mouseOver(buttonX1, buttonY, buttonWidth, buttonHeight)) {
      overButton1 = true;
      overButton2 = false;
    } else if (mouseOver(buttonX2, buttonY, buttonWidth, buttonHeight)) {
      overButton1 = false;
      overButton2 = true;
    } else overButton1 = overButton2 = false;
  }
  
  boolean mouseOver(int x, int y, int width, int height) {
    // same mouseover functiona s other classes
    // If the mouse is in between the ends of the button return true
    if (mouseX >= x && mouseX <= x+width && 
        mouseY >= y && mouseY <= y+height) {
      return true;
    } else return false;
  }
}