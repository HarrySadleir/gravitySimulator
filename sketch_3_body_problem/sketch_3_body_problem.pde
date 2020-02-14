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

  stars[0] = new Star(100, new PVector(width/2, 0), new PVector(4,0));
  stars[1] = new Star(1000, new PVector(width/2, height/2), new PVector(0,0));
  stars[2] = new Star(100, new PVector(width/2, height), new PVector(-5,0));
  
  //random stars for i initial stars
  //for(int i = 0; i< stars.length; i++) {
  //  stars[i] = new Star(random(10000, 1000000), new PVector(random(width), random(height)), PVector.random2D());
  //}
}

void draw() {
  background(0);
  
  
  for (Star s : stars) {
    s.show();
    s.update();
  }
}