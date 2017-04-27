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
 Everything
 ------------------------------------------
*/
 
 
 /********* VARIABLES *********/

// We control which screen is active by settings / updating
// gameState variable. We display the correct screen according
// to the value of this variable.
//
// 0: Initial Screen
// 1: Game Screen
// 2: Multiplayer Lobby
// 3: Game-Over Screen

int screen = 1;
gameState gs;
//mainMenu menu;
//lobby l;
//gameOver rip;


void setup() {
  size(600,600);
  gs = new gameState();
  //menu = new mainMenu();
  //l = new lobby();
  //rip = new gameOver();
}

void draw() {
  if (screen == 0) {
    //menu.draw();
  } else if (screen == 1) {
    gs.draw();
  } else if (screen == 2) {
    //l.draw();
  } else if (screen == 3) {
    //rip.draw();
  }
}