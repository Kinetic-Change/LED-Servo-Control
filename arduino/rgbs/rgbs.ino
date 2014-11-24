#include <Servo.h> 

Servo myservo; 


String inString = "";    // string to hold input
int currentColor = 0;   // which color is being read right now
int red, green, blue, servo = 0; // vatiables to store the values for each color and the servo

int r = 3;    // LED connected to digital pin 9
int g = 6;    // LED connected to digital pin 9
int b = 5;    // LED connected to digital pin 9



void setup() { // executed onec on reboot of the Arduino
  // Open serial communications and wait for port to open:
  myservo.attach(11);  // attaches the servo on pin 11 to the servo object 
  Serial.begin(115200); // begin talking to the computer at very high speed :)
  while (!Serial) {
    ; // wait for serial port to connect. Needed for Leonardo only
  }

  // this is for debugging the values inside arduino to the computer
  Serial.println("\n\nString toInt() RGB:"); //  a first and freindly hello world
  Serial.println(); //...followed by an empty line
  
  // set LED cathode pins as outputs:
  pinMode(r, OUTPUT); 
  pinMode(g, OUTPUT);
  pinMode(b, OUTPUT);


  // turn on pin 13 to power the LEDs:
  pinMode(13, OUTPUT); 
  digitalWrite(13, HIGH);
}

void loop() {
  int inChar; // a varibake to store the characters that are rolling in from the computer

  // Read serial input:
  if (Serial.available() > 0) {
    inChar = Serial.read();
  }

  if (isDigit(inChar)) {
    // convert the incoming byte to a char and add it to the string:
    inString += (char)inChar; 
  }

  // if you get a comma, convert to a number,
  // set the appropriate color, and increment
  // the color counter:
  if (inChar == ',') {
    // do something different for each value of currentColor:
    switch (currentColor) {
    case 0:    // 0 = red
      red = inString.toInt();
      // clear the string for new input:
      inString = ""; 
      break;
    case 1:    // 1 = green:
      green = inString.toInt();
      // clear the string for new input:
      inString = ""; 
      break;
    case 2:    // 2 = blue:
      blue = inString.toInt();
      // clear the string for new input:
      inString = ""; 
      break;
    }
    currentColor=currentColor+1; // and next color
  }
  // if you get a newline, you know you've got
  // the last color, i.e. blue:
  if (inChar == '\n') {
    servo = inString.toInt();

    // set the levels of the LED.
    // subtract value from 255 because a higher
    // analogWrite level means a dimmer LED, since
    // you're raising the level on the anode:
    analogWrite(r, 255 - red);
    analogWrite(g, 255 - green);
    analogWrite(b, 255 - blue);

    myservo.write(servo);   

    // print the colors to the computer
    Serial.print("r:");
    Serial.print(red);
    Serial.print(" g:");
    Serial.print(green);
    Serial.print(" b:");
    Serial.print(blue);
    Serial.print(" servo:");
    Serial.println(servo);

    // clear the string for new input:
    inString = ""; 
    // reset the color counter:
    currentColor = 0;
  }

}





