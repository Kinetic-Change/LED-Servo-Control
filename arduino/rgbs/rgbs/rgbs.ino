#include <Adafruit_NeoPixel.h>

#define PIN 6

String inString = "";    // string to hold input
int currentColor = 0;   // which color is being read right now
int red, green, blue = 0; // vatiables to store the values for each color and the servo

Adafruit_NeoPixel strip = Adafruit_NeoPixel(72, PIN, NEO_GRB + NEO_KHZ800);

void setup() { // executed once on reboot of the Arduino
  // Open serial communications and wait for port to open:
  Serial.begin(115200); // begin talking to the computer at very high speed :)
  while (!Serial) {
    ; // wait for serial port to connect. Needed for Leonardo only
  }

  strip.begin();
  strip.show(); // Initialize all pixels to 'off'  
}

void loop() {
  int inChar; // a variable to store the characters that are rolling in from the computer
  
  if (Serial.available() > 0) { // Read serial input:
    inChar = Serial.read();  
  }

  if (isDigit(inChar)) {
    inString += (char)inChar; // convert the incoming byte to a char and add it to the string: 
  }

  // if you get a comma, convert to a number, set the appropriate color, and increment the color counter:
  if (inChar == ',') {
    switch (currentColor) { // do something different for each value of currentColor:
    case 0:    // 0 = red
      red = inString.toInt();
      inString = ""; // clear the string for new input:
      break;
    case 1:    // 1 = green:
      green = inString.toInt();
      inString = ""; // clear the string for new input:
      break;
    case 2:    // 2 = blue:
      blue = inString.toInt(); // clear the string for new input:
      inString = ""; 
      break;
    }
    currentColor++; // and next color
  }

  if (inChar == '\n') { // if you get a newline, you know you've got the last color, i.e. blue:
    inString = ""; // clear the string for new input:
    currentColor = 0; // reset the color counter
  }
  
  for(uint16_t i=0; i<strip.numPixels(); i++) {  
      strip.setPixelColor(i, strip.Color(red, green, blue));      
  }

strip.show();
}

void colorWipe(uint32_t c, int8_t wait) { // Fill the dots one after the other with a color
  for(uint16_t i=0; i<strip.numPixels(); i++) {  
      strip.setPixelColor(i, c);
      strip.show();
      delay(wait);
  }
}

void serialEvent() {
  
}



