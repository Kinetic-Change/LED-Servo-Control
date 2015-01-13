import processing.serial.*; // imports a lib that allows us to talk to Arduino via Serial

PImage colorWheel; // Variable to store our Background image
Serial myPort; // Object to handle Serial communication
PFont schrift; // Variable to store our Font
String colorString;

void setup() { // executed once on startup, prepares everything for runtime
  size(400, 400); // size of the window
  schrift=loadFont("Garamond-Italic-48.vlw"); // loading a front
  textFont(schrift, 48); // saying that we actually want to use that font 
  colorWheel=loadImage("colorwheel.png"); // loading our background image
  //colorWheel=loadImage("no.png");
  
  println(Serial.list()); // listing all attached serial devices
  myPort = new Serial(this, Serial.list()[0], 115200); // start communicating with Arduino
}

void draw() {
  // get the color of the mouse position's pixel:
  image(colorWheel, 0, 0); // shwow our beautiful image
  color targetColor = get(mouseX, mouseY); // pipetting out of that image, exacltly at the mouse Cursor's tip

  // get the component values:
  int r = int(red(targetColor)); // extracting the colors red channel
  int g = int(green(targetColor)); // extracting the colors green channel
  int b = int(blue(targetColor)); // extracting the colors blue channel  

  // make a comma-separated string:
  colorString = r + "," + g + "," + b + "\n"; // assembling a nice string ready to be send to Arduino

 
  fill(255);  // switching tp a white fill for text
  text(colorString,50,height-50);  // showing what arduino actually thinks :)
}

void mouseMoved(){  
  // send it out the serial port:
  myPort.write(colorString);
}

