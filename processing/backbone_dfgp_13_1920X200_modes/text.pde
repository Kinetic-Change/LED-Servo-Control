void displayText(boolean a, boolean b) {
  if (a) {
    noStroke();
    fill(200);
    textAlign(RIGHT);
    textFont(font1);
    text(selected + 1, width/2 - r * 1.15 - 260, 300);


    fill(70);
    textAlign(LEFT);
    textFont(font2);
    text("/ 54", width/2 - r * 1.15 - 250, 300);
  }


  fill(120);
  textAlign(LEFT);
  textFont(font0);
  text("2015", 140, 300);
  if (b) {
    fill(70);
    textAlign(LEFT);
    textFont(font3);
    text("01.01.2015", width/2 + r*1.15 + 200, 300);
    textAlign(RIGHT);
    textFont(font3);
    text("31.12.2015", width/2 + r*1.15 + 650, 300);
  }
  fill(70);
  textAlign(LEFT);
  textFont(font3);
  text(frameRate, 140, 150);
}

void displaySelectedVals(int _s) {
  textAlign(RIGHT);
  hint(DISABLE_DEPTH_TEST);
  textFont(font0, 8);
  Layer l = layers.get(_s);
  fill(200, 255);
  for (int i = 0; i < l.val.length; i++) {
    noStroke();
    pushMatrix();
    translate((l.x + l.val[i].x)*1.7f, (l.y + l.val[i].y)*1.7f, l.z + l.val[i].z + 30);
    rotateZ(-rotZ);
    rotateX(-PI/2);
    text(l.val[i].mag()/110, 0, 0, 0);
    popMatrix();
    stroke(200, 150);
    strokeWeight(1f);
    beginShape(LINES);
    vertex((l.x + l.val[i].x)*1.7f, (l.y + l.val[i].y)*1.7f, l.z + l.val[i].z + 27);
    vertex((l.x + l.val[i].x), (l.y + l.val[i].y), l.z + l.val[i].z);
    endShape();
  }
}

