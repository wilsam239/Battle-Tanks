class mainMenu {
  int option1X, option1Y;
  int option2X, option2Y;
  int buttonSizeWidth = 400;
  int buttonSizeHeight = 50;
  boolean over1, over2;
  PImage bg;
  
  mainMenu() {
    option1X = width/6;
    option1Y = height/2;
    option2X = width/6;
    option2Y = height/2;
    bg = loadImage("assets/TitleScreen.png");
  }
  
  void option1() {
    if (over1) {
      fill(255,0,0);
      if (mousePressed && over1) {
        screen = 1;
      }
    } else {
      fill(200,200,200);
    }
    stroke(255);
    rect(option1X, option1Y, buttonSizeWidth, buttonSizeHeight);
    textSize(20);
    textAlign(CENTER);
    fill(0);
    text("Start Game", option1X + buttonSizeWidth/2, option1Y + buttonSizeHeight/2);
  }
  
  void draw() {
    background(bg);
    for (int x = 0; x < width; x+=30) {
      for (int y = 0; y < height; y+=30) {
        line(0,y, width,y);
        line(x,0, x,height);
      }
    }
    
    update(mouseX, mouseY);
    option1();
  }
  void update(int x, int y) {
    //println(x,y);
    if ( overOption1(option1X, option1Y, buttonSizeWidth, buttonSizeHeight) ) {
      over1 = true;
      over2 = false;
    } else if (overOption2(option2X, option2Y, buttonSizeWidth, buttonSizeHeight) ) {
      over2 = true;
      over1 = false;
    } else {
      over1 = over2 = false;
    }
  }
  
  boolean overOption1(int x, int y, int width, int height)  {
    if (mouseX >= x && mouseX <= x+width && 
        mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }
  
  boolean overOption2(int x, int y, int width, int height)  {
    if (mouseX >= x && mouseX <= x+width && 
        mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }
  
}
     