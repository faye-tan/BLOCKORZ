//Class Button

//Description:
// - This button class creates rectangular buttons, given an x, y, width, and height
// - When the mouse hovers over them an orange rectangular frame will be seen, and they can be clicked 

//---------------------------------------------------------------------------------------------------------------------------------------------

class Button {
  //Data
  int x, y, tall, wide, nextState; 


  //Constructor
  Button(int _x, int _y, int _wide, int _tall, int _nextState) {
    x = _x;
    y = _y;
    tall = _tall;
    wide = _wide;
    nextState = _nextState;
  }

  //Behaviour:
  // - When the mouse's coordinates are within the rectangle, a frame will appear
  void display() {
    if ((x < mouseX) && (mouseX < (x+wide))) {
      if ((y < mouseY) && ( mouseY < (y+tall))) {

        noFill();
        strokeWeight(4);
        stroke(255, 135, 5);
        rect(x, y, wide, tall);
      }
    }
  }

  //Once it has been clicked, the buttons lead to different states or levels
  void interact() {
    if (((x < mouseX) && (mouseX < (x+wide))) && ((y < mouseY) && ( mouseY < y+tall))) {
      if (mousePressed) {
        if (state == 0) {
          state = nextState;
        }
        if (state == 1) {
        }
        if (state == 2) {
          state = nextState;
        }
        if (state == 3) {
          if (level == 5) {
            state = 5;
          } else {
            load();
            state = nextState;
          }
        }
        if (state == 4) {
          load();
          state = nextState;
          load();
        }
        if (state == 5) {
          state = nextState;
        }
      }
    }
  }
}