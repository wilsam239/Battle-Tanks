/* 
      Function:
        host class
      Author:
        Sam.
      Description:
        This class is used to manage the host's game when playing using
        network multiplayer mode. It creates a server and writes data
        to the connected client.
        
        It draws the connected client aswell. In actuality, it wasn't
        necessary to use arrays (as there is only one client), but the 
        code I based it off was done using arrays.
*/
class host {
  
  // The server
  Server server;
  
  // The arraylist of clients
  ArrayList <Client> clientSet;
  
  // The components that will be sent by the client to the server
  String[] components;
  
  // The x value of the client
  float[] clientX;
  
  // The y value of the client
  float[] clientY;
  
  // The health of the client
  int[] clientHealth;
  
  // The rotation of the client
  float[] Thetas;
  
  // the ID of the client
  String[] clientID;
  
  // The sprite used by the client
  PImage tankSprite;
  
  // The default constructor, which takes in the PApplet sketch variable (current sketch)
  // The variable is used to create the server.
  host(PApplet sketch) {
    
    // Create the Server on port 5204
    server = new Server(sketch, 5204);
    
    // Initialise an arrayList
    clientSet = new ArrayList<Client>();
    
    // Initialise the array for data in
    // The order of the data is as follows:
    // x position > y position > health > rotation > ID
    components = new String[5];
    
    // Load the second tank image so that the other player looks like player 2
    tankSprite = loadImage("assets/tanks/tank2.png");
  }

  void draw() {
    
    // Read in the client's string
    String incomingMessage = clientSet.get(0).readStringUntil('\n');
    
    // Create arrays based off the size of clientSet (always 1)
    float[] clientX = new float[clientSet.size()];
    float[] clientY = new float[clientSet.size()];
    float[] Thetas = new float[clientSet.size()];
    int[] clientHealth = new int[clientSet.size()];
    String[] clientID = new String[clientSet.size()];
   
    // Provided the incoming message was not lost, draw the client
    if(incomingMessage!=null){
      
      // Split the message into the components array
      components = incomingMessage.split(",");
      clientX[0] = float(components[0]);
      clientY[0] = float(components[1]);
      clientHealth[0] = int(components[2]);
      nwgs.player2Health = int(components[2]);
      Thetas[0] = float(components[3]);
      clientID[0] = trim(components[4]);
      
      // Draw the client
      pushMatrix();
      translate(float(components[0])-15, float(components[1])-15);
      println(float(components[3]));
      rotate(radians(float(components[3])));
      image(tankSprite, -15, -15);
      popMatrix();
    }
    
    // Prepare the string to send to the client
    // Sends the xPos, yPos, health, rotation and ID
    String toSend = str(nwgs.player.x)+","+str(nwgs.player.y)+","+str(nwgs.player.health)+","+str(nwgs.player.rotation)+","+str(nwgs.bulPlayer.bX)+","+"0"+"\n";
    Host.server.write(toSend); 
  }
}