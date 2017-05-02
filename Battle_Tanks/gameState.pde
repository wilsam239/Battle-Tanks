/* 
      Function:
        gameState class
      Author:
        Sam, based on the in class lecture code
      Description:
        This class is sued to render the game. It creates a map using
        a 2d array. A hash map is used to define the fact that:
        0 = floor tile, 1 = wall tile.
        
        The gameState creates a tank, then draws both the tank and the
        tiles.
*/
class gameState {
  // What number maps to what sort of tile. eg 1 -> Floor tile
  // The hashmap of tile objects, referenced by an integer key called tiles
  HashMap<Integer, Tile> tiles;
  
  // grid of tiles that is the map
  int[][] map = new int[][] {
    { 1 , 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 2  },
    { 14, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 14 },
    { 14, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 14 },
    { 14, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 14 },
    { 14, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 14 },
    { 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14 },
    { 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14 },
    { 14, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 14 },
    { 14, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 14 },
    { 14, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 14 },
    { 14, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 14 },
    { 14, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14 },
    { 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14 },
    { 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 14 },
    { 14, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 14 },
    { 14, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 14 },
    { 14, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 14 },
    { 14, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 14 },
    { 14, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 14 },
    { 3 , 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 4  }
  };
  // stores the height and width of the map array
  int h = map.length;
  int w = map[0].length;

  tank player1;
  tank player2;
  
  gameState() {
    // Creates a tiles hashamp
    tiles = new HashMap<Integer, Tile>();
    // Pair the values with the tiles
    // 0 with floor tiles
    // 1 with wall tiles
    tiles.put(0, new FloorTile());
    int counter = 1;
    for (int i = 0; i < 15; i++) {
      tiles.put(counter, new WallTile(i));
      counter++;
    }
    //tiles.put(2, new WallTile(1));
    player1 = new tank(1);
    player2 = new tank(2);
  }
  
  boolean isPassable(int x, int y) {
    // This function takes an x and y value
    // It then checks the x and y position in the map array
    // and returns whether the tile is passable or not.
    return tiles.get(map[y][x]).isPassable();    
  }
  
  boolean tankNotPresent(int x, int y, int playerNumber) {
    // This function takes an x value, y vale and a playerNumber
    // It checks to see if the other player is in the location x,y
    // If they are, return false meaning that the player cannot progress
    // If they are not, return true meaning that the player can progress
    int tankOneX = player1.oX;
    int tankOneY = player1.oY;
    int tankTwoX = player2.oX;
    int tankTwoY = player2.oY;
    
    if (playerNumber == 1) {
      if (x == tankTwoX && y == tankTwoY) return false;
      else return true;
    } else {
      if (x == tankOneX && y == tankOneY) return false;
      else return true;
    }
  }
  
  void draw() {
    // draw the map tiles
    for (int x = 0; x < w; x++) {
      for (int y = 0; y < h; y++) {
        tiles.get(map[y][x]).draw(x, y);
        /*line(0,y*30, width,y*30);
        line(x*30,0, x*30,height);*/
      }
    }
    // draw the tank
    player1.draw(this);
    player2.draw(this);
  }   
}