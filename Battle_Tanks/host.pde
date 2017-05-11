/* 
      Function:
        host class
      Author:
        Sam.
      Description:
        This class is sued to render the game. It creates a map using
        a 2d array. A hash map is used to define the fact that:
        0 = floor tile, 1 = wall tile.
        
        The gameState creates a tank, then draws both the tank and the
        tiles.
*/
class host {

  Server server;
  ArrayList <Client> clientSet;
  int x, y, health, rotation, oX, oY;
  String[] components;
  float[] clientX;
  float[] clientY;
  int[] clientHealth;
  float[] Thetas;
  String[] clientID;
  PImage tankSprite;
  
  host(PApplet sketch) {
    // Create the Server on port 5204
    server = new Server(sketch, 5204);
    clientSet = new ArrayList<Client>();
    components = new String[5];
    /*
    components[0] = str(width  - Tile.spriteHeight);
    components[1] = str(height - Tile.spriteHeight);
    components[2] = str(0);
    components[3] = str(100);*/
    
    //tankSprite = new PImage[2];
    tankSprite = loadImage("assets/tanks/tank2.png");
    //tankSprite[1] = loadImage("assets/tanks/tank2.png");
    
  }

  void draw() {
    String incomingMessage = clientSet.get(0).readStringUntil('\n');
    println(incomingMessage);
    float[] clientX = new float[clientSet.size()];
    float[] clientY = new float[clientSet.size()];
    float[] Thetas = new float[clientSet.size()];
    int[] clientHealth = new int[clientSet.size()];
    String[] clientID = new String[clientSet.size()];
   
    // If a client is available, we will find out
    // If there is no client, it will be"null"
    //String incomingMe = clientSet.get(0).readStringUntil('\n');
    //println(incomingMe);
    //String incomingMessage = incomingMe;
    //if((clientSet.get(0).available() > 0)) {
      // We should only proceed if the client is not null
      // Print to Processing message window
      //println("Client says: " + incomingMessage);
      if(incomingMessage!=null){
        components = incomingMessage.split(",");
        //println(incomingMessage);
         // X - Y - health - rotation -id
        clientX[0] = float(components[0]);
        clientY[0] = float(components[1]);
        clientHealth[0] = int(components[2]);
        Thetas[0] = float(components[3]);
        clientID[0] = trim(components[4]);
        
        pushMatrix();
        translate(float(components[0])-15, float(components[1])-15);
        println(float(components[3]));
        rotate(radians(float(components[3])));
        image(tankSprite, -15, -15);
        popMatrix();
      }
    //}
    String toSend = str(nwgs.player.x)+","+str(nwgs.player.y)+","+str(nwgs.player.health)+","+str(nwgs.player.rotation)+","+"0"+";";
    for(int x = 0; x < clientSet.size(); x++){
   
      toSend = toSend+str(clientX[x])+","+str(clientY[x])+","+str(clientHealth[x])+","+str(Thetas[x])+","+clientID[x];
    
    }
    //println(toSend);
    Host.server.write(toSend+"\n"); 
  }
    
}