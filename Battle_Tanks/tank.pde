interface tankAction {
  void draw(tank t);
  //void onComplete(tank t);
  //boolean isFinished();
}

class tankIdle implements tankAction {
  
  void draw(tank t) {
    fill(255);
    rect(t.x, t.y, t.tankWidth, t.tankHeight);
  }
   
  /*void onComplete(tank t) {
    //Nothing, we're idle
  }
  
  boolean isFinished() {
    return true;
  }*/
}

class tankMoving implements tankAction {
  
  char direction;
  
  tankMoving(char direction) {
    this.direction = direction;
  }
  
  void draw(tank t) {
    //int offsetX, offsetY;
    switch(direction) {
      case 'N':          
        t.y -= 1;
        break;  
      case 'E':
        t.x += 1;
        break;
      case 'S': 
        t.y += 1;
        break;  
      case 'W':
        t.x -= 1;
        break;  
      default:
        throw new IllegalStateException("Somehow we have a direction that is not n, s, e, or w");
    }
    fill(255);
    rect(t.x, t.y, t.tankWidth, t.tankHeight);
  }
    
}
    
class tank {
  int x, y, speed, tankWidth, tankHeight;
  int health;
  int[] topLeft;
  int[] topRight;
  int[] lowerLeft;
  int[] lowerRight;
  
  
  tankAction action;
  
  tank() {
    tankWidth = 20;
    tankHeight = 50;
    speed = 5;
    health = 100;
    x = width/2 + tankWidth/4;
    y = height/2 + tankHeight/10;
    this.action = new tankIdle();
    topLeft = new int[2];
    topRight = new int[2];
    lowerLeft = new int[2];
    lowerRight = new int[2];
  }
  
  void draw() {
    if (keyPressed) {
      if (key == 'W' || key == 'w') {
        this.action = new tankMoving('N');
      } else if (key == 'A' || key == 'a') {
        this.action = new tankMoving('W');
      } else if (key == 'S' || key == 's') {
        this.action = new tankMoving('S');
      } else if (key == 'D' || key == 'd') {
        this.action = new tankMoving('E');
      }
    } else {    
      this.action = new tankIdle();
    }
    action.draw(this);
    updateCoord();
    health();
  }
  
  void health() {
    fill(0);
    stroke(255);
    rect(x - 40,y - 30, 100,10);
    fill(255,0,0);
    rect(x - 40, y - 30, this.health, 10);
  }
  
  void updateCoord() {
    topLeft[0] = x;
    topLeft[1] = y;
    topRight[0] = x + tankWidth;
    topRight[1] = y;
    lowerLeft[0] = x;
    lowerLeft[1] = y + tankHeight;
    lowerRight[0] = x + tankWidth;
    lowerRight[1] = y + tankHeight;
    
    ellipse(topLeft[0],topLeft[1], 10,10);
    ellipse(topRight[0],topRight[1], 10,10);
    ellipse(lowerLeft[0],lowerLeft[1], 10,10);
    ellipse(lowerRight[0],lowerRight[1], 10,10);
  }
    
  
}