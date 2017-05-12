/* 
      Function:
        user class
      Author:
        Sam.
      Description:
        This class is used to manage the user's game when playing using
        network multiplayer mode. It creates a client and writes data
        to the connected server.
*/

class user {
  
  
  Client client;
  String[] components;
  int clientID;
  PImage tankSprite;
  String data;
  
  user(PApplet sketch) {

    tankSprite = loadImage("assets/tanks/tank2.png");
    
    client = new Client(sketch, "127.0.0.1", 5204);
    components = new String[5];
    clientID = 2;
  }
  
  void draw() {
    
    if(data!=null) {
        components = data.split(",");
        nwgs.player2Health = int(components[2]);
        pushMatrix();
        translate(float(components[0])-15, float(components[1])-15);
        rotate(radians(float(components[3])));
        image(tankSprite, -15, -15);
        popMatrix();
     }
    
    String msg = (nwgs.player.x+","+nwgs.player.y+","+nwgs.player.health+","+nwgs.player.rotation+","+clientID+"\n");
    //println(components);
    //println(msg);
    //println(nwgs.player.x+","+nwgs.player.y+","+nwgs.player.rotation+","+clientID);
    client.write(msg);
  }
  
}