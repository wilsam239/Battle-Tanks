

// Classes to create the template for the pickup objects

interface pickup {


  void display(int x, int y);
}

// Class for the health pickup
class hpup implements pickup {

  int x, y;
  PImage image;
  boolean exists = false, spawn = true;

  hpup() {
    image = loadImage("assets/pickups/hpup.png");
  }
  // Method to dispaly the health pickup icon
  void display(int x, int y) {
    this.x = x;
    this.y = y;

    if ( spawn == true)
      image(image, x, y );
    exists = true;
  }
}

// Class for the shield pickup
class shup implements pickup {

  int x, y ;
  PImage image, shield;
  boolean exists = false, spawn = true, p1shieldon = false, p2shieldon = false;

  shup() {
    image = loadImage("assets/pickups/shieldgen.png");
    shield = loadImage("assets/pickups/shield.png");
  }

  // Methos to display the shield pickup icon
  void display(int x, int y) { 
    this.x = x;
    this.y = y;
    if ( spawn == true)
      image(image, x, y);
    exists = true;
  }
  // Method for keeping the shield on the tank *** not 100% ***
  void render(localGame game) {
    if (game.player1.health > 130) 
      if (p1shieldon == true) 
        image(shield, game.player1.x - Tile.spriteHeight, game.player1.y - Tile.spriteHeight);
    if (game.player2.health > 130)        
      if (p2shieldon == true) 
        image(shield, game.player2.x - Tile.spriteHeight, game.player2.y - Tile.spriteHeight);
  }
}