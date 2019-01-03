//Jingfei Tan
//June 16, 2018

//Description:
// - Welcome to Blockorz!
// - The objective of the game is to use the left/right/up/down keys to move the 2x1 block to get to the green tile
// - The white tiles are safe, and you can stand on them
// - The black tiles are deadly, and if even part of the block lands on it, you will die!

//---------------------------------------------------------------------------------------------------------------------------------------------

//Importing Library: 
import ddf.minim.*;

//Data:
Minim minim;
AudioPlayer song, winSound, dieSound;
Block bugatti;
Button startButton, instructionButton, nextButton, homeButton, levelsButton, redo;
soundButton solange; 
PImage title, start, next, instructions, win, death, menu, tryAgain, goodjob, example, screencap, audiobutton;
StringList inventoryDie, inventoryWin;
String[] lines;
int tilesLength, tilesWidth;
int tilesW, tilesH;
int _i, _j;
int state;
boolean blockState;
int level;
boolean levelSwitch;
float adjust;


//Setup: Assigning variables to their values
void setup() {
  size(600, 600);
  background(0);

  //Misc Variables:
  state = 0; 
  level = 0; 
  loadLevel();
  inventoryDie = new StringList();
  inventoryWin = new StringList();
  tilesLength = lines.length; //15
  tilesWidth = lines[0].length(); //15
  tilesW = width/tilesWidth; //40
  tilesH = height/tilesLength; //40
  levelSwitch = false;
  blockState = false;
  adjust = 0;

  //Sound: 
  minim = new Minim(this);
  winSound = minim.loadFile("data/win.mp3");
  dieSound = minim.loadFile("data/lose.mp3");
  //apunk.mp3 from https://www.youtube.com/watch?v=4CnCprRsJLs 
  song = minim.loadFile("data/apunk.mp3");
  song.play();
  song.loop();

  //Images: 
  audiobutton = loadImage("data/audiobutton.png");
  example = loadImage("data/example.png");
  screencap = loadImage("data/deadscreencap.png");
  goodjob = loadImage("data/goodjob.png");
  menu = loadImage("data/menu.png");
  tryAgain = loadImage("data/tryAgain.png");
  death = loadImage("data/youdead.png");
  win = loadImage("data/levelPassed.png");
  next = loadImage("data/next.png");
  instructions = loadImage("data/instructions.png");
  start = loadImage("data/start.png");
  title = loadImage ("data/blockorzTitle.png");

  //Calling constructors: 
  solange = new soundButton (540, 20, 40, 40);
  instructionButton = new Button (113, 250, 375, 60, 2);
  startButton = new Button (150, 400, 300, 60, 1);
  nextButton = new Button (475, 500, 100, 60, 1);
  homeButton = new Button (75, 500, 150, 50, 0);
  redo = new Button(375, 500, 150, 50, 1);
  loadBugatti();
}

// loadBugatti() calls the constructor for the 2x1 block
//The block, 'bugatti' is loaded into a different place each time, depending on the level
void loadBugatti() {
  if (level == 0) {
    bugatti = new Block(7, 4);
  }
  if (level == 1) {
    bugatti = new Block(6, 3);
  }
  if (level == 2) { 
    bugatti = new Block(7, 8);
  } 
  if (level == 3) {
    bugatti = new Block(7, 2);
  }
  if (level == 4) {
    bugatti = new Block(5, 0);
  }
  if (level == 5) {
    bugatti = new Block(7, 9);
  }
}

//Draw: 
//Kept fairy simple/neat, it's main function is to check the state, then call functions accordingly
void draw() {
  if (state == 0) {    //Start Screen
    load();
    startScreen();
  }  
  if (state == 1) {    //Play the Game
    displayBoard();
    bugatti.update(inventoryWin, inventoryDie);
    bugatti.display();
  }
  if (state == 2) {    //Instructions Screen
    instructionScreen();
  } 
  if (state == 3) {    //Passed the Level Screen
    winScreen(); 
    loadLevel();
  } 
  if (state == 4) {    //Death Screen
    deathScreen();
  }
  if (state == 5) {    //Final Win Screen
    finalScreen();
  }
  solange.display();
  solange.volume();
}

//Start Screen:
//Contains a button for instructions, and playing the game
void startScreen() {
  background(0);
  title.resize(500, 80);
  image(title, 50, 75);
  instructions.resize(375, 60);
  image(instructions, 112.5, 250);
  start.resize(300, 60);
  image(start, 150, 400);
  level = 0;
  startButton.display();
  startButton.interact();
  instructionButton.display();
  instructionButton.interact();
  loadBugatti();
}

//Instructions Screen:
//Contains a menu button and words/pictures to aid instruction
void instructionScreen() {
  background(0);
  instructions.resize(500, 80);
  image(instructions, 50, 75);
  example.resize(200, 100);
  screencap.resize(200, 160);
  image(example, 375, 225);
  image(screencap, 375, 400);
  textAlign(LEFT);
  fill(255, 135, 5);
  textSize(20);
  text("To play, use the up, down, left, and right arrows,", 40, 200);
  text("to move the 2x1 block.", 40, 230);
  text("Your goal is the green tile.", 40, 300);
  text("If you land on a black tile, you will die!", 40, 375);
  menu.resize(150, 50);
  image(menu, 75, 500);
  homeButton.display();
  homeButton.interact();
}

//Win Screen:
//Appears when you pass a level
//Contains a next button to proceed to the next level
void winScreen() {
  next.resize(100, 60);
  image(next, 475, 500);
  nextButton.display();
  nextButton.interact();
  win.resize(450, 75);
  image(win, 75, 50);
}

//Death Screen:
//Contains a menu button to return to menu and a try again button
void deathScreen() {
  death.resize(450, 75);
  image(death, 75, 50);
  menu.resize(150, 50);
  image(menu, 75, 500);
  homeButton.display();
  homeButton.interact();
  tryAgain.resize(150, 50);
  image(tryAgain, 375, 500);
  redo.display();
  redo.interact();
}

//Final Screen:
//Offer of congratulations, and a menu button
void finalScreen() {
  goodjob.resize(500, 80);
  image(goodjob, 50, 75);
  menu.resize(150, 50);
  image(menu, 75, 500);
  homeButton.display();
  homeButton.interact();
  fill(255, 135, 5);
  textAlign(CENTER);
  textSize(30);
  text("You have completed all the levels!", 300, 415);
  text("Thank you for playing!", 300, 450);
}

//This function loads the level from .txt files
void loadLevel() {
  lines = loadStrings("data/" + str(level) + ".txt");
}

//This function reads the .txt file and draws the grid/board
void displayBoard() {
  background(30);
  strokeWeight(1);
  stroke(0);
  for (int i = 0; i < tilesWidth; i++) {
    for (int j = 0; j < tilesLength; j++) {
      if (j%2 == 1) {
        if (level != 3) {
          adjust = 20;
        } else {
          adjust = 40;
        }
      } else {
        if (level != 3) {
          adjust = 0;
        } else {
          adjust = 20;
        }
      }
      char tileType = lines[j].charAt(i);
      if (tileType == '.') { //White 'live' sqaures 
        fill(255);
      } 
      if (tileType == 'E') { //End Square, the object is to get here
        fill(0, 255, 0);
        String addWin = (str(int(i*tilesW-adjust)) + str(int(float(j*tilesH)*0.7+84)));
        inventoryWin.append(addWin);
      }
      if (tileType == 'B') {// Black 'death' square. Avoid. 
        fill(30);
        String addDie = (str(int(i*tilesW-adjust)) + str(int(float(j*tilesH)*0.7+84)));
        inventoryDie.append(addDie);
      }

      float x1 = float(i*tilesW);
      float x2 = float(i*tilesW+tilesW);
      float x3 = float(i*tilesW+tilesW+20);
      float x4 = float(i*tilesW+20); 
      float y1 = float(j*tilesH)*0.7;
      float y2 = float(j*tilesH+tilesH)*0.7;
      
      //To give the game a 3D quality, parallelograms are used to decieve perception
      quad(x1-adjust, y1+84, x2-adjust, y1+84, x3-adjust, y2+84, x4-adjust, y2+84);
    }
  }
}

//This function calls the next level
void nextLevel() {
  if (state == 1) {
    if (levelSwitch == true) {
      if (level == 0) {
        level = 1;
        load();
      } else if (level == 1) {
        level = 2;
        load();
      } else if (level == 2) {
        level = 3;
        load();
      } else if (level == 3) {
        level = 4;
        load();
      } else if (level == 4) {
        level = 5;
        load();
      } else if (level == 5) {
        state = 4;
      }
    }
  }
}

//This function loads/clears everything after a level has passed
//It loads the next level, the next block, and clears the coordinates for the win tiles and death tiles
void load() {
  loadLevel();
  loadBugatti();
  inventoryDie.clear();
  inventoryWin.clear();
}

//Prompts the soundButton's interactivity
void mousePressed() {
  solange.mousePressed();
}

//Prompts the block's interactivity
void keyPressed() {
  bugatti.keyPressed();
}