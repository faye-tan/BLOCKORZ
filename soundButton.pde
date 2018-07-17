//Class soundButton

//Description:
// - This class is an extension of Button and inherits from it
// - What it inherits is the behaviour (display)
// - What is unique is that it is clicked to turn on/off the sound instead of moving from one state/level to another

//---------------------------------------------------------------------------------------------------------------------------------------------

class soundButton extends Button {
  //Data
  boolean on;

  //Constructor
  soundButton(int _x, int _y, int _wide, int _tall) {
    super(_x, _y, _wide, _tall, -1); 
    on = true;
  }

  //Behaviour:
  // - Turns off/on the theme music
  void mousePressed() {
    if (((x < mouseX) && (mouseX < (x+wide))) && ((y < mouseY) && ( mouseY < y+tall))) {
      on = !on;
      if (on == true) {
        song.play();
      } else {
        song.pause();
      }
    }
  }
  
  void volume() {
    audiobutton.resize(wide, tall);
    image(audiobutton, x, y);
  }
}