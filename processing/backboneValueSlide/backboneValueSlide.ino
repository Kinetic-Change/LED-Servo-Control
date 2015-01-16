#include <Adafruit_NeoPixel.h>

#define PIN 6
#define HALO_SIZE 11
#define STRIP_LENGTH 72
int current_lights[STRIP_LENGTH] ;
int next_lights[STRIP_LENGTH];
int next, current;
int count = 0;
boolean decrease = true;
float offset = -8;
//int timer;
boolean switcher;
Adafruit_NeoPixel strip = Adafruit_NeoPixel(STRIP_LENGTH, PIN, NEO_GRB + NEO_KHZ800);

void setup(){
  Serial.begin(11500);
  strip.begin();
//  strip.setPixelColor();
}

void loop(){
/*  
  for (int i =0; i<strip.numPixels(); i++){
   strip.setPixelColor(i,0,0,0);
  }
  
  for (int i = current - HALO_SIZE/2;   i < current + HALO_SIZE/2; i++) {
    int  val = Gauss(i-(current-5));
    strip.setPixelColor(i, val, val, val);
  }    
  */
//  int sampling[7] = [-1.5,-1,-0.5,0,0.5,1.5,2.0);
  
  if(decrease) offset = offset - 0.25;
  else if (!decrease) offset = offset + 0.25;
  if(offset < -24 || offset > -8) {
    if(decrease) decrease = false;
    else if (!decrease) decrease = true;
  }
/*  strip.setPixelColor(0, gauss(-1.5+offset),gauss(-1.5+offset),gauss(-1.5+offset));
  strip.setPixelColor(2, gauss(-1+offset),gauss(-1+offset),gauss(-1+offset));
  strip.setPixelColor(4, gauss(-0.5+offset),gauss(-0.5+offset),gauss(-0.5+offset));  
  strip.setPixelColor(6, gauss(0+offset),gauss(0+offset),gauss(0+offset));  
  strip.setPixelColor(8, gauss(0.5+offset),gauss(0.5+offset),gauss(0.5+offset));  
  strip.setPixelColor(10, gauss(1.5+offset),gauss(1.5+offset),gauss(1.5+offset));  
  strip.setPixelColor(12, gauss(2.0+offset),gauss(2.0+offset),gauss(2.0+offset));  
*/

  for (int i=0; i<strip.numPixels(); i++) {
    strip.setPixelColor(i,rauss(i,offset),rauss(i,offset),0.5*rauss(i,offset));
    //strip.setPixelColor(i,gauss(i,offset)[0],gauss(i,offset)[1],gauss(i,offset)[2]);
  }

  strip.show();  
}
/*
int gauss(int i) {
//  255*pow(2.71,-pow((int)((float)i/4,2)));
  float x = 0.5*i-1.5;
  return (int)(125.f*pow(2.71,-pow(x,2)));
}
*/

int rauss (int i, float offset) {
  float x = 0.5*(i+offset)-1.5;  
  return (int)(255.f*pow(5,-pow(x,2)));
}
/*
int[3] gauss (int i, float offset) {
  float x = 0.5*(i+offset)-1.5;  
  int r[3] = [rauss(i,offset), rauss(i*0.5,offset), rauss(i*0.5,offset)]
  return (int)(255.f*pow(1.5,-pow(x,2)));
}
*/

void serialEvent() {
    //next = Serial.read();
//    Serial.println("next is " + next);
}
