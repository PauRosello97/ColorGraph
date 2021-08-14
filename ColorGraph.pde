int BOX_SIZE = 500;
int stepValue;
float rotationX, rotationY;
boolean fixedView = true;

void setup(){
  size(1600, 900, P3D); 
}

void draw(){
  background(150);
  drawGraph(width/2, height/2, -BOX_SIZE*0.7);
  drawDimensions(50, 50, 400, 700);
  drawColor(1150, 50, 400, 700);
}

void drawDimensions(float x, float y, float w, float h){
  strokeWeight(1);
  rect(x, y, w, h);
  
  float dimH = 100;
  float margin = 60;
  
  // Red dimension
  rect(x, y, w, dimH);
  beginShape();
  for(int i=0; i< 255; i++){
    color c = getColor(i);
    vertex(x+i*(w/255), y+dimH*(1-red(c)/255));
  }
  endShape();
  
  // Green dimension
  rect(x, y+dimH+margin, w, dimH);
  beginShape();
  for(int i=0; i< 255; i++){
    color c = getColor(i);
    vertex(x+i*(w/255), y+dimH+margin+dimH*(1-green(c)/255));
  }
  endShape();
  
  // Blue dimension
  rect(x, y+(dimH+margin)*2, w, dimH);
  beginShape();
  for(int i=0; i< 255; i++){
    color c = getColor(i);
    vertex(x+i*(w/255), y+(dimH+margin)*2+dimH*(1-blue(c)/255));
  }
  endShape();
  
}

color getColor(float i){
    float r, g, b;
    
    float A = 255; // Amplitude
    float t = millis()/100; // Time
    float M = A/2; // Center point
    float P = TWO_PI/255; // Period
    
    r = M+M*sin((t/5+i)*P*sin(t*P));
    g = M+M*sin(t*P/2+i*P*2*sin(M*sin(t*P)*i*P/300));
    b =M+M*sin(P*sin(t*P)+10+i*P*3*sin(t*P/5));
    
    
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

void drawGraph(float x, float y, float z){
  if(!fixedView){
    rotationX = -mouseY/40.0;
    rotationY = mouseX/40.0;
  }
  
  pushMatrix();
  translate(x, y, z);
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
  
  // Green
  pushMatrix();
  translate(0,-BOX_SIZE,0);
  fill(0, 255, 0);
  sphere(20);
  popMatrix();
  
  // Blue
  pushMatrix();
  translate(0,0,BOX_SIZE);
  fill(0, 0, 255);
  sphere(20);
  popMatrix();
  
  // Magenta
  pushMatrix();
  translate(BOX_SIZE,0,BOX_SIZE);
  fill(255, 0, 255);
  sphere(20);
  popMatrix();
  
  // Yellow
  pushMatrix();
  translate(BOX_SIZE, -BOX_SIZE, 0);
  fill(255, 255, 0);
  sphere(20);
  popMatrix();
  
  // Cyan
  pushMatrix();
  translate(0, -BOX_SIZE, BOX_SIZE);
  fill(0, 255, 255);
  sphere(20);
  popMatrix();
  
  // White
  pushMatrix();
  translate(BOX_SIZE, -BOX_SIZE, BOX_SIZE);
  fill(255, 255, 255);
  sphere(20);
  popMatrix();
}

void drawFunction(){
  stroke(0);
  strokeWeight(5);
  noFill();
  beginShape();
  for(int i=0; i< 255+1; i++){
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

void mouseClicked(){
  fixedView = true;
}

void mouseReleased(){
  fixedView = false;
}
