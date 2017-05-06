/*
      Function:
        tank class
      Author:
        Sam
      Description:
        This class stores all of the information related to the tanks.
        Including the x,y position, the height and width of the tank,
        and the rotation of the tank.
        
        This class also updates the position of the tank, rotates it
        and delays the input after rotation ever so slightly, and 
        updates it's health.
*/

class tank {
  // Stores the x,y coords and the health of the tank, aswell as the
  // rotation, and x,y coords in relation to the map array
  int x, y, health, rotation, oX, oY;
  float healthPercentage;
  //  Stores the height and width of the tank
  int tHeight = 30;
  int tWidth = 30;
  PImage tankSprite;
  int numberOfTank;
  
  // The default contructor
  tank(int playerNumber) {
    // Set the health of the tank to be 100
    health = 100;
    numberOfTank = playerNumber;
    if (playerNumber == 1) { 
      // Set the x position
      x = 2*Tile.spriteHeight;
      // Set the oX position to be the x position divided by the height of the tile
      oX = x/Tile.spriteHeight - 1;
      // Set the y position
      y = 2*Tile.spriteHeight;
      // Set the oY position of the y position divided by the height of the tile
      oY = y/Tile.spriteHeight - 1;
      // Set the initial rotation to be 90º (Facing right)
      rotation = 180;
      tankSprite = loadImage("assets/tanks/tank1.png");
    } else if (playerNumber == 2) {
      // Set the x position
      x = width - Tile.spriteHeight;
      // Set the oX position to be the x position divided by the height of the tile
      oX = x/Tile.spriteHeight - 1;
      // Set the y position
      y = height-Tile.spriteHeight;
      // Set the oY position of the y position divided by the height of the tile
      oY = y/Tile.spriteHeight - 1;
      // Set the initial rotation to be 270º (Facing left)
      rotation = 0;
      // Set the health of the tank to be 100
      tankSprite = loadImage("assets/tanks/tank2.png");
    }
  }
  
  void draw(localGame game) {
    // The draw function, which recevies the gameState as passed in by the gameState class
    // If a key had been pressed call the keyWasPressed function and pass the key and
    // gameState in
    if(keyPressed) keyWasPressed(key, game);
    // Push the current coordinate system to the stack
    pushMatrix();
    // Translate to the centre of the shape
    translate(x-tWidth/2,y-tHeight/2);
    // Rotate the current system around the new origin by the rotation amount of the tank
    rotate(radians(rotation));
    // Set a white stroke
    stroke(255);
    // Render the tankSprite to the center of the screen
    image(tankSprite, -tWidth/2, -tHeight/2);
    fill(0);
    rect(-tWidth, -tHeight, 2*tWidth,10);
    fill(255,0,0);
    healthPercentage = (2*tWidth/100.0) * health;
    rect(-tWidth, -tHeight, int(healthPercentage), 10);
    // Restore the previous coordinate system
    popMatrix();
    // Delay the game by 50 milliseconds
    delay(50);
    // If the key that was pressed was A or D (rotation keys)
    // Delay the game by another 50 milliseconds
    if(keyPressed) {
      if (key == 'A' || key == 'a' || key == 'D' || key == 'd') {
        delay(50);
      }
     }     
  }
  
  void keyWasPressed(char key, localGame game) {
    // Called when a key was pressed
    // Switch statement that calls the updatePos function based on the input
    // and the player number
    if (numberOfTank == 1) {
      switch(key) {
        case 'W':
        case 'w':
          updatePos("Forward", game);
          break;
        case 'A':
        case 'a':
          delay(100);
          updatePos("Left", game);
          break;
        case 'S':
        case 's':
          updatePos("Backward", game);
          break;
        case 'D':
        case 'd':
          delay(100);
          updatePos("Right", game);
          break;
        case 'f':
          delay(100);
          firestate = true;
      }
    } else if (numberOfTank == 2) {
      switch(key) {
        case 'I':
        case 'i':
          updatePos("Forward", game);
          break;
        case 'J':
        case 'j':
          delay(100);
          updatePos("Left", game);
          break;
        case 'K':
        case 'k':
          updatePos("Backward", game);
          break;
        case 'L':
        case 'l':
          delay(100);
          updatePos("Right", game);
          break;
        /*case ';':
        case ':':
          delay(100);
        */
      }
    }
  }
  
  void updatePos(String dir, localGame game) {
    // Stores the next tiles based on the direction of the player
    int nextTileX;
    int nextTileY;
    
    // If the direction the player wants to move is right, rotate the tank clockwise
    if (dir == "Right") rotateTank(true);
    // If the direction the player wants to move is left, rotate the tank anti-clockwise 
    else if (dir == "Left") rotateTank(false);
    // If the direction the player wants to go is forward
    else if (dir == "Forward" || dir == "Backward") {
      // Switch statement that moves the player depending on their rotation
      int directionValue;
      if (dir == "Forward") directionValue = 1;
      else directionValue = -1;
      switch(rotation) {
        // If the player is facing Right
        case 90:
        case -90:
          // Set the next tile variables
          nextTileX = oX + directionValue;
          nextTileY = oY;
          // If the next tile is passable, move the player right
          if (game.isPassable(nextTileX, nextTileY) && game.tankNotPresent(nextTileX, nextTileY, numberOfTank)) {
            x += Tile.spriteHeight * directionValue;
            oX += directionValue;
          }
          break;
        // If the player is facing Down
        case 180:
        case -180:
          // Set the next tile variables
          nextTileX = oX;
          nextTileY = oY + directionValue;
          // If the next tile is passable, move the player down
          if (game.isPassable(nextTileX, nextTileY) && game.tankNotPresent(nextTileX, nextTileY, numberOfTank)) {
            y += Tile.spriteHeight * directionValue;
            oY += directionValue;
          }
          break;
        // If the player is facing Left
        case 270:
        case -270:
          // Set the next tile variables
          nextTileX = oX - directionValue;
          nextTileY = oY;
          // If the next tile is passable, move the player left
          if (game.isPassable(nextTileX, nextTileY) && game.tankNotPresent(nextTileX, nextTileY, numberOfTank)) {
            x -= Tile.spriteHeight * directionValue;;
            oX -= directionValue;
          }
          break;
        // If the player is facing Up
        case 0:
          nextTileX = oX;
          nextTileY = oY - directionValue;
          if (game.isPassable(nextTileX, nextTileY) && game.tankNotPresent(nextTileX, nextTileY, numberOfTank)) {
            y -= Tile.spriteHeight * directionValue;
            oY -= directionValue;
          }
          break;
        // If none of the directions above are the direction, throw an error
        default:
          throw new IllegalStateException("Somehow we have a direction that is not Left, Right, Up or Down");
      }
    }
  }
  
  void rotateTank(boolean clockwise) {
    // Rotate the tank either clockwise or anti-clockwise
    if (clockwise) {
      // If the player needs to rotate clockwise
      // Add 90 to the rotation variable, unless it equals 270
      // If the rotation variable = 270, set it to 0, because we have come full circle
      if (rotation == 270) rotation = 0;
      else rotation += 90;      
    } else {
      // If the player needs to rotate anti-clockwise
      // Subtract 90 from the rotation variable, unless it equals 90 or 0
      // If the rotation variable = 90, set it to 0, because we have come full circle
      // If the rotation variable = 0, set it to 270, because we are going in the
      // reverse direction now
      if (rotation == 90) rotation = 0;
      else if (rotation == 0) rotation = 270;
      else rotation -= 90;
    }
  }
}

class bullet{
  int lRect = 3;
  int wRect = 4;
}