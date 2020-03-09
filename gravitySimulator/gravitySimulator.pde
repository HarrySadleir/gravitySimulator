Star[] stars;
float G;
boolean wCollisions, sCollisions;

void setup() {
  fullScreen();
  /*
  TODO's:
  - improve collisions
  - zoom camera to center of mass
  - 3D
  - java
  
  */
  //newton's gravitational constant for this setup
  G = 10;
  //wall collision turned on/off
  wCollisions = false;
  sCollisions = true;
  
  stars = new Star[3];

  stars[0] = new Star(280, new PVector(width/2, 100), new PVector(3,0));
  stars[1] = new Star(500, new PVector(width/2, height/2), new PVector(0,0));
  stars[2] = new Star(300, new PVector(width/2, height-100), new PVector(-3,0));
  
  //random stars for i initial stars
  //for(int i = 0; i< stars.length; i++) {
  //  stars[i] = new Star(random(10000, 1000000), new PVector(random(width), random(height)), PVector.random2D());
  //}
  
  frameRate(30);
  
}

void draw() {
  background(0);
  
  //pushMatrix();
  
  //PVector temp = pickCOM();
  //float n = .1*width/temp.x;
  
  //translate(temp.x, temp.y);
  //scale(n);
  
  strokeWeight(1);
  stroke(255);
  
  //for(int x = 0; x < 1000; x+=50) {
  //  line(x, 0, x, height/n);
  //}
  
  //for(int y = 0; y < 1000; y+=50) {
  //  line(0, y, width/n, y);
  //}
  
  
  for (Star s : stars) {
    s.updateV();
  }
  for (Star s : stars) {
    s.show();
    s.update();
  }
  
 // popMatrix();
}

PVector pickCOM() {
  PVector temp = new PVector(0, 0);
  for (Star s : stars) {
    temp.add(s.getPos());
  }
  
  temp.div(stars.length);
  
  return temp;
}