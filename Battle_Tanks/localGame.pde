/* 
      Function:
        localGame class
      Author:
        Sam, based on the in class lecture code. updateKeys()/tankNotMoving() by Ben.
      Description:
        This class is sued to render the game. It creates a map using
        a 2d array. A hash map is used to define the fact that:
        0 = floor tile, 1 = wall tile.
        
        The gameState creates a tank, then draws both the tank and the
        tiles.
*/
class localGame {
  // What number maps to what sort of tile. eg 1 -> Floor tile
  // The hashmap of tile objects, referenced by an integer key called tiles
  HashMap<Integer, Tile> tiles;
  // grid of tiles that is each map
  int[][] mapOne = new int[][] {
    { 1 , 6 , 6 , 9 , 6 , 6 , 6 , 6 , 6 , 6 , 2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 2  },
    { 14, 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 5 , 6 , 6 , 2 , 0 , 14 },
    { 14, 0 , 5 , 4 , 0 , 0 , 0 , 0 , 0 , 0 , 3 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 4 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 14 },
    { 14, 0 , 5 , 6 , 9 , 7 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 14 },
    { 14, 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 14 },
    { 14, 0 , 0 , 0 , 15, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 5 , 6 , 6 , 7 , 0 , 0 , 14, 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 5 , 6 , 2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 15, 0 , 14 },
    { 14, 0 , 13, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 3 , 6 , 6 , 6 , 6 , 7 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 3 , 7 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 5 , 6 , 6 , 6 , 10 },
    { 11, 6 , 7 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 13, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 13, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 13, 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 5 , 6 , 10, 0 , 0 , 0 , 0 , 1 , 7 , 0 , 14 },
    { 14, 0 , 0 , 14, 0 , 0 , 5 , 6 , 6 , 6 , 12, 6 , 7 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 14, 0 , 0 , 14 },
    { 14, 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 14, 0 , 0 , 14 },
    { 3 , 6 , 6 , 12, 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 12, 6 , 6 , 6 , 6 , 12, 6 , 6 , 4  }
  };
  
  int[][] mapTwo = new int[][] {
    { 1 , 6 , 6 , 9 , 6 , 6 , 6 , 6 , 6 , 6 , 2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 2  },
    { 14, 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 5 , 4 , 0 , 0 , 0 , 0 , 0 , 0 , 3 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 4 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 8 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 8 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 8 , 0 , 0 , 0 , 0 , 0 , 0 , 8 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 8 , 0 , 0 , 0 , 0 , 8 , 0 , 0 , 0 , 0 , 0 , 1 , 6 , 7 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 5 , 2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 ,  2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 3 ,  4 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 3 , 7 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 5 , 6 , 4 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,  0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 8 , 0 , 0 , 0 , 0 , 8 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 8 , 0 , 0 , 0 , 0 , 0 , 0 , 8 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 8 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 8 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 13, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 7 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 14 },
    { 3 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 12, 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 12, 6 , 6 , 4  }
  };
  
  int[][] mapThree = new int[][] {
    { 1 , 6 , 6 , 9 , 6 , 6 , 6 , 6 , 6 , 6 , 2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 2  },
    { 14, 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 5 , 4 , 0 , 0 , 13, 0 , 0 , 0 , 3 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 4 , 0 , 0 , 0 , 0 , 0 , 13, 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 11, 6 , 6 , 6 , 10 },
    { 14, 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 15, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 6 , 6 , 7 , 0 , 0 , 5 , 2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 15, 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 15, 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 1 , 2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 1 , 2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 3 , 4 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 15, 0 , 0 , 14, 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 13, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 3 , 4 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 13, 0 , 0 , 0 , 0 , 0 , 0 , 13, 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 3 , 7 , 0 , 0 , 5 , 6 , 6 , 4 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 14 },
    { 11, 6 , 6 , 6 , 6 , 6 , 2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 15, 0 , 0 , 1 , 7 , 0 , 14 },
    { 14, 0 , 0 , 0 , 13, 0 , 15, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 14 },
    { 3 , 6 , 6 , 6 , 12, 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 12, 6 , 6 , 4  }
  };
  
  int[][] mapFour = new int[][] {
    { 1 , 6 , 6 , 9 , 6 , 6 , 6 , 6 , 6 , 6 , 2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 9 , 6 , 2  },
    { 14, 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 14 },
    { 14, 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 15, 0 , 14 },
    { 14, 0 , 5 , 4 , 0 , 0 , 0 , 0 , 0 , 0 , 3 , 6 , 6 , 6 , 9 , 6 , 6 , 6 , 6 , 4 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 15, 0 , 1 , 7 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 5 , 2 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 5 , 6 , 10, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 13, 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 15, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 5 , 6 , 10 },
    { 14, 0 , 0 , 3 , 6 , 7 , 0 , 13, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 15, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 11, 6 , 6 , 6 , 10 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 5 , 6 , 6 , 7 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 15, 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 5 , 6 , 9 , 7 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14 },
    { 14, 0 , 0 , 13, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1 , 7 , 0 , 14 },
    { 14, 0 , 0 , 15, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 5 , 7 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 14 },
    { 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 14, 0 , 0 , 14 },
    { 3 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 12, 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 6 , 12, 6 , 6 , 4  }
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
  // Tracks which keys are currently being pressed.
  boolean[] keys;
  
  localGame() {
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
  
    keys = new boolean[10];
    keys[0] = false;
    keys[1] = false;
    keys[2] = false;
    keys[3] = false;
    keys[4] = false;
    keys[5] = false;
    keys[6] = false;
    keys[7] = false;
    keys[8] = false;
    keys[9] = false;
  }
  
  void updateKeys(char pressedKey, boolean press) {
    // Updates the keys array when a key is pressed. This is done so that
    // multiple key presses can be tracked at the same time, allowing both
    // tanks to move without their key presses cancelling out each other.
    if (pressedKey == 'W' || pressedKey == 'w') {
      if (press == true) keys[0] = true;
      else keys[0] = false;
    }
    if (pressedKey == 'A' || pressedKey == 'a') {
      if (press == true) keys[1] = true;
      else keys[1] = false;
    }
    if (pressedKey == 'S' || pressedKey == 's') {
      if (press == true) keys[2] = true;
      else keys[2] = false;
    }
    if (pressedKey == 'D' || pressedKey == 'd') {
      if (press == true) keys[3] = true;
      else keys[3] = false;
    }
    if (pressedKey == 'F' || pressedKey == 'f') {
      if (press == true) keys[4] = true;
      else keys[4] = false;
    }
    if (pressedKey == 'I' || pressedKey == 'i') {
      if (press == true) keys[5] = true;
      else keys[5] = false;
    }
    if (pressedKey == 'J' || pressedKey == 'j') {
      if (press == true) keys[6] = true;
      else keys[6] = false;
    }
    if (pressedKey == 'K' || pressedKey == 'k') {
      if (press == true) keys[7] = true;
      else keys[7] = false;
    }
    if (pressedKey == 'L' || pressedKey == 'l') {
      if (press == true) keys[8] = true;
      else keys[8] = false;
    }
    if (pressedKey == ':' || pressedKey == ';') {
      if (press == true) keys[9] = true;
      else keys[9] = false;
    }
  }
  
  boolean isPassable(int x, int y) {
    // This function takes an x and y value
    // It then checks the x and y position in the map array
    // and returns whether the tile is passable or not.
    return tiles.get(gameMap[y][x]).isPassable();    
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
  
  boolean tankNotMoving(int playerNumber, int x, int y) {
    // This function takes an x value, y value, and a playerNumber.
    // It checks to see whether the other player is currently moving to the
    // location (x,y). If the tank if moving there, it returns false, indicating
    // that the space cannot be moved to. If it is not, it returns true, indicating
    // the player is allowed to move.
    tank otherTank;
    if (playerNumber == 1) {
      otherTank = player2;
    } else {
      otherTank = player1;
    }
    if (otherTank.state instanceof TankMoving) {
      int[] nextLoc = otherTank.state.movingTo(otherTank);
      if (x == nextLoc[0] && y == nextLoc[1]) return false;
    }
    return true;
  }
  
  void draw() {
    // draw the map tiles
    for (int x = 0; x < w; x++) {
      for (int y = 0; y < h; y++) {
        tiles.get(gameMap[y][x]).draw(x, y);
        /*line(0,y*30, width,y*30);
        line(x*30,0, x*30,height);*/
      }
    }
    // draw the tanks
    player1.draw(this);
    player2.draw(this);
    header();
  }
  
  void selectMap(int mapNumber) {
    // This function is called to set the map that will be used
    // If the mapNumber is 1 , set all the values of gameMap to be the values in mapOne
    // Repeat for maps 2 , 3 and 4.
    if(mapNumber == 1) {
      for (int x = 0; x < w; x++) {
        for (int y = 0; y < h; y++) {
         gameMap[y][x] = mapOne[y][x];
        }
      }
    } else if (mapNumber == 2) {
      for (int x = 0; x < w; x++) {
        for (int y = 0; y < h; y++) {
         gameMap[y][x] = mapTwo[y][x];
        }
      }
    } else if (mapNumber == 3) {
      for (int x = 0; x < w; x++) {
        for (int y = 0; y < h; y++) {
         gameMap[y][x] = mapThree[y][x];
        }
      }
    } else if (mapNumber == 4) {
      for (int x = 0; x < w; x++) {
        for (int y = 0; y < h; y++) {
         gameMap[y][x] = mapFour[y][x];
        }
      }
    }
  }
  
  void header() {
    
  }
}
