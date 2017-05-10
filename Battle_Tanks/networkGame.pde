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
  // The actual map that the game iwll use
  int[][] gameMap = new int [20][30];
  // Stores the height and width of the map array
  int h = gameMap.length;
  int w = gameMap[0].length;
  // Stores the randomly generated number that tells the map to laod a certain set of tiles
  int set;
  // Each players tank
  tank player;
  boolean[] keys;
  String[] components;
  boolean isHost;
  
  networkGame(boolean hosting) {
    isHost = hosting;
    for (int x = 0; x < w; x++) {
      for (int y = 0; y < h; y++) {
        gameMap[y][x] = mapOne[y][x];
      }
    }
      
    // Creates a tiles hashamp
    //set = (int)random(1,2.5);
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
    player = new tank(1);
    components = new String[5];
  
    keys = new boolean[5];
    keys[0] = false;
    keys[1] = false;
    keys[2] = false;
    keys[3] = false;
    keys[4] = false;
  }
    
  boolean tankNotPresent(int x, int y) {
    // This function takes an x value, y vale and a playerNumber
    // It checks to see if the other player is in the location x,y
    // If they are, return false meaning that the player cannot progress
    // If they are not, return true meaning that the player can progress
    int tankTwoX = int(components[0])/Tile.spriteHeight - 1;
    int tankTwoY = int(components[1])/Tile.spriteHeight - 1;
    
    if (x == tankTwoX && y == tankTwoY) return false;
      else return true;
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
    
    for (int x = 0; x < w; x++) {
      for (int y = 0; y < h; y++) {
        tiles.get(gameMap[y][x]).draw(x, y);
      }
    }
    
    player.draw(this);
     
    if(isHost) {
      Host.draw();
      String toSend = str(player.x)+","+str(player.y)+","+str(player.health)+","+str(player.rotation)+","+"0"+";";
      for(int x = 0; x < Host.clientX.length; x++){
     
        toSend = toSend+str(Host.clientX[x])+","+str(Host.clientY[x])+","+str(Host.clientHealth[x])+","+str(Host.Thetas[x])+","+Host.clientID[x]+";";
      
      }
      println(toSend);
      Host.server.write(toSend+"\n"); 
    } else {
      User.draw();
      User.client.write(player.x+","+player.y+","+player.rotation+","+player.health+","+User.clientID+"\n");
    }
      
  }
  
  
}