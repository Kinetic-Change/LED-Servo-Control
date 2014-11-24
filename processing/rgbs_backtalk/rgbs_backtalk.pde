
import processing.serial.*; // imports a lib that allows us to talkj to Arduino via Serial

PImage colorWheel; // Variable to store our Background image
Serial myPort; // Object to handle Serial communication
PFont schrift; // Variable to store our Font
String back=" "; // Variable to store backtalk from Arduino

void setup() { // executed once on startup, prepares everything for runtime
  size(400, 400); // size of the window
  schrift=loadFont("Garamond-Italic-32.vlw"); // loadig a front
  textFont(schrift, 32); // saying tht we actually want to use that font 
  colorWheel=loadImage("colorwheel.png"); // loading our background image
  //colorWheel=loadImage("IttenHipsterSht.png");
  
  println(Serial.list()); // listing all attached serail devices
  myPort = new Serial(this, Serial.list()[7], 115200); // start communicating with Arduino
}


void draw() {
  // get the color of the mouse position's pixel:
  image(colorWheel, 0, 0); // shwow our beautiful image
  color targetColor = get(mouseX, mouseY); // pipetting out of that image, exacltly at the mouse Cursor's tip

  // get the component values:
  int r = int(red(targetColor)); // extracting the colors red channel
  int g = int(green(targetColor)); // extracting the colors green channel
  int b = int(blue(targetColor)); // extracting the colors blue channel

  int s = int(map(mouseX,0,width,0,180)); // driving the servo where mouse to the left means a low rotation and to the right means 180° turned

  // make a comma-separated string:
  String colorString = r + "," + g + "," + b + "," + s + "\n"; // assembling a nice string ready to be send to Arduino

  // send it out the serial port:
  myPort.write(colorString );
  
  fill(#ffffff);  // switching to a  fill for text
  text(back,50,height-60);  // ashwing waht arduino actually thinks :)

}

void serialEvent(Serial p) {
  // get message till line break (ASCII > 13)
  String message = myPort.readStringUntil(13);
  if(message != null){
    back=message;
  }
}

