class user {
  Client client;
  int x, y, health, rotation, oX, oY;
  String[] components;
  String[] clients;
  int clientID = 2;
  PImage[] tankSprite;
  String data;
  
  user(PApplet sketch) {
    x = width - Tile.spriteHeight;
    oX = x/Tile.spriteHeight - 1;
    y = height-Tile.spriteHeight;
    oY = y/Tile.spriteHeight - 1;
    rotation = 0;
    
    tankSprite = new PImage[2];
    tankSprite[0] = loadImage("assets/tanks/tank2.png");
    tankSprite[1] = loadImage("assets/tanks/tank1.png");
    
    client = new Client(sketch, "127.0.0.1", 5204);
    components = new String[3];
    components[0] = str(2*Tile.spriteHeight);
    components[1] = str(2*Tile.spriteHeight);
    components[2] = str(180);
  }
  
  void draw() {
    pushMatrix();
    translate(x-15, y-15);
    rotate(radians(rotation));
    image(tankSprite[0], -15, -15);
    popMatrix();
    
    if(data!=null) {
      clients = data.split(";");
    }
  
    for(int i=0; i< clients.length; i++) {
      components = clients[i].split(",");
    
      if(components.length > 3){
        if(!components[3].equals(str(clientID))) {
          pushMatrix();
          translate(float(components[0]), float(components[1]));
          rotate(radians(float(components[2])));
          image(tankSprite[1+i], -15, -15);
          popMatrix();
         }
       }
    } 
    client.write(x+","+y+","+rotation+","+clientID+"\n");
  }
  
  // Let's look at this with the client event callback function
  void clientEvent(Client client) {
    data = (client.readStringUntil('\n'));
  }
}