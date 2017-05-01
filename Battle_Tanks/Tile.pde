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
        interface. Creates a PShape of a different colour than the 
        wall tiles, and implements the functions as described by the
        interface.
  */
  PShape shape;
  // The default contructor creates the shape
  FloorTile() {
    noStroke();
    shape = createShape(RECT, 0, 0, spriteHeight, spriteHeight);
    shape.setFill(color(60, 60, 60));
  }
  
  boolean isPassable() {
    return true;
  }
  
  void draw(int x, int y) {
    // Draw the shape at the x value * 30, and the y value * 30
    // ie: if x = 0, it will get drawn at 0, but if x = 3, it will
    // get drawn at 90. Same for y.
    shape(shape, x * spriteHeight, y * spriteHeight);
    // This text output was used to display the position in the tiles
    // array of the current shape.
    text(x, x*spriteHeight + spriteHeight/2, y*spriteHeight + spriteHeight/2);
  }
}

class WallTile implements Tile {
  /* 
      Function:
        WallTile class
      Description:
        Creates a class called 'WallTile' that implements the Tile
        interface. Creates a PShape of a different colour than the 
        floor tiles, and implements the functions as described by the
        interface.
        
        Note: the classes are almost exactly the same, aside from the
        colour and the isPassable variable.
  */
  PShape shape;
  WallTile() {
    noStroke();
    shape = createShape(RECT, 0, 0, spriteHeight, spriteHeight);
    shape.setFill(color(100, 100, 80));
  }
  
  boolean isPassable() {
    return false;
  }
  
  void draw(int x, int y) {
    shape(shape, x * spriteHeight, y * spriteHeight);
    text(x, x*spriteHeight + spriteHeight/2, y*spriteHeight + spriteHeight/2);
  }
}