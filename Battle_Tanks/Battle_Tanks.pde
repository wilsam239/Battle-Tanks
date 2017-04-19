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

int gameState = 0;
Manager manager;
void setup() {
  size(500,500);
}

void draw() {
  if (gameState == 0) {
    manager.mainMenu();
  } else if (gameState == 1) {
    manager.gameScreen();
  } else if (gameState == 2) {
    manager.lobby();
  } else if (gameState == 3) {
    manager.gameOver();
  }
}