class user {
  Client client;
  String[] components;
  String[] clients;
  int clientID = 2;
  PImage tankSprite;
  String data;
  
  user(PApplet sketch) {
    //tankSprite = new PImage[2];
    tankSprite = loadImage("assets/tanks/tank2.png");
    
    client = new Client(sketch, "127.0.0.1", 5204);
    // X - Y - rotation - health -id
    components = new String[5];
    clients = new String[2];
    components[0] = str(2*Tile.spriteHeight);
    components[1] = str(2*Tile.spriteHeight);
    components[2] = str(180);
    components[3] = str(100);
    components[4] = str(clientID);
    
  }
  
  void draw() {
    //pushMatrix();
    //translate(x-15, y-15);
    //rotate(radians(rotation));
    //image(tankSprite, -15, -15);
    //popMatrix();
    
    if(data!=null) {
      clients = data.split(";");
      for(int i=0; i < clients.length; i++) {
        components = clients[i].split(",");
        if(components.length > 3) {
          if(!components[4].equals(str(clientID))) {
            pushMatrix();
            translate(float(components[0]) - 15, float(components[1]) - 15);
            rotate(radians(float(components[2])));
            image(tankSprite, -15, -15);
            popMatrix();
          }
        }
      }
    }   
  } 
}