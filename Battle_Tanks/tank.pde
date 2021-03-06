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
  
  int[] movingTo(tank t);
  
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
  
  int[] movingTo(tank t) {
    int[] nextLoc = new int[2];
    nextLoc[0] = t.oX;
    nextLoc[1] = t.oY;
    return nextLoc;
  }
  
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
  long duration = 250;
  long whenBegan;
  char direction;
  // Tracks the space on the grid that the tank is moving to.
  
  TankMoving (char dir) {
    whenBegan = millis();
    direction = dir;
  }
  
  int[] movingTo(tank t) {
    int[] nextLoc = new int[2];
    switch(direction) {
      case 'N':
        nextLoc[0] = t.oX;
        nextLoc[1] = t.oY - 1;
        break;
      case 'E':
        nextLoc[0] = t.oX + 1;
        nextLoc[1] = t.oY;
        break;
      case 'S':
        nextLoc[0] = t.oX;
        nextLoc[1] = t.oY + 1;
        break;
      case 'W':
        nextLoc[0] = t.oX - 1;
        nextLoc[1] = t.oY;
        break;
      default:
        throw new IllegalStateException("The tank has somehow tried to move in an illegal direction");
    }
    return nextLoc;
  }
  
  void draw(tank t) {
    long elapsed = millis() - whenBegan;
    float frac = elapsed / 250.0;
    
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
  long duration = 250;
  long whenBegan;
  char direction;
  
  TankTurning (char dir) {
    whenBegan = millis();
    direction = dir;
  }
  
  int[] movingTo(tank t) {
    int[] nextLoc = new int[2];
    nextLoc[0] = t.oX;
    nextLoc[1] = t.oY;
    return nextLoc;
  }
  
  void draw(tank t) {
    long elapsed = millis() - whenBegan;
    float frac = elapsed / 250.0;
    
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
  int score;
  //  Stores the height and width of the tank
  int tHeight = 30;
  int tWidth = 30;
  float healthPercentage;
  PImage tankSprite;
  int numberOfTank;
  boolean firestate;
  //bullet b = null;
  // Stores what the tank is currently doing
  TankState state;
  
  // The default contructors
  tank(int xPos, int yPos, int rotationAmount) {
    score = 0;
    health = 100;
    numberOfTank = 1;
    state = new TankStill();
    x = xPos;
    y = yPos;
    rotation = rotationAmount;
    tankSprite = loadImage("assets/tanks/tank1.png");
    // Set the oX position to be the x position divided by the height of the tile
    oX = x/Tile.spriteHeight - 1;
    // Set the oY position of the y position divided by the height of the tile
    oY = y/Tile.spriteHeight - 1;
  }
  
  tank(int playerNumber) {
    // Set the health of the tank to be 100
    health = 100;
    score = 0;
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
  }
  
  void checkMovement(localGame game) {
    // Checks if a key is currently being pressed, and calls the updatePos
    // function based on the keys that are held down and the player number
    if (numberOfTank == 1) {
      if (game.keys[0]) updatePos("Forward", game);
      if (game.keys[1]) updatePos("Left", game);
      if (game.keys[2]) updatePos("Backward", game);
      if (game.keys[3]) updatePos("Right", game);
      if (game.keys[4]) if (game.bPlayer1 == null || game.bPlayer1.alive == false) { 
        game.bPlayer1 = new bullet(this);
        if (soundOn) {
          firePlayer.rewind();
          firePlayer.play();
        }
      }
    } else if (numberOfTank == 2) {
      if (game.keys[5]) updatePos("Forward", game);
      if (game.keys[6]) updatePos("Left", game);
      if (game.keys[7]) updatePos("Backward", game);
      if (game.keys[8]) updatePos("Right", game);
      if (game.keys[9]) if (game.bPlayer2 == null || game.bPlayer2.alive == false) {
        game.bPlayer2 = new bullet(this);
        if (soundOn) {
          firePlayer.rewind();
          firePlayer.play();
        }
      }
    }
  }
  
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
            if (directionValue > 0 && game.tankNotMoving(numberOfTank, oX + 1, oY)) {
              state = new TankMoving('E');
            }
            else if (directionValue < 0 && game.tankNotMoving(numberOfTank, oX - 1, oY)) {
              state = new TankMoving('W');
            }
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
            if (directionValue > 0 && game.tankNotMoving(numberOfTank, oX, oY + 1)) {
              state = new TankMoving('S');
            } else if (directionValue < 0 && game.tankNotMoving(numberOfTank, oX, oY - 1)) {
              state = new TankMoving('N');
            }
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
            if (directionValue > 0 && game.tankNotMoving(numberOfTank, oX - 1, oY)) {
              state = new TankMoving('W');
            } else if (directionValue < 0 && game.tankNotMoving(numberOfTank, oX + 1, oY)) {
              state = new TankMoving('E');
            }
            /*x -= Tile.spriteHeight * directionValue;;
            oX -= directionValue;*/
          }
          break;
        // If the player is facing Up
        case 0:
          nextTileX = oX;
          nextTileY = oY - directionValue;
          if (game.isPassable(nextTileX, nextTileY) && game.tankNotPresent(nextTileX, nextTileY, numberOfTank)) {
            if (directionValue > 0 && game.tankNotMoving(numberOfTank, oX, oY - 1)) {
              state = new TankMoving('N');
            } else if (directionValue < 0 && game.tankNotMoving(numberOfTank, oX, oY + 1)) {
              state = new TankMoving('S');
            }
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
  
  int getScore() {
    return score;
  }
  /* The network methods of the tank class */
  void draw(networkGame game) {
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
  }
  
  void checkMovement(networkGame game) {
    // Checks if a key is currently being pressed, and calls the updatePos
    // function based on the keys that are held down and the player number
    if (game.keys[0]) updatePos("Forward", game);
    if (game.keys[1]) updatePos("Left", game);
    if (game.keys[2]) updatePos("Backward", game);
    if (game.keys[3]) updatePos("Right", game);
    if (game.keys[4]) if (game.bulPlayer == null || game.bulPlayer.alive == false) game.bulPlayer = new bullet(this);
  }
  
  void updatePos(String dir, networkGame game) {
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
          if (game.isPassable(nextTileX, nextTileY) && game.tankNotPresent(nextTileX, nextTileY)) {
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
          if (game.isPassable(nextTileX, nextTileY) && game.tankNotPresent(nextTileX, nextTileY)) {
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
          if (game.isPassable(nextTileX, nextTileY) && game.tankNotPresent(nextTileX, nextTileY)) {
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
          if (game.isPassable(nextTileX, nextTileY) && game.tankNotPresent(nextTileX, nextTileY)) {
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
  
}

class bullet{
  int bL;
  int bW;
  int playerNumber = 0;
  int bincrementer = 0;
  Boolean bPlayer1 = false;
  Boolean bPlayer2 = false;
  boolean alive = true;
  int bX, boX, bY, boY, bRotation;
  // default Constructor
  bullet(tank player){
    if (player.numberOfTank == 1 && bPlayer1 == false){
      bRotation = player.rotation;
      playerNumber = 1;
      if (bRotation == 180 || bRotation == -180){
        bX = player.x - 17;
        boX = player.oX;
        bY = player.y - 1;
        boY = player.oY;
        bW = 5;
        bL = 3;
      } else if (bRotation == 0){
        bX = player.x -17;
        boX = player.oX;
        bY = player.y -36;
        boY = player.oY;
        bW = 5;
        bL = 3;
      } else if (bRotation == 90 || bRotation == -90){
        bX = player.x + 1;
        boX = player.oX;
        bY = player.y - 17;
        boY = player.oY;
        bW =3;
        bL = 5;
      } else if (bRotation == 270 || bRotation == -270){
        bX = player.x - 36;
        boX = player.oX;
        bY = player.y - 17;
        boY = player.oY;
        bW =3;
        bL = 5;
      } else {
        throw new IllegalStateException("Somehow we have a direction that is not Left, Right, Up or Down");
      }
      bPlayer1 = true;
    } else if (player.numberOfTank == 2 && bPlayer2 == false){
       bRotation = player.rotation;
       playerNumber = 2;
      if (bRotation == 180 || bRotation == -180){
        bX = player.x - 17;
        boX = player.oX;
        bY = player.y - 1;
        boY = player.oY;
        bW = 5;
        bL = 3;
      } else if (bRotation == 0){
        bX = player.x -17;
        boX = player.oX;
        bY = player.y -36;
        boY = player.oY;
        bW = 5;
        bL = 3;
      } else if (bRotation == 90 || bRotation == -90){
        bX = player.x + 1;
        boX = player.oX;
        bY = player.y - 17;
        boY = player.oY;
        bW =3;
        bL = 5;
      } else if (bRotation == 270 || bRotation == -270){
        bX = player.x - 36;
        boX = player.oX;
        bY = player.y - 17;
        boY = player.oY;
        bW =3;
        bL = 5;
      } else {
        throw new IllegalStateException("Somehow we have a direction that is not Left, Right, Up or Down");
      }
      bPlayer2 = true;
    }    
  }
  //update function that takes in the bullet and the local game
  void updatePos(bullet bullet, localGame game){
    int dirVal = 0;
    int nextTileX;
    int nextTileY;
    int nextTileInt = 0;
    // if the rotation = 270, -270 or 0 the bullet is travelling in a negative direction
    if (bullet.bRotation == 270 || bullet.bRotation == -270 || bullet.bRotation == 0){
      dirVal = -10; // set dirVal to be -10 as the bullet is travelling up or left
      if(bullet.bincrementer == 2){ // if the incrementer = 2 then next tile int is set
      nextTileInt = -1; // next tile int is set to -1
      bullet.bincrementer = 0; // reset bullet incrementer
      } else {
        bullet.bincrementer = bullet.bincrementer + 1; // increase bullet incrementer
      } // if the rotation = 90 or 180 then the bullet is travelling in a positive direction
    } else if (bullet.bRotation == 90 ||bullet.bRotation == -90 || bullet.bRotation == 180 || bullet.bRotation == -180){
      dirVal = 10; // set dir val to be positive 10
      if (bullet.bincrementer == 2){ // if increnter is 2 then next tile int is set
        nextTileInt = 1; //next tile int = 0
        bullet.bincrementer = 0; // incrementer is reset
      } else {
        bullet.bincrementer = bullet.bincrementer + 1; // add to incrementer
      }
    } // if bullet is travelling along the x axis then next tileX = bullet.boX + nextTileInt
    if (bullet.bRotation == 90 || bullet.bRotation == -90 || bullet.bRotation == 270 || bullet.bRotation == -270){
      nextTileX = bullet.boX + nextTileInt; // add nextTileInt to bullet boX
      nextTileY = bullet.boY; // bullet boY is the same
      //check to see what the next tile is
      if (game.isPassable(nextTileX, nextTileY) && game.tankNotPresent(nextTileX, nextTileY, bullet.playerNumber)){
        bullet.boX = nextTileX; // if the tile was passable and no tank was present then the bullet boX is set to nextTileX
        bullet.bX = bullet.bX + dirVal; //the bullets X position is icreased or decreased depending on dirVal
        // if the game finds a tank object
      } else if (game.tankNotPresent(nextTileX, nextTileY, bullet.playerNumber) == false) {
        if (bullet.playerNumber == 1){ // if bullet from player 1 hits
          game.player2.health = game.player2.health - 20; //decrease player 2 health by 20
        } else if (bullet.playerNumber == 2){ // if bullet from player 2 hits
          game.player1.health = game.player1.health - 20; //decrease player 1 health by 2
        }
        bullet.alive = false; // if the bullet hits an object then set the bullet alive state to false.
        if (soundOn) { // check if sound is on
          boomPlayer.rewind(); // rewind boom sound as to make sure it can play
          boomPlayer.play(); // play the boom sound as bullet has exploded
        }
      } else {
        bullet.alive = false; // if bullet cannot pass and has hit a wall then set bullet alive to false
        if (soundOn) { // check if sound is on
          boomPlayer.rewind(); // rewind boom sound to make sure it plays
          boomPlayer.play(); // play the boom sound as bullet has exploded
        }
    } // if the bullet is travelling along the y axis
    } else if (bullet.bRotation == 0 || bullet.bRotation == 180 || bullet.bRotation == -180){
      nextTileY = bullet.boY + nextTileInt; // add nextileInt to bullets boY
      nextTileX = bullet.boX; // bullet boX stays the same
      if (game.isPassable(nextTileX, nextTileY) && game.tankNotPresent(nextTileX, nextTileY, bullet.playerNumber)){
        bullet.boY = nextTileY; // bullet boY = nextTileY
        bullet.bY = bullet.bY + dirVal; // add dirVal to bullets y position
        // check if bullet hits a tank
      } else if (game.tankNotPresent(nextTileX, nextTileY, bullet.playerNumber) == false) {
        if (bullet.playerNumber == 1){ // if bullet is from player 1
          game.player2.health = game.player2.health - 20; // decrease player 2 health by 20
        } else if (bullet.playerNumber == 2){ // if bullet is from player 2
          game.player1.health = game.player1.health - 20; // decrease player 1 health by 20
        }
        bullet.alive = false; // set bullet to false
        if (soundOn) { // check if sound is on
          boomPlayer.rewind(); // rewind the boom sound
          boomPlayer.play(); // play boom sound as it has exploded
        }
      } else {
        bullet.alive = false; // if bullet cannot pass and has hit a wall then set bullet alive to false
        if (soundOn) { // if sound is on
          boomPlayer.rewind(); // rewind boom sound
          boomPlayer.play(); // play boom sound
        }
    }
  }
  }
  //draw function of rectangle for bullet
  void draw(localGame game){
    rect(bX, bY, bL, bW);
  }
  
  void draw(networkGame game){
    rect(bX, bY, bL, bW);
  }
}