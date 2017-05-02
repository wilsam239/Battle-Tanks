import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

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
// 1: Game Screen
// 2: Multiplayer Lobby
// 3: Game-Over Screen

int screen = 0;
gameState gs;
mainMenu menu;
//lobby l;
//gameOver rip;


void setup() {
  // Create a window of size 600x600
  size(900,600);
  surface.setTitle("Group 14 Battle Tanks");
  // initialise classes
  gs = new gameState();
  menu = new mainMenu();
  //l = new lobby();
  //rip = new gameOver();
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
        2: Multiplayer Lobby
        3: Game-Over Screen
  */
    
  // See the ehader comment above for each screens vaslue
  if (screen == 0) {
    menu.draw();
  } else if (screen == 1) {
    gs.draw();
  } else if (screen == 2) {
    //l.draw();
  } else if (screen == 3) {
    //rip.draw();
  }
}