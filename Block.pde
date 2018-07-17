//Class Block

//Description: 
// - This class holds the 2-by-1 block that moves around on the board
// - It also detects whether it is on a 'live' sqaure, 'death' sqaure, or the 'end' square
// - The method of the block's movement follows: Ther are constantly 2 squares, when the block is vertical, 
//   the squares are on top of each other. When the block is vertcal of horizontal, they fan out

//---------------------------------------------------------------------------------------------------------------------------------------------

class Block {
  //Data
  float x1, x2, y1, y2, adjustY1, adjustX1, adjustX2, adjustY2;
  int covering;
  int counter, columns, rows;

  //Constructor
  Block(int _x, int _y) {
    x1 = _x;
    x2 = _x;
    y1 = _y;
    y2 = _y;
    counter = 0;
    covering = 1;
    if ((level != 3) && (level != 4)) {
      y1 = y1*40;
      y2 = y2*40;
    } else {
      y1 = y1*40-20;
      y2 = y2*40-20;
    }
    if (level == 4) {
      x1 = x1*40+12;
      x2 = x2*40+12;
    } else {
      x1 *= 40;
      x2 *= 40;
    }

    if ((x1/40)%2 == 1) { 
      x1 -= 12; 
      x2 -= 12; 
      y1 -= 20;
      y2 -= 20;
    }
    adjustX1 = 0;
    adjustY1 = 0;
    adjustX2 = 0;
    adjustY2 = 0;
  }

  //Behaviour
  void display() {
    fill(255, 135, 5, 30);
    trapezoid(y1, x1);
    trapezoid(y2, x2);
  }

  //This trapezoid function uses the quad() function to create a paralellogram, creating the 3D effect
  void trapezoid(float y1, float x1) {
    stroke(0);
    quad(y1+adjustY1, x1+12+adjustX1, y1+40+adjustY1, x1+12+adjustX1, y1+60+adjustY1, x1+40+adjustX1, y1+20+adjustY1, x1+40+adjustX1);
    quad(y2+adjustY2, x2+12+adjustX2, y2+40+adjustY2, x2+12+adjustX2, y2+60+adjustY2, x2+40+adjustX2, y2+20+adjustY2, x2+40+adjustX2);
    strokeWeight(2.5);
    stroke(255, 135, 5);
    noFill();
    //This function uses the coordinates of the occupied paralellogram and constructs lines to create the effect of a 3D block
    //There are two methods, because a vertical block will require lines higher on the y axis 
    if (covering == 1) {
      rect(y1+adjustY1, x1+12+adjustX1-80, 40, 40);
      rect(y2+20+adjustY2, x2+40+adjustX2-80, 40, 40);
      line(y1+adjustY1, x1+12+adjustX1-80, y1+20+adjustY2, x1+40+adjustX2-80);
      line(y1+adjustY1+40, x1+12+adjustX1-80, y1+20+adjustY2+40, x1+40+adjustX2-80);
    }
    rect(y1+adjustY1, x1+12+adjustX1-40, 40, 40);
    rect(y1+20+adjustY2, x1+40+adjustX2-40, 40, 40);
    line(y1+adjustY1, x1+12+adjustX1-40, y1+20+adjustY2, x1+40+adjustX2-40);
    line(y1+adjustY1+40, x1+12+adjustX1-40, y1+20+adjustY2+40, x1+40+adjustX2-40);
    line(y1+adjustY1, x1+12+adjustX1, y1+20+adjustY2, x1+40+adjustX2);
    line(y1+adjustY1+40, x1+12+adjustX1, y1+20+adjustY2+40, x1+40+adjustX2);
  }

  //The purpose of update is to check whether the block is on a death sqaure, or if it has successfully reached the green end square
  void update(StringList _inventoryWin, StringList _inventoryDie) {
    inventoryWin = _inventoryWin; //A StringList that keeps the coordinates for the end sqaure
    inventoryDie = _inventoryDie; //A StringList that keeps the coordinates for the death squares 
    String x1y1 = str(int(y1+adjustY1)) + str(int(x1+12+adjustX1));
    String x2y2 = str(int(y2+adjustY2)) + str(int(x2+12+adjustX2));

    //Detection for the death and end sqaures
    //The green end sqaure is always a single square, which means covering must equal 1, meaning it's occupying one sqaure
    if (covering == 1) {
      if ((inventoryWin.hasValue(x1y1)) || (inventoryWin.hasValue(x2y2))) {
        winSound.play();
        winSound.rewind();
        if (level != 5) {
          levelSwitch = true;
          nextLevel();
          state = 3;
        } else {
          state = 5;
        }
      }
    } 
    if ((inventoryDie.hasValue(x1y1)) || (inventoryDie.hasValue(x2y2))) {
      state = 4;
      dieSound.play();
      dieSound.rewind();
    }
  }

  //This keyPressed function calls the moving functions of the block and flips the fill colours
  void keyPressed() {
    if (keyCode == UP) {
      flipUp();
    } 
    if (keyCode == DOWN) {
      flipDown();
    } 
    if (keyCode == LEFT) {
      flipLeft();
    } 
    if (keyCode == RIGHT) {
      flipRight();
    }
  }

  //Flips the block up
  void flipUp() {
    if (covering == 1) { //If the block is currently occupying 1 square
      if (x1>x2) {
        x1 -= 56;
        x2 -= 28;
        y1 -= 40;
        y2 -= 20;
      } else {
        x1 -= 28;
        x2 -= 56;
        y1 -= 20;
        y2 -= 40;
      }
      covering = 3;
    } else {
      if (covering == 2) { //If the block is occupying 2 sqaures and is horizontal
        x1 -= 28;
        x2 -= 28;
        y1 -= 20;
        y2 -= 20;
      }
      if (covering == 3) { //If the block is occupying 2 sqaures and is vertical
        if (x1>x2) {
          x1 -= 56;
          x2 -= 28;
          y1 -= 40;
          y2 -= 20;
        } else {
          x1 -= 28;
          x2 -= 56;
          y1 -= 20;
          y2 -= 40;
        }
        covering = 1;
      }
    }
  }


  //Flips the block down
  void flipDown() {
    if (covering == 1) { //If the block is currently occupying 1 square
      x1 += 56;
      x2 += 28;
      y1 += 40;
      y2 += 20;
      covering = 3;
    } else {
      if (covering == 2) { //If the block is occupying 2 sqaures and is horizontal
        x1 += 28;
        x2 += 28;
        y1 += 20;
        y2 += 20;
      }
      if (covering == 3) { //If the block is occupying 2 sqaures and is vertical
        x1+= 28;
        x2+= 56;
        y1 += 20;
        y2 += 40;
        covering = 1;
      }
    }
  }

  //Flips the block left
  void flipLeft() {
    adjustX1 = 0;
    adjustY1 = 0;
    adjustX2 = 0;
    adjustY2 = 0;
    if (covering == 1) { //If the block is currently occupying 1 square
      y2 -= 40;
      y1 -= 80;
      covering = 2;
    } else {
      if (covering == 2) { //If the block is occupying 2 sqaures and is horizontal
        y1 -= 40;
        y2 -= 80;
        covering = 1;
      }
      if (covering == 3) { //If the block is occupying 2 sqaures and is vertical
        y1 -= 40;
        y2 -= 40;
      }
    }
  }

  //Flips the block right
  void flipRight() {
    adjustX1 = 0;
    adjustY1 = 0;
    adjustX2 = 0;
    adjustY2 = 0;
    if (covering == 1) { //If the block is currently occupying 1 square
      y1+= 40;
      y2 += 80;
      covering = 2;
    } else {
      if (covering == 2) { //If the block is occupying 2 sqaures and is horizontal
        y1 += 80;
        y2 += 40;
        covering = 1;
      }
      if (covering == 3) { //If the block is occupying 2 sqaures and is vertical
        y1 += 40;
        y2 += 40;
      }
    }
  }
}