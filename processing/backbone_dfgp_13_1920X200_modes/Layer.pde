class Layer extends PVector {
  int id;
  PVector [] val;
  ArrayList <PVector> cps;

  boolean selected = false;
  float alpha;

  Layer(PVector h, int _id, float _r) {
    super(h.x, h.y, h.z);
    this.id = _id;
    this.setVals(_r);
  }


  void setVals(float _r) {
    val = new PVector[8];
    for (int i = 0; i<val.length; i++) {
      val[i] = new PVector(random(0.2, 1), 0);
      val[i].mult(_r); 
      val[i].rotate(i * (PI/4));
    }
    createPs();
  }



  void update(int _s) {
    if (id == _s) {
      selected=true;
    } 
    else {
      selected=false;
    }
  }

  void glow() {
    if (selected) {
      alpha = 200;
    } 
    else {
      alpha = alpha + 0.0512*(60-alpha);
    }
  }

  void createPs() {
    cps = new ArrayList <PVector>(); 
    int steps = 16;
    for (int a = 0; a < 8; a++) {
      for (int i = 0; i <= steps; i++) {
        float t = i / float(steps);
        float _x=0, _y=0;
        int b = 0;
        if (a < 5) {
          _x = curvePoint(val[a].x, val[a+1].x, val[a+2].x, val[a+3].x, t);
          _y = curvePoint(val[a].y, val[a+1].y, val[a+2].y, val[a+3].y, t);
        }
        if (a == 5) {
          _x = curvePoint(val[a].x, val[a+1].x, val[a+2].x, val[0].x, t);
          _y = curvePoint(val[a].y, val[a+1].y, val[a+2].y, val[0].y, t);
        }

        if (a == 6) {
          _x = curvePoint(val[a].x, val[a+1].x, val[0].x, val[1].x, t);
          _y = curvePoint(val[a].y, val[a+1].y, val[0].y, val[1].y, t);
        }

        if (a == 7) {
          _x = curvePoint(val[a].x, val[0].x, val[1].x, val[2].x, t);
          _y = curvePoint(val[a].y, val[0].y, val[1].y, val[2].y, t);
        }

        PVector cp = new PVector(_x, _y, this.z);
        //println(cp);
        cps.add(cp);
      }
    }
  }

  void displayCurvePoints() {
    beginShape(POINTS);
    for (int i = 0; i < cps.size (); i++) {
      PVector cp = cps.get(i);
      vertex(cp.x, cp.y, cp.z);
    }
    endShape();
  }

  void displayEdge(int _s) {


    if (id == _s) {
      fill(255, alpha);
    } 
    else {
      fill(255, alpha);
    }

    float h = 5;

    for (int i = 1; i < cps.size (); i++) {
      PVector cp = cps.get(i);
      PVector lcp = cps.get(i-1);
      beginShape(QUADS);
      vertex(cp.x, cp.y, cp.z);
      vertex(lcp.x, lcp.y, lcp.z);
      vertex(lcp.x, lcp.y, lcp.z - h);
      vertex(cp.x, cp.y, cp.z - h);
      endShape(CLOSE);
    }
  }

  void displayOctagon(int _s, float xOff, float yOff) {

    if (id == _s) {
      stroke(255, alpha);
      fill(150, alpha);
    } 
    else {
      stroke(150, alpha);
      fill(100, alpha);
    }
    //noFill();

    beginShape();
    for (int i = 0; i<val.length; i++) {
      curveVertex(x + val[i].x + xOff, y + val[i].y + yOff);
    }
    for (int i = 0; i<3; i++ ) {
      curveVertex(x + val[i].x + xOff, y + val[i].y + yOff);
    }
    endShape(CLOSE);
  }


  void display(int _s) {
    stroke(100, 75);
    fill(100, 18);

    if (id == _s) {
      stroke(255, alpha); 
      fill(60, alpha);
      //noFill();
    }

    beginShape();
    for (int i = 0; i<val.length; i++) {
      curveVertex(x + val[i].x, y + val[i].y, z);
    }
    for (int i = 0; i<3; i++ ) {
      curveVertex(x+val[i].x, y+val[i].y, z);
    }
    endShape();
  }

  void display2D() {
    stroke(255, 140); 
    fill(255, 26);
    beginShape();
    for (int i = 0; i<val.length; i++) {
      curveVertex(x + val[i].x, y + val[i].y, 0);
    }
    for (int i = 0; i<3; i++ ) {
      curveVertex(x+val[i].x, y+val[i].y, 0);
    }
    endShape();
  }


  void displayScalar(int _s) {

    stroke(255, 40);

    if (id == _s) stroke(255, 100);


    for (int i = 0; i<val.length; i++ ) {
      beginShape(LINES);
      vertex(0, 0, z);
      vertex(val[i].x, val[i].y, z);
      endShape();
    }

    int spac1 = 2;
    int spac2 = spac1 * 5;
    int length1 = 2;
    int length2 = length1 * 2;
    for (int i = 0; i<val.length; i++ ) {
      for (int j = 10; j < val[i].mag (); j+=spac1) {  
        beginShape(LINES);
        vertex(j, -length1/2, z);
        vertex(j, length1/2, z);
        endShape();
      }
      for (int k = 10; k < val[i].mag (); k+=spac2) {
        if (k!=10) {
          beginShape(LINES);
          vertex(k, -length2/2, z);
          vertex(k, length2/2, z);
          endShape();
        }
      }
      rotateZ(PI/4);
    }
  }
}


void createLayers(int _a, int _spac, float _r) {
  for (int i = 0; i < _a; i++) {
    PVector h = new PVector(0, 0, i*_spac);
    Layer l = new Layer(h, i, _r);
    layers.add(l);
  }
}

void updateLayers(int _s) {
  for (int i = 0; i<layers.size (); i++) {
    Layer l = layers.get(i);
    l.update(_s);
    l.glow();
  }
}

void setLayersValues(float _r) {
  for (int i = 0; i<layers.size (); i++) {
    Layer l = layers.get(i);
    l.setVals(_r);
  }
}

void displayLayers(int _s) {
  for (int i = 0; i<layers.size (); i++) {
    Layer l = layers.get(i);
    l.display(_s);
  }
}

void displayLayersScalars(int _s) {
  for (int i = 0; i<layers.size (); i++) {
    Layer l = layers.get(i);
    l.displayScalar(_s);
  }
}

void displayLayersEdges(int _s) {
  for (int i = 0; i<layers.size (); i++) {
    Layer l = layers.get(i);
    l.displayEdge(_s);
  }
}

void displayLayersOctagons(int _s, float _f) {
  float xOff = 0;
  float yOff = 0;
  for (int i = 0; i<layers.size (); i++) {
    if (i%(54/3)==0) {
      xOff = 0;
      yOff += r*_f;
    } 
    else {
      xOff+=r*_f;
    }
    Layer l = layers.get(i);
    l.displayOctagon(_s, xOff, yOff);
  }
}

/////////////////////////////////////////////////////////////////////////DEBUG

void displayLayersCurvePoints() {
  strokeWeight(1.5);
  stroke(255);
  hint(DISABLE_DEPTH_TEST);
  for (int i = 0; i<layers.size (); i++) {
    Layer l = layers.get(i);
    l.displayCurvePoints();
  }
}

void displayTimeCurves2D(color [] c, int _s) {

  int dayVal=1, monthVal = 1;
  float yOff = 0;
  Layer sl = layers.get(_s);

  hint(DISABLE_DEPTH_TEST);
  noFill();
  stroke(200);
  strokeWeight(.75f/.8f);
  beginShape(LINES);
  vertex(sl.z, 0);
  vertex(sl.z, 1110);
  endShape();
  for (int j = 0; j<8; j++) {
    //stroke(c[j], 150);
    stroke(60);
    strokeWeight(1);
    yOff+=r*1.1;
    beginShape();
    for (int i = 0; i<layers.size (); i++) {
      Layer l = layers.get(i);
      curveVertex(i*spacing, l.val[j].mag() + yOff);
    }
    endShape();

    //stroke(c[j]);
    stroke(200);
    strokeWeight(8);
    beginShape(POINTS);
    vertex(sl.z, sl.val[j].mag()+yOff);
    endShape();
  }
}

void setCurvesColors() {
  for (int i=0; i < 8; i++) {
    curveColors[i] = color(200, random(255), random(255));
  }
}

void displayTimeCurves(color [] c, int _s) {

  noFill();
  for (int j = 0; j<8; j++) {
    //stroke(c[j], 150);
    stroke(90);
    strokeWeight(1*1.15);
    hint(ENABLE_DEPTH_TEST);
    beginShape();
    for (int i = 0; i<layers.size (); i++) {
      Layer l = layers.get(i);
      curveVertex(l.x + l.val[j].x, l.y + l.val[j].y, l.z + l.val[j].z);
    }
    endShape();
    //stroke(c[j]);
    stroke(200, 150);
    strokeWeight(10);
    hint(DISABLE_DEPTH_TEST);
    Layer l = layers.get(_s);
    beginShape(POINTS);
    vertex(l.x + l.val[j].x, l.y + l.val[j].y, l.z + l.val[j].z);
    endShape();
  }
}

void setNoise() {

  for (int j = 0; j<8; j++) {
    for (int i = 1; i<layers.size (); i++) {
      Layer l = layers.get(i);
      l.createPs();
      Layer ll = layers.get(i-1);
    }
  }
}


void displaySelected(int _s) {
  //noFill();
  fill(50);
  strokeWeight(.7);
  rectMode(CENTER);

  Layer l = layers.get(_s);
  translate(0, 0, -l.z); //=>ortho
  for (int i = 0; i <l.val.length+1; i++) {
    stroke(80);
    line(0, 0, r*1.05, 0);
    fill(80);
    rect(r*1.05, 0, 20/2.5, 5/2.5);
    rotate(PI/4 * i);
  }

  strokeWeight(.5f);
  l.display2D();
  strokeWeight(.4f);
  l.displayScalar(selected);
  hint(ENABLE_DEPTH_TEST);
  fill(0);
  strokeWeight(.75f/2.3);
  ellipse(0, 0, 20, 20);
  strokeWeight(1.2f);
}

