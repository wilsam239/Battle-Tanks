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
 Version 1.8
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
 Bullets
 Header in game
 Game Over Screen
 ------------------------------------------
*/
 
 
 /********* VARIABLES *********/

/* We control which screen is active by setting / updating
   screen variable. We display the correct screen according
   to the value of this variable.
  
        0: Main Menu
        1: Local Multiplayer
        2: Map Selector
        3: Network Lobby
        4: Network Game
        
*/

int screen = 0;
localGame gs;
networkGame nwgs;
mainMenu menu;
mapSelect mapSelector;
host Host;
user User;
lobby Lobby;
boolean local;


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
        0: Main Menu
        1: Local Multiplayer
        2: Map Selector
        3: Network Lobby
        4: Network Game
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

/* 
  The following functions are called whenever a serverEvent or clientEvent
  happens. When they are called a client is added to an arraylist for the
  server. And data is read by the client.
  
  This was based off of the in class lecture code.

*/
public void serverEvent(Server server, Client client) {
  Lobby.connectionMade = true;
  Host.clientSet.add(client);
}
// Let's look at this with the client event callback function
public void clientEvent(Client client) {
  Lobby.connectionMade = true;
  User.data = (client.readStringUntil('\n'));
}