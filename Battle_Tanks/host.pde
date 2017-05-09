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
  float[] Thetas;
  String[] clientID;
  PImage[] tankSprite;
  
  host(PApplet sketch) {
    // Create the Server on port 5204
    server = new Server(sketch, 5204);
    clientSet = new ArrayList<Client>();
    components = new String[3];
    components[0] = str(width  - Tile.spriteHeight);
    components[1] = str(height - Tile.spriteHeight);
    components[2] = str(0);
    
    tankSprite = new PImage[2];
    tankSprite[0] = loadImage("assets/tanks/tank1.png");
    tankSprite[1] = loadImage("assets/tanks/tank2.png");
    
    x = 2*Tile.spriteHeight;
    oX = x/Tile.spriteHeight - 1;
    y = 2*Tile.spriteHeight;
    oY = y/Tile.spriteHeight - 1;
    rotation = 180;
  }
  
  void draw() {
    background(0);
    float[] clientX = new float[clientSet.size()];
    float[] clientY = new float[clientSet.size()];
    float[] Thetas = new float[clientSet.size()];
    String[] clientID = new String[clientSet.size()];
    
    pushMatrix();
    translate(x-15, y-15);
    rotate(radians(rotation));
    image(tankSprite[0], -15, -15);
    popMatrix();
    
    // If a client is available, we will find out
    // If there is no client, it will be"null"
    for(int i = 0; i< clientSet.size(); i++) {
      if((clientSet.get(i).available()>0)) {
        // We should only proceed if the client is not null
        String incomingMessage;
        incomingMessage = clientSet.get(i).readStringUntil('\n'); 
        // Print to Processing message window
        //println("Client says: " + incomingMessage);
        if(incomingMessage!=null){
           components = incomingMessage.split(",");
        }
        
        clientX[i] = float(components[0]);
        clientY[i] = float(components[1]);
        Thetas[i] = float(components[2]);
        clientID[i] = trim(components[3]);
        
        pushMatrix();
        translate(float(components[0]), float(components[1]));
        rotate(radians(float(components[2])));
        image(tankSprite[1+i], -15, -15);
        popMatrix();
      }
    }
    String toSend = str(x)+","+str(y)+","+str(rotation)+","+"0"+";";
  
    for(int x = 0; x< clientX.length; x++){
     
      toSend = toSend+str(clientX[x])+","+str(clientY[x])+","+str(Thetas[x])+","+clientID[x]+";";
      
    }
    
    println(toSend);
     //Broadcast the position
    server.write(toSend+"\n");
  }
  
  void serverEvent(Server server, Client client) {
    println("A new client has connected: " + client.ip());
    clientSet.add(client);
  }
    
}