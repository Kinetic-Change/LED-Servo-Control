import processing.serial.*; // imports a lib that allows us to talk to Arduino via Serial

PImage colorWheel; // Variable to store our Background image
String colorString;
Serial myPort; // Object to handle Serial communication
PFont schrift; // Variable to store our Font
String back= " "; // Variable to store backtalk from Arduino

void setup() { // executed once on startup, prepares everything for runtime
  size(400, 400); // size of the window
  schrift=loadFont("Garamond-Italic-32.vlw"); // loading a font
  textFont(schrift, 32); // saying that we actually want to use that font 
  colorWheel=loadImage("colorwheel.png"); // loading our background image  
  
  println(Serial.list()); // listing all attached serail devices
  myPort = new Serial(this, Serial.list()[0], 11500); // start communicating with Arduino
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
  colorString = r + "," + g + "," + b + "\n"; // assembling a nice string ready to be sent to Arduino  
  // send it out the serial port:
  //myPort.write(colorString);    
  fill(#ffffff);  // switching to a fill for text
  text(back+colorString,50,height-60);  // showing what arduino actually thinks :)

}

void mouseMoved(){
  myPort.write(colorString);
}

void serialEvent(Serial p) {  
  String message = myPort.readStringUntil(13); // get message till line mbreak (ASCII > 13)
  int message = myPort.readByte(2)
  println("received message from serial : " + message);

  if(message != null){
    back=message;
  }
}

