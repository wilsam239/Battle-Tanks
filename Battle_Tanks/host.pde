/* 
      Function:
        localGame class
      Author:
        Sam, based on the in class lecture code
      Description:
        This class is sued to render the game. It creates a map using
        a 2d array. A hash map is used to define the fact that:
        0 = floor tile, 1 = wall tile.
        
        The gameState creates a tank, then draws both the tank and the
        tiles.
*/
class host {
  // What number maps to what sort of tile. eg 1 -> Floor tile
  // The hashmap of tile objects, referenced by an integer key called tiles
  HashMap<Integer, Tile> tiles;
  // grid of tiles that is each map
  int[][] mapOne = new int[][] {
    { 1 , 6, 6 , 9 , 6 , 6, 6, 6, 6, 6, 2 , 0 , 0, 0, 0 , 0, 0, 0, 0, 1 , 6, 6 , 6, 6, 6, 6, 6 , 6 , 6, 2  },
    { 14, 0, 0 , 14, 0 , 0, 0, 0, 0, 0, 14, 0 , 0, 0, 0 , 0, 0, 0, 0, 14, 0, 0 , 0, 0, 0, 0, 0 , 0 , 0, 14 },
    { 14, 0, 0 , 14, 0 , 0, 0, 0, 0, 0, 14, 0 , 0, 0, 0 , 0, 0, 0, 0, 14, 0, 0 , 0, 0, 5, 6, 6 , 2 , 0, 14 },
    { 14, 0, 5 , 4 , 0 , 0, 0, 0, 0, 0, 3 , 6 , 6, 6, 6 , 6, 6, 6, 6, 4 , 0, 0 , 0, 0, 0, 0, 0 , 14, 0, 14 },
    { 14, 0, 0 , 0 , 0 , 0, 0, 0, 0, 0, 0 , 0 , 0, 0, 0 , 0, 0, 0, 0, 0 , 0, 0 , 0, 0, 0, 0, 0 , 14, 0, 14 },
    { 14, 0, 5 , 6 , 9 , 7, 0, 0, 0, 0, 0 , 0 , 0, 0, 0 , 0, 0, 0, 0, 0 , 0, 0 , 0, 0, 0, 0, 0 , 14, 0, 14 },
    { 14, 0, 0 , 0 , 14, 0, 0, 0, 0, 0, 0 , 0 , 0, 0, 0 , 0, 0, 0, 0, 0 , 0, 0 , 0, 0, 0, 0, 0 , 14, 0, 14 },
    { 14, 0, 0 , 0 , 15, 0, 0, 0, 0, 0, 0 , 0 , 0, 0, 0 , 0, 0, 0, 0, 0 , 0, 5 , 6, 6, 7, 0, 0 , 14, 0, 14 },
    { 14, 0, 0 , 0 , 0 , 0, 0, 0, 0, 0, 0 , 0 , 5, 6, 2 , 0, 0, 0, 0, 0 , 0, 0 , 0, 0, 0, 0, 0 , 15, 0, 14 },
    { 14, 0, 13, 0 , 0 , 0, 0, 0, 0, 0, 0 , 0 , 0, 0, 14, 0, 0, 0, 0, 0 , 0, 0 , 0, 0, 0, 0, 0 , 0 , 0, 14 },
    { 14, 0, 3 , 6 , 6 , 6, 6, 7, 0, 0, 0 , 0 , 0, 0, 14, 0, 0, 0, 0, 0 , 0, 0 , 0, 0, 0, 0, 0 , 0 , 0, 14 },
    { 14, 0, 0 , 0 , 0 , 0, 0, 0, 0, 0, 0 , 0 , 0, 0, 14, 0, 0, 0, 0, 0 , 0, 0 , 0, 0, 0, 0, 0 , 0 , 0, 14 },
    { 14, 0, 0 , 0 , 0 , 0, 0, 0, 0, 0, 0 , 0 , 0, 0, 3 , 7, 0, 0, 0, 0 , 0, 0 , 0, 0, 0, 5, 6 , 6 , 6, 10 },
    { 11, 6, 7 , 0 , 0 , 0, 0, 0, 0, 0, 0 , 0 , 0, 0, 0 , 0, 0, 0, 0, 0 , 0, 0 , 0, 0, 0, 0, 0 , 0 , 0, 14 },
    { 14, 0, 0 , 0 , 0 , 0, 0, 0, 0, 0, 0 , 0 , 0, 0, 0 , 0, 0, 0, 0, 0 , 0, 13, 0, 0, 0, 0, 0 , 0 , 0, 14 },
    { 14, 0, 0 , 0 , 0 , 0, 0, 0, 0, 0, 13, 0 , 0, 0, 0 , 0, 0, 0, 0, 0 , 0, 14, 0, 0, 0, 0, 0 , 0 , 0, 14 },
    { 14, 0, 0 , 13, 0 , 0, 0, 0, 0, 0, 14, 0 , 0, 0, 0 , 0, 0, 0, 0, 5 , 6, 10, 0, 0, 0, 0, 1 , 7 , 0, 14 },
    { 14, 0, 0 , 14, 0 , 0, 5, 6, 6, 6, 12, 6 , 7, 0, 0 , 0, 0, 0, 0, 0 , 0, 14, 0, 0, 0, 0, 14, 0 , 0, 14 },
    { 14, 0, 0 , 14, 0 , 0, 0, 0, 0, 0, 0 , 0 , 0, 0, 0 , 0, 0, 0, 0, 0 , 0, 14, 0, 0, 0, 0, 14, 0 , 0, 14 },
    { 3 , 6, 6 , 12, 6 , 6, 6, 6, 6, 6, 6 , 6 , 6, 6, 6 , 6, 6, 6, 6, 6 , 6, 12, 6, 6, 6, 6, 12, 6 , 6, 4  }
  };
  // The actual map that the game iwll use
  int[][] gameMap = new int [20][30];
  // Stores the height and width of the map array
  int h = gameMap.length;
  int w = gameMap[0].length;
  // Stores the randomly generated number that tells the map to laod a certain set of tiles
  int set;
  // Each players tank
  tank player1;
  tank player2;
  Server server;
  String[] components;
  
  host(PApplet sketch) {
    // Creates a tiles hashamp
    set = (int)random(1,2.5);
    tiles = new HashMap<Integer, Tile>();
    // Pair the values with the tiles
    // 0 with floor tiles
    // 1-15 with wall tiles
    // Pass the set integer into the class to load the appropriate tile.
    tiles.put(0, new FloorTile(set));
    int counter = 1;
    for (int i = 0; i < 15; i++) {
      tiles.put(counter, new WallTile(i, set));
      counter++;
    }
    //tiles.put(2, new WallTile(1));
    player1 = new tank(1);
    player2 = new tank(2);
    // Create the Server on port 5204
    server = new Server(sketch, 5204);
    
  }
    
}