/* 
      Function:
        header class
      Author:
        Sam.
      Description:
        Displays the in game header that shows the score and quit button
*/

class header {
 
  // Standard variables for display classes
  PImage onhover, regular;
  int buttonWidth = 60;
  int buttonHeight = 30;
  boolean overButton;
  PFont buttonFont;
  int xPos, yPos;
  
  header() {
    // default constructor loads images and sets coords
    onhover = loadImage("assets/buttons/s-onhover.png");
    regular = loadImage("assets/buttons/s-regular.png");
    buttonFont = loadFont("data/Impact-20.vlw");
    xPos = width/2 - buttonWidth/2;
    yPos = 0;
  }
  
  void draw(tank player1, tank player2) {
    // similar to other display classes
    update();
    bg();
    button();
    // display the scores of the players
    scores(player1, player2);
  }
 
  void update() {
    if (mouseOver(xPos, yPos, buttonWidth, buttonHeight)) {
      overButton = true;
    } else overButton = false;
  }
  
  boolean mouseOver(int x, int y, int width, int height) {
    // If the mouse is in between the ends of the button return true
    if (mouseX >= x && mouseX <= x+width && 
        mouseY >= y && mouseY <= y+height) {
      return true;
    } else return false;
  }
    
  void bg() {
    // Create a black semi opaque rectangle
    noStroke();
    fill(0, 0, 0, 90);
    rect(Tile.spriteHeight*11, 0, Tile.spriteHeight*8, Tile.spriteHeight*3);
  }
  
  void button() {
    if (overButton) {
      image(onhover, xPos, yPos);
      fill(255);
      if(mousePressed) {
        screen = 5;
        if (gs.player1.getScore() > gs.player2.getScore()) GameOver = new gameOver(1);
        else if (gs.player2.getScore() > gs.player1.getScore()) GameOver = new gameOver(2);
        else GameOver = new gameOver(3);
        gs = null;
        gamePlayer.pause();
        menuPlayer.rewind();
        menuPlayer.loop();
      }
    } else {
      image(regular, xPos, yPos);
      fill(0);
    }
    textFont(buttonFont);
    // Set the size of the text
    textSize(15);
    // Set the text to align to the centre of it's bounding box
    textAlign(CENTER);
    // Display the text in the middle of the button
    text("QUIT", xPos + buttonWidth/2, yPos + buttonHeight/1.5);
  }
  
  void scores(tank player1, tank player2) {
    
    // Display player and scores
    fill(255);
    float textOnexPos = Tile.spriteHeight*12.5;
    float textTwoxPos = Tile.spriteHeight*17.5;
    String playerOne = "PLAYER 1";
    String playerTwo = "PLAYER 2";
    String player1Score = str(player1.getScore());
    String player2Score = str(player2.getScore());
    stroke(255,0,0);
    text(playerOne, textOnexPos, Tile.spriteHeight);
    text(playerTwo, textTwoxPos, Tile.spriteHeight);
    text(player1Score, textOnexPos, Tile.spriteHeight*2);
    text(player2Score, textTwoxPos, Tile.spriteHeight*2);
  }
}
