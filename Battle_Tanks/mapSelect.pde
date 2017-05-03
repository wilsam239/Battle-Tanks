class mapSelect {
  int mapOneX, mapOneY;
  int mapTwoX, mapTwoY;
  int mapThreeX, mapThreeY;
  int mapFourX, mapFourY;
  int mWidth, mHeight;
  boolean overMapOne, overMapTwo, overMapThree, overMapFour;
  PImage mapOne, mapTwo, mapThree, mapFour, bg;
  
  mapSelect() {
    
    mWidth = 300;
    mHeight = 200;
    mapOneX = 120;
    mapOneY = mapTwoY = 150;
    mapTwoX = mapOneX + mWidth + 30 ;
    mapThreeX = mapOneX;
    mapThreeY = mapFourY = mapOneY + mHeight + 30;
    mapFourX = mapThreeX + mWidth + 30;
    mapOne = loadImage("assets/maps/map1.png");
    mapTwo = loadImage("assets/maps/map2.png");
    mapThree = loadImage("assets/maps/map3.png");
    mapFour = loadImage("assets/maps/map4.png");    
    bg = loadImage("assets/screens/MapScreen.png");
  }
  
  void draw(localGame game) {
    background(bg);
    update();
    mapOne(game);
    mapTwo(game);
    mapThree(game);
    mapFour(game);
  }
  
  void mapOne(localGame game) {
    fill(255);
    if (overMapOne) {
      fill(0);
      if(mousePressed) {
        game.selectMap(1);
        screen = 1;
      }
    }
    rect(mapOneX-5, mapOneY-5, mWidth+10, mHeight+10);
    image(mapOne, mapOneX, mapOneY);
  }
  void mapTwo(localGame game) {
    fill(255);
    if (overMapTwo) {
      fill(0);
      if(mousePressed) {
        game.selectMap(2);
        screen = 1;
      }
    }
    rect(mapTwoX-5, mapTwoY-5, mWidth+10, mHeight+10);
    image(mapTwo, mapTwoX, mapTwoY);
  }
  void mapThree(localGame game) {
    fill(255);
    if (overMapThree) {
      fill(0);
      if(mousePressed) {
        game.selectMap(3);
        screen = 1;
      }
    }
    rect(mapThreeX-5, mapThreeY-5, mWidth+10, mHeight+10);
    image(mapThree, mapThreeX, mapThreeY);
  }
  void mapFour(localGame game) {
    fill(255);
    if (overMapFour) {
      fill(0);
      if(mousePressed) {
        game.selectMap(4);
        screen = 1;
      }
    }
    rect(mapFourX-5, mapFourY-5, mWidth+10, mHeight+10);
    image(mapFour, mapFourX, mapFourY);
  }
  
  boolean overMap(int x, int y, int width, int height) {
    // If the mouse is in between the ends of the button return true
    if (mouseX >= x && mouseX <= x+width && 
        mouseY >= y && mouseY <= y+height) {
      return true;
    } else return false;
  }
  
  void update() {
    // Check if the current x,y coords of the mouse are over any of the buttons
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
    
    
}