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
mainMenu menu;
mapSelect mapSelector;
//lobby l;
//gameOver rip;
boolean[] keys; // Tracks which keys are currently being pressed.


void setup() {
  // Create a window of size 600x600
  size(900,600);
  surface.setTitle("Group 14 Battle Tanks");
  // initialise classes
  gs = new localGame();
  menu = new mainMenu();
  mapSelector = new mapSelect();
  //rip = new gameOver();
  
  keys = new boolean[10];
  keys[0] = false;
  keys[1] = false;
  keys[2] = false;
  keys[3] = false;
  keys[4] = false;
  keys[5] = false;
  keys[6] = false;
  keys[7] = false;
  keys[8] = false;
  keys[9] = false;
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
    mapSelector.draw(gs);
  } else if (screen == 3) {
    //rip.draw();
  }
}

void keyPressed() {
  /* 
      Function:
        keyPressed function
      Author:
        Ben.
      Description:
        Keeps track of which key has been pressed, updating the keys array accordingly.
        Together with keyReleased(), it keeps track of which keys are currently held
        down, allowing both tanks to move at once.
  */
  if (key == 'W' || key == 'w') keys[0] = true;
  if (key == 'A' || key == 'a') keys[1] = true;
  if (key == 'S' || key == 's') keys[2] = true;
  if (key == 'D' || key == 'd') keys[3] = true;
  if (key == 'F' || key == 'f') keys[4] = true;
  if (key == 'I' || key == 'i') keys[5] = true;
  if (key == 'J' || key == 'j') keys[6] = true;
  if (key == 'K' || key == 'k') keys[7] = true;
  if (key == 'L' || key == 'l') keys[8] = true;
  if (key == ':' || key == ';') keys[9] = true;
}

void keyReleased() {
  /* 
      Function:
        keyReleased function
      Author:
        Ben.
      Description:
        Keeps track of which key has been released, updating the keys array accordingly.
        Together with keyPressed(), it keeps track of which keys are currently held
        down, allowing both tanks to move at once.
  */
  if (key == 'W' || key == 'w') keys[0] = false;
  if (key == 'A' || key == 'a') keys[1] = false;
  if (key == 'S' || key == 's') keys[2] = false;
  if (key == 'D' || key == 'd') keys[3] = false;
  if (key == 'F' || key == 'f') keys[4] = false;
  if (key == 'I' || key == 'i') keys[5] = false;
  if (key == 'J' || key == 'j') keys[6] = false;
  if (key == 'K' || key == 'k') keys[7] = false;
  if (key == 'L' || key == 'l') keys[8] = false;
  if (key == ':' || key == ';') keys[9] = false;
}
