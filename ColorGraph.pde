int BOX_SIZE = 400;
int stepValue;
float rotationX, rotationY;
boolean fixedView = true;

void setup(){
  size(1600, 800, P3D); 
}

void draw(){
  background(150);
  drawGraph();
  drawColor(1100, 100, 400, 100);
}

color getColor(float i){
    float r, g, b;
    
    r = 127+sin(i/30)*127;
    g = 127+sin(i/15)*127;
    b = i;
    
    return color(r, g, b);
}

void drawColor(float x, float y, float w, float h){
  noStroke();
  float lineW = w / 255;
  for(int i=0; i<255; i++){
    fill(getColor(i));
    rect(x+i*lineW, y, lineW, h);  
  }
  stroke(0);
  noFill();
  rect(x, y, w, h);
}

void drawGraph(){
  if(!fixedView){
    rotationX = -mouseY/40.0;
    rotationY = mouseX/40.0;
  }
  
  pushMatrix();
  translate(BOX_SIZE*1.7, BOX_SIZE, -BOX_SIZE*0.7);
  rotateX(rotationX);
  rotateY(rotationY);
  translate(-BOX_SIZE/2, BOX_SIZE/2, -BOX_SIZE/2);
  drawBox();
  drawFunction();
  popMatrix();
}

void drawBox(){
  // Main
  strokeWeight(5);
  stroke(255, 0, 0);
  line(0, 0, 0, BOX_SIZE, 0, 0); // x
  stroke(0, 255, 0);
  line(0, 0, 0, 0, -BOX_SIZE, 0); // y
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, BOX_SIZE); // z
  // Secondary
  strokeWeight(1);
  stroke(0);
  line(0, -BOX_SIZE, 0, BOX_SIZE, -BOX_SIZE, 0); // x
  line(0, -BOX_SIZE, BOX_SIZE, BOX_SIZE, -BOX_SIZE, BOX_SIZE); // x
  line(0, 0, BOX_SIZE, BOX_SIZE, 0, BOX_SIZE); // x
  line(BOX_SIZE, 0, 0, BOX_SIZE, -BOX_SIZE, 0); // y
  line(0, 0, BOX_SIZE, 0, -BOX_SIZE, BOX_SIZE); // y
  line(BOX_SIZE, 0, BOX_SIZE, BOX_SIZE, -BOX_SIZE, BOX_SIZE); // y
  line(0, -BOX_SIZE, 0, 0, -BOX_SIZE, BOX_SIZE); // z
  line(BOX_SIZE, 0, 0, BOX_SIZE, 0, BOX_SIZE); // z
  line(BOX_SIZE, -BOX_SIZE, 0, BOX_SIZE, -BOX_SIZE, BOX_SIZE); // z
  
  // Spheres
  noStroke();
  
  // Black
  fill(0);
  sphere(20);
  // Red
  pushMatrix();
  translate(BOX_SIZE,0,0);
  fill(255, 0, 0);
  sphere(20);
  popMatrix();
}

void drawFunction(){
  stroke(0);
  strokeWeight(5);
  noFill();
  beginShape();
  for(int i=0; i< 255; i++){
    color c = getColor(i);
    vertex(BOX_SIZE*red(c)/255, -BOX_SIZE*green(c)/255, BOX_SIZE*blue(c)/255);
  }
  endShape();
}

void keyPressed() {
  if(keyCode == 32){
      fixedView = !fixedView;
  }
}
