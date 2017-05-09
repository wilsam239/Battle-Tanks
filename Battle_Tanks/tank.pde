/*
      Function:
        TankState Interface
      Author:
        Ben, based on in-class lecture code.
      Description:
        This interface is used as a basis for the various classes that define
        what action the tank is currently undertanking.
*/

interface TankState {
  
  void draw(tank t);
  
  void onComplete(tank t);
  
  boolean isFinished();
  
}

/*
      Function:
        TankStill class
      Author:
        Ben, based on in-class lecture code. draw() by Sam.
      Description:
        This class defines what the tank is doing while not moving or turning,
        just staying still.
*/

class TankStill implements TankState {
  
  void draw(tank t) {
    // Push the current coordinate system to the stack
    pushMatrix();
    // Translate to the centre of the shape
    translate(t.x-t.tWidth/2,t.y-t.tHeight/2);
    // Rotate the current system around the new origin by the rotation amount of the tank
    rotate(radians(t.rotation));
    // Set a white stroke
    stroke(255);
    // Render the tankSprite to the center of the screen
    image(t.tankSprite, -t.tWidth/2, -t.tHeight/2);
    // Render the healthbar of the tank
    fill(0);
    rect(-t.tWidth, -t.tHeight, 2*t.tWidth,10);
    fill(255,0,0);
    t.healthPercentage = (2*t.tWidth/100.0) * t.health;
    rect(-t.tWidth, -t.tHeight, int(t.healthPercentage), 10);
    // Restore the previous coordinate system
    popMatrix();
  }
  
  void onComplete(tank t) {
    // Do nothing, the tank is still.
  }
  
  boolean isFinished() {
    return true;
  }
}

/*
      Function:
        TankMoving class
      Author:
        Ben, based on in-class lecture code. draw() edited from Sam's code.
      Description:
        This class is used to define the tank's behaviour when moving from one tile
        to the next. The direction variable defines which direction the tank is moving;
        N = North (up), E = East (right), S = South (down), W = West (left).
*/

class TankMoving implements TankState {
  long duration = 100;
  long whenBegan;
  char direction;
  
  TankMoving (char dir) {
    whenBegan = millis();
    direction = dir;
  }
  
  void draw(tank t) {
    long elapsed = millis() - whenBegan;
    float frac = elapsed / 100.0;
    
    int offsetX, offsetY;
    switch(direction) {
      case 'N':
        offsetX = 0;
        offsetY = -(int)(frac * Tile.spriteHeight);
        break;
      case 'E':
        offsetX = (int)(frac * Tile.spriteHeight);
        offsetY = 0;
        break;
      case 'S':
        offsetX = 0;
        offsetY = (int)(frac * Tile.spriteHeight);
        break;
      case 'W':
        offsetX = -(int)(frac * Tile.spriteHeight);
        offsetY = 0;
        break;
      default:
        throw new IllegalStateException("The tank has somehow tried to move in an illegal direction");
    }
    
    // Push the current coordinate system to the stack
    pushMatrix();
    // Translate to the centre of the shape
    translate(t.x-t.tWidth/2 + offsetX,t.y-t.tHeight/2 + offsetY);
    // Rotate the current system around the new origin by the rotation amount of the tank
    rotate(radians(t.rotation));
    // Set a white stroke
    stroke(255);
    // Render the tankSprite to the center of the screen
    image(t.tankSprite, -t.tWidth/2, -t.tHeight/2);
    // Render the healthbar of the tank
    fill(0);
    rect(-t.tWidth, -t.tHeight, 2*t.tWidth,10);
    fill(255,0,0);
    t.healthPercentage = (2*t.tWidth/100.0) * t.health;
    rect(-t.tWidth, -t.tHeight, int(t.healthPercentage), 10);
    // Restore the previous coordinate system
    popMatrix();
  }
  
  void onComplete(tank t) {
    // Update the tank's x and y location
    switch(direction) {
      case 'N':
        t.oY -= 1;
        t.y -= Tile.spriteHeight;
        break;
      case 'E':
        t.oX += 1;
        t.x += Tile.spriteHeight;
        break;
      case 'S':
        t.oY += 1;
        t.y += Tile.spriteHeight;
        break;
      case 'W':
        t.oX -= 1;
        t.x -= Tile.spriteHeight;
        break;
      default:
        throw new IllegalStateException("The tank has somehow tried to move in an illegal direction");
    }
  }
  
  boolean isFinished() {
    return millis() - whenBegan > duration;
  }
}

/*
      Function:
        TankTurning class
      Author:
        Ben, based on in-class lecture code. draw() and onComplete() edited from Sam's code.
      Description:
        This class is used to define the tank's behaviour while turning.
        The direction variable defines which way the tank is turning;
        L = Left (counter-clockwise), R = Right (clockwise).
*/

class TankTurning implements TankState {
  long duration = 100;
  long whenBegan;
  char direction;
  
  TankTurning (char dir) {
    whenBegan = millis();
    direction = dir;
  }
  
  void draw(tank t) {
    long elapsed = millis() - whenBegan;
    float frac = elapsed / 100.0;
    
    int offset;
    switch(direction) {
      case 'L':
        offset = -(int)(frac * 90);
        break;
      case 'R':
        offset = (int)(frac * 90);
        break;
      default:
        throw new IllegalStateException("The tank has somehow tried to move in an illegal direction");
    }
    
    // Push the current coordinate system to the stack
    pushMatrix();
    // Translate to the centre of the shape
    translate(t.x-t.tWidth/2,t.y-t.tHeight/2);
    // Rotate the current system around the new origin by the rotation amount of the tank
    rotate(radians(t.rotation + offset));
    // Set a white stroke
    stroke(255);
    // Render the tankSprite to the center of the screen
    image(t.tankSprite, -t.tWidth/2, -t.tHeight/2);
    // Render the healthbar of the tank
    fill(0);
    rect(-t.tWidth, -t.tHeight, 2*t.tWidth,10);
    fill(255,0,0);
    t.healthPercentage = (2*t.tWidth/100.0) * t.health;
    rect(-t.tWidth, -t.tHeight, int(t.healthPercentage), 10);
    // Restore the previous coordinate system
    popMatrix();
  }
  
  void onComplete(tank t) {
    // Update the tank's x and y location
    switch(direction) {
      case 'L':
        // If the player needs to rotate anti-clockwise
        // Subtract 90 from the rotation variable, unless it equals 90 or 0
        // If the rotation variable = 90, set it to 0, because we have come full circle
        // If the rotation variable = 0, set it to 270, because we are going in the
        // reverse direction now
        if (t.rotation == 90) t.rotation = 0;
        else if (t.rotation == 0) t.rotation = 270;
        else t.rotation -= 90;
        break;
      case 'R':
        // If the player needs to rotate clockwise
        // Add 90 to the rotation variable, unless it equals 270
        // If the rotation variable = 270, set it to 0, because we have come full circle
        if (t.rotation == 270) t.rotation = 0;
        else t.rotation += 90;
        break;
      default:
        throw new IllegalStateException("The tank has somehow tried to turn neither left nor right");
    }
  }
  
  boolean isFinished() {
    return millis() - whenBegan > duration;
  }
}

/*
      Function:
        tank class
      Author:
        Sam, checkMovement() by Ben
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
  //  Stores the height and width of the tank
  int tHeight = 30;
  int tWidth = 30;
  float healthPercentage;
  PImage tankSprite;
  int numberOfTank;
  boolean firestate;
  // Stores what the tank is currently doing
  TankState state;
  
  // The default contructor
  tank(int playerNumber) {
    // Set the health of the tank to be 100
    health = 100;
    numberOfTank = playerNumber;
    state = new TankStill();
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
    
    if (state instanceof TankStill) {
      /* if(keyPressed) keyWasPressed(key, game); */
      checkMovement(game);
    } else if (state instanceof TankMoving && state.isFinished()) {
      state.onComplete(this);
      state = new TankStill();
    } else if (state instanceof TankTurning && state.isFinished()) {
      state.onComplete(this);
      state = new TankStill();
    }
    
    state.draw(this);
    
    /*
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
    // Render the healthbar of the tank
    fill(0);
    rect(-tWidth, -tHeight, 2*tWidth,10);
    fill(255,0,0);
    healthPercentage = (2*tWidth/100.0) * health;
    rect(-tWidth, -tHeight, int(healthPercentage), 10);
    // Restore the previous coordinate system
    popMatrix();
    */
  }
  
  void checkMovement(localGame game) {
    // Checks if a key is currently being pressed, and calls the updatePos
    // function based on the keys that are held down and the player number
    if (numberOfTank == 1) {
      if (keys[0]) updatePos("Forward", game);
      if (keys[1]) updatePos("Left", game);
      if (keys[2]) updatePos("Backward", game);
      if (keys[3]) updatePos("Right", game);
      if (keys[4]) firestate = true;
    } else if (numberOfTank == 2) {
       if (keys[5]) updatePos("Forward", game);
      if (keys[6]) updatePos("Left", game);
      if (keys[7]) updatePos("Backward", game);
      if (keys[8]) updatePos("Right", game);
      if (keys[9]) firestate = true;
    }
  }
  
/*  void keyWasPressed(char key, localGame game) {
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
          updatePos("Left", game);
          break;
        case 'S':
        case 's':
          updatePos("Backward", game);
          break;
        case 'D':
        case 'd':
          updatePos("Right", game);
          break;
        case 'f':
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
          updatePos("Left", game);
          break;
        case 'K':
        case 'k':
          updatePos("Backward", game);
          break;
        case 'L':
        case 'l':
          updatePos("Right", game);
          break;
        /*case ';':
        case ':':
          delay(100);
        *
      }
    }
  }*/
  
  void updatePos(String dir, localGame game) {
    // Stores the next tiles based on the direction of the player
    int nextTileX;
    int nextTileY;
    
    // If the direction the player wants to move is right, rotate the tank clockwise
    if (dir == "Right") state = new TankTurning('R'); //rotateTank(true);
    // If the direction the player wants to move is left, rotate the tank anti-clockwise 
    else if (dir == "Left") state = new TankTurning('L'); //rotateTank(false);
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
            if (directionValue > 0) state = new TankMoving('E');
            else state = new TankMoving('W');
            /*x += Tile.spriteHeight * directionValue;
            oX += directionValue;*/
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
            if (directionValue > 0) state = new TankMoving('S');
            else state = new TankMoving('N');
            /*y += Tile.spriteHeight * directionValue;
            oY += directionValue;*/
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
            if (directionValue > 0) state = new TankMoving('W');
            else state = new TankMoving('E');
            /*x -= Tile.spriteHeight * directionValue;;
            oX -= directionValue;*/
          }
          break;
        // If the player is facing Up
        case 0:
          nextTileX = oX;
          nextTileY = oY - directionValue;
          if (game.isPassable(nextTileX, nextTileY) && game.tankNotPresent(nextTileX, nextTileY, numberOfTank)) {
            if (directionValue > 0) state = new TankMoving('N');
            else state = new TankMoving('S');
            /*y -= Tile.spriteHeight * directionValue;
            oY -= directionValue;*/
          }
          break;
        // If none of the directions above are the direction, throw an error
        default:
          throw new IllegalStateException("Somehow we have a direction that is not Left, Right, Up or Down");
      }
    }
  }
  
  /* void rotateTank(boolean clockwise) {
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
  */
}

/*class bullet{
  int lRect = 3;
  int wRect = 4;
  int x, oX, y, oY;
  // default Constructor
  bullet(int player){
    if (player == 1){
      x = tank.x;
      oX = x+3;
    } else if (player == 2){
      x = player2.x
    }
    
  }
  
  void updatePos(String dir){
 
  }
}*/
