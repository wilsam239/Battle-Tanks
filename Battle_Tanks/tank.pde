interface tankAction {
  void draw(tank t);
  //void onComplete(tank t);
  //boolean isFinished();
}

class tankIdle implements tankAction {
  
  void draw(tank t) {
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
    /*switch(direction) {
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
        throw new IllegalStateException("Somehow we have a direction that is not n, s, e, or w");
    }*/
    
    rect(t.x, t.y, t.tankWidth, t.tankHeight);
  }
    
}
    
class tank {
  float x, y, speed, tankWidth, tankHeight;
  tankAction action;
  
  tank() {
    tankWidth = 20;
    tankHeight = 50;
    speed = 5;
    x = width/2 + tankWidth/4;
    y = height/2 + tankHeight/10;
    this.action = new tankIdle();
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
  }
  
}