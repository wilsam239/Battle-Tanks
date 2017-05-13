/* 
      Function:
        mapSelect class
      Author:
        Sam
      Description:
        This class is used to make the selection as to which map the game
        will be played on.
*/

class mapSelect {
  
  // Store teh locations of each map
  int mapOneX, mapOneY;
  int mapTwoX, mapTwoY;
  int mapThreeX, mapThreeY;
  int mapFourX, mapFourY;
  
  // Store the width and height of the maps
  int mWidth, mHeight;
  // Tracks whether the mosue is over any of the maps
  boolean overMapOne, overMapTwo, overMapThree, overMapFour;
  
  // Stores the map images
  PImage mapOne, mapTwo, mapThree, mapFour, bg;
  
  // The default contructor
  mapSelect() {
    
    // Set all the variables mentiomned above
    mWidth = 300;
    mHeight = 200;
    
    mapOneX = 120;
    mapOneY = mapTwoY = 150;
    mapTwoX = mapOneX + mWidth + 30 ;
    mapThreeX = mapOneX;
    mapThreeY = mapFourY = mapOneY + mHeight + 30;
    mapFourX = mapThreeX + mWidth + 30;
    
    // Load the images
    mapOne = loadImage("assets/maps/map1.png");
    mapTwo = loadImage("assets/maps/map2.png");
    mapThree = loadImage("assets/maps/map3.png");
    mapFour = loadImage("assets/maps/map4.png");
    
    // Load the background image
    bg = loadImage("assets/screens/MapScreen.png");
  }
  
  void draw(localGame game) {
    
    // Draw the screne with the maps
    // Once a map is selected it calls a function in the localGame class
    // that sets the map up
    
    background(bg);
    update();
    mapOne(game);
    mapTwo(game);
    mapThree(game);
    mapFour(game);
  }
  
  void mapOne(localGame game) {
    
    // Draw mapOne
    fill(255);
    if (overMapOne) {
      fill(0);
      if(mousePressed) {
        game.selectMap(1);
        screen = 1;
        if (soundOn) {
          menuPlayer.pause();
          gamePlayer.rewind();
          gamePlayer.loop();
        }
      }
    }
    rect(mapOneX-5, mapOneY-5, mWidth+10, mHeight+10);
    image(mapOne, mapOneX, mapOneY);
  }
  void mapTwo(localGame game) {
    
    // Draw mapTwo
    fill(255);
    if (overMapTwo) {
      fill(0);
      if(mousePressed) {
        game.selectMap(2);
        screen = 1;
        if (soundOn) {
          menuPlayer.pause();
          gamePlayer.rewind();
          gamePlayer.loop();
        }
      }
    }
    rect(mapTwoX-5, mapTwoY-5, mWidth+10, mHeight+10);
    image(mapTwo, mapTwoX, mapTwoY);
  }
  void mapThree(localGame game) {
    
    // Draw mapThree
    fill(255);
    if (overMapThree) {
      fill(0);
      if(mousePressed) {
        game.selectMap(3);
        screen = 1;
        if (soundOn) {
          menuPlayer.pause();
          gamePlayer.rewind();
          gamePlayer.loop();
        }
      }
    }
    rect(mapThreeX-5, mapThreeY-5, mWidth+10, mHeight+10);
    image(mapThree, mapThreeX, mapThreeY);
  }
  void mapFour(localGame game) {
    
    // Draw mapFour
    fill(255);
    if (overMapFour) {
      fill(0);
      if(mousePressed) {
        game.selectMap(4);
        screen = 1;
        if (soundOn) {
          menuPlayer.pause();
          gamePlayer.rewind();
          gamePlayer.loop();
        }
      }
    }
    rect(mapFourX-5, mapFourY-5, mWidth+10, mHeight+10);
    image(mapFour, mapFourX, mapFourY);
  }
  
  boolean overMap(int x, int y, int width, int height) {
    // If the mouse is in between the ends of the map return true
    if (mouseX >= x && mouseX <= x+width && 
        mouseY >= y && mouseY <= y+height) {
      return true;
    } else return false;
  }
  
  void update() {
    // Check if the current x,y coords of the mouse are over any of the maps
    if ( overMap(mapOneX, mapOneY, mWidth, mHeight) ) {
      overMapOne = true;
      overMapTwo = overMapThree = overMapFour = false;
    } else if (overMap(mapTwoX, mapTwoY, mWidth, mHeight) ) {
      overMapTwo = true;
      overMapOne = overMapThree = overMapFour = false;
    } else if (overMap(mapThreeX, mapThreeY, mWidth, mHeight) ) {
      overMapTwo = overMapOne = overMapFour = false;
      overMapThree = true;
    } else if (overMap(mapFourX, mapFourY, mWidth, mHeight) ) {
      overMapTwo = overMapOne = overMapThree = false;
      overMapFour = true;
    } else overMapOne = overMapTwo = overMapThree = false;
  }
  
  
  // The networking version of everything above stays the exact same
  // Except of course that it is for the networkGame class
  void draw(networkGame game) {
    background(bg);
    update();
    mapOne(game);
    mapTwo(game);
    mapThree(game);
    mapFour(game);
  }
  
  void mapOne(networkGame game) {
    fill(255);
    if (overMapOne) {
      fill(0);
      if(mousePressed) {
        game.selectMap(1);
        screen = 3;
      }
    }
    rect(mapOneX-5, mapOneY-5, mWidth+10, mHeight+10);
    image(mapOne, mapOneX, mapOneY);
  }
  void mapTwo(networkGame game) {
    fill(255);
    if (overMapTwo) {
      fill(0);
      if(mousePressed) {
        game.selectMap(2);
        screen = 3;
      }
    }
    rect(mapTwoX-5, mapTwoY-5, mWidth+10, mHeight+10);
    image(mapTwo, mapTwoX, mapTwoY);
  }
  void mapThree(networkGame game) {
    fill(255);
    if (overMapThree) {
      fill(0);
      if(mousePressed) {
        game.selectMap(3);
        screen = 3;
      }
    }
    rect(mapThreeX-5, mapThreeY-5, mWidth+10, mHeight+10);
    image(mapThree, mapThreeX, mapThreeY);
  }
  void mapFour(networkGame game) {
    fill(255);
    if (overMapFour) {
      fill(0);
      if(mousePressed) {
        game.selectMap(4);
        screen = 3;
      }
    }
    rect(mapFourX-5, mapFourY-5, mWidth+10, mHeight+10);
    image(mapFour, mapFourX, mapFourY);
  }
    
    
}
