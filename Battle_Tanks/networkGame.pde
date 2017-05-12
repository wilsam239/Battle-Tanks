/* 
      Function:
        networkGame class
      Author:
        Sam. updateKeys()/tankNotMoving() by Ben.
      Description:
        This class is used to render the netowrk game. It creates a map 
        using a 2d array. A hash map is used to define the fact that:
        0 = floor tile, 1-15 = wall tile.
        
        It draws the map and the calls the user and hsot classes to draw the tanks
*/

class networkGame {
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
  
  // The actual map that the game will use
  int[][] gameMap = new int [20][30];
  // Stores the height and width of the map array
  int h = gameMap.length;
  int w = gameMap[0].length;
  // Stores the randomly generated number that tells the map to laod a certain set of tiles
  int set;
  int selectedMap;
  int player1Health, player2Health;
  
  // Creates a tank for the player
  tank player;
  
  // Boolean array to store what ekys are pressed
  boolean[] keys;
  // Boolean that determines whether the player is the host
  boolean isHost;
  
  networkGame(boolean hosting) {
    
    // The default contructor takes in a boolean value which tells the class
    // whether the player is hosting or not
    isHost = hosting;
    
    player1Health = player2Health = 100;
      
    // Creates a tiles hashmap
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
    
    // Set the players x,y coordinates depending on wther they are hosting or not
    if (isHost) {
      player = new tank(2*Tile.spriteHeight, 2*Tile.spriteHeight, 180);
    } else {
      player = new tank(width - Tile.spriteHeight, height-Tile.spriteHeight, 0);
    }
    
    // Assigns each key in the array to false
    keys = new boolean[5];
    keys[0] = false;
    keys[1] = false;
    keys[2] = false;
    keys[3] = false;
    keys[4] = false;
  }
  
  void selectMap(int mapNumber) {
    // This function is called to set the map that will be used
    // If the mapNumber is 1 , set all the values of gameMap to be the values in mapOne
    // Repeat for maps 2 , 3 and 4.
    selectedMap = mapNumber;
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
  
  boolean tankNotPresent(int x, int y) {
    // This function takes an x value, y vale
    // It checks to see if the other player is in the location x,y
    // If they are, return false meaning that the player cannot progress
    // If they are not, return true meaning that the player can progress
    int tankTwoX, tankTwoY;
    boolean result = false;
    if(isHost) {
      tankTwoX = int(Host.components[0])/Tile.spriteHeight - 1;
      tankTwoY = int(Host.components[1])/Tile.spriteHeight - 1;
      if (x == tankTwoX && y == tankTwoY) result = false;
      else result = true;
    } else if(!isHost) {
      tankTwoX = int(User.components[0])/Tile.spriteHeight - 1;
      tankTwoY = int(User.components[1])/Tile.spriteHeight - 1;
      if (x == tankTwoX && y == tankTwoY) result = false;
      else result = true;
    }
    return result;
  }
  
  boolean isPassable(int x, int y) {
    // This function takes an x and y value
    // It then checks the x and y position in the map array
    // and returns whether the tile is passable or not.
    return tiles.get(gameMap[y][x]).isPassable();    
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
  }
  
  void draw() {
    if (player1Health <= 0 || player2Health <= 0) {
      if (player1Health <= 0) GameOver = new gameOver(2);
      else if (player2Health <= 0) GameOver = new gameOver(1);
      screen = 5;
    } else {
      // Draw the map
      for (int x = 0; x < w; x++) {
        for (int y = 0; y < h; y++) {
          tiles.get(gameMap[y][x]).draw(x, y);
        }
      }
      
      // Draw the player
      //player1Health = player.health;
      player.draw(this);
     
      // Draw the other player
      if(isHost) Host.draw();
      else User.draw();
    }
  }  
}