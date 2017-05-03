/* 
      Function:
        Tile class
      Author:
        Copied from in class lecture. Modified by Sam.
      Description:
        Creates two types of tiles, a wall tile and a floor tile.
        Uses interfaces to establish the same protocol between the
        two classes of tiles. 
        
        Each tile class that implements the interface must have a
        function called isPassable that returns a boolean, and a 
        function called draw that takes two variables - x and y
        which is used to display the tile at a position.
*/
interface Tile {
  /* 
      Function:
        Tile interface
      Description:
        Specifies that any class implementing this interface will have a
        spriteHeight of 30, an isPassable function that returns a boolean,
        and a draw function taking the x and y coords of the tile.
  */
  static int spriteHeight = 30;
  
  boolean isPassable();
  
  void draw(int x, int y);
}

class FloorTile implements Tile {
  /* 
      Function:
        FloorTile class
      Description:
        Creates a class called 'FloorTile' that implements the Tile
        interface. Creates a PImage that is the floor sprite. Which
        set gets laoded is based on a random value generated in the 
        localGame class.
  */
  PImage sprite;
  // The default contructor creates the shape
  FloorTile(int setNumber) {
    if (setNumber == 1) sprite = loadImage("assets/tiles/set1/floor.png");
    else sprite = loadImage("assets/tiles/set2/floor.png");
  }
  
  boolean isPassable() {
    return true;
  }
  
  void draw(int x, int y) {
    // Draw the shape at the x value * 30, and the y value * 30
    // ie: if x = 0, it will get drawn at 0, but if x = 3, it will
    // get drawn at 90. Same for y.
    image(sprite, x * spriteHeight, y * spriteHeight);
    // This text output was used to display the position in the tiles
    // array of the current shape.
    //text(x, x*spriteHeight + spriteHeight/2, y*spriteHeight + spriteHeight/2);
  }
}

class WallTile implements Tile {
  /* 
      Function:
        WallTile class
      Description:
        Creates a class called 'WallTile' that implements the Tile
        interface. Creates an array of 15 PImages that are the
        custom made wall sprites. Which set gets loaded is based on a
        random number generated in the localGame class.
        
        Note: the classes are almost exactly the same, aside from the
        sprite(s) loaded and the isPassable variable.
  */
  PImage[] sprites = new PImage[15];
  // Store a list of files in the first and second directory
  File[] fileset1 = listFiles("assets/tiles/set1/wall");
  File[] fileset2 = listFiles("assets/tiles/set2/wall");
  int tileType;
  
  WallTile(int type, int setNumber) {
    // If set 1 is to be loaded, load the sprites array with the appropriate images
    // same for set 2.
    if (setNumber == 1) {
      for (int i = 0; i < fileset1.length; i++) {
        String path = fileset1[i].getAbsolutePath();
        sprites[i] = loadImage(path);
      }
    } else {
      for (int i = 0; i < fileset2.length; i++) {
        String path = fileset2[i].getAbsolutePath();
        sprites[i] = loadImage(path);
      }
    }
    tileType = type;
  }
  
  // Called to determine if the player can continue.
  boolean isPassable() {
    return false;
  }
  // Output the image of the sprite
  void draw(int x, int y) {
    image(sprites[tileType],x * spriteHeight, y * spriteHeight);
  }
}