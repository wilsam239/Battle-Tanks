class user {
  Client client;
  int x, y, health, rotation, oX, oY;
  String[] components;
  String[] clients;
  int clientID;
  PImage tankSprite;
  String data;
  
  user(PApplet sketch) {

    tankSprite = loadImage("assets/tanks/tank2.png");
    
    client = new Client(sketch, "127.0.0.1", 5204);
    clients = new String[2];
    components = new String[5];
    clientID = 2;
  }
  
  void draw() {
    
    if(data!=null) {
      clients = data.split(";");
      for(int i=0; i < clients.length-1; i++) {
        //println(clients.length);
        //println(clients[i]);
        components = clients[i].split(",");
      
        if(components.length > 3){
          if(!components[3].equals(str(clientID))) {
            pushMatrix();
            translate(float(components[0])-15, float(components[1])-15);
            rotate(radians(float(components[3])));
            image(tankSprite, -15, -15);
            popMatrix();
          }
        }
      } 
    }
    
    String msg = (nwgs.player.x+","+nwgs.player.y+","+nwgs.player.health+","+nwgs.player.rotation+","+clientID+"\n");
    //println(components);
    println(msg);
    //println(nwgs.player.x+","+nwgs.player.y+","+nwgs.player.rotation+","+clientID);
    client.write(msg);
  }
  
}