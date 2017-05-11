import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import java.io.File;
import processing.net.*;

/*
 # Group 14 Battle Tanks #
 ---------------------------------------
 Version 1.0
 ------------------------------------------
 Authors: 
     Sam Williamson
     Nathan Hall
     Neil Wilcox
     Ben Hanssens
 ------------------------------------------
 Purpose: 
        "To work in your teams to develop 
 your own version of the Battle Tanks game 
 using the Processing environment.
 ------------------------------------------
 How To Run:
        Simply click the "Run" button above
 to compile the game, it will open in a
 large window.
 ------------------------------------------
 Controls:
       
 ------------------------------------------
 # TODO #
 Multiplayer
 Bullets
 Menus
 Control schemes
 ------------------------------------------
*/
 
 
 /********* VARIABLES *********/

// We control which screen is active by setting / updating
// gameState variable. We display the correct screen according
// to the value of this variable.
//
// 0: Initial Screen
// 1: Local Multiplayer Screen
// 2: Multiplayer Lobby
// 3: Game-Over Screen

int screen = 0;
localGame gs;
networkGame nwgs;
mainMenu menu;
mapSelect mapSelector;
host Host;
user User;
lobby Lobby;
boolean local;
//lobby l;
//gameOver rip;


void setup() {
  // Create a window of size 600x600
  size(900,600);
  surface.setTitle("Group 14 Battle Tanks");
  // initialise classes
  gs = new localGame();
  menu = new mainMenu();
  mapSelector = new mapSelect();
  Lobby = new lobby(this);
}

void draw() {
  /* 
      Function:
        Draw function
      Author:
        Sam.
      Description:
        Calls the draw fucntion of other classes based on the screen variable.
        0: Initial Screen
        1: Game Screen
        2: Map Selector
        3: Game-Over Screen
  */
    
  // See the ehader comment above for each screens value
  if (screen == 0) {
    menu.draw();
  } else if (screen == 1) {
    gs.draw();
  } else if (screen == 2) {
    if (local) mapSelector.draw(gs);
    else mapSelector.draw(nwgs);
  } else if (screen == 3) {
    Lobby.draw();
  } else if (screen == 4) {
    nwgs.draw();
  }
}

void keyPressed() {
  /* 
      Function:
        keyPressed function
      Author:
        Ben.
      Description:
        Passes the key pressed through to the game state, so it can keep track of
        when multiple keys are being pressed at the same time.
  */
  if (screen ==1) gs.updateKeys(key, true);
  else if (screen == 4) nwgs.updateKeys(key, true);
}

void keyReleased() {
  /* 
      Function:
        keyReleased function
      Author:
        Ben.
      Description:
        Passes the key released through to the game state, so it can keep track of
        when multiple keys are being pressed at the same time.
  */
  if (screen ==1) gs.updateKeys(key, false);
  else if (screen == 4) nwgs.updateKeys(key, false);
}

public void serverEvent(Server server, Client client) {
  println("A new client has connected: " + client.ip());
  Lobby.connectionMade = true;
  Host.clientSet.add(client);
}
// Let's look at this with the client event callback function
public void clientEvent(Client client) {
  Lobby.connectionMade = true;
  User.data = (client.readStringUntil('\n'));
}