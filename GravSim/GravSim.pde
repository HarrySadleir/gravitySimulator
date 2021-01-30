/*
  This project will sumulate gravity for an arbitrary number of objects in 3 dimensions,
  using Newton's formula for gravity, F = GMm/r^2.
  
  Setting up:
  - Modify the stars array as desired. For systems that stay centered on the origin (width/2, height/2),
    ensure that the total momentum (mv) = 0 in all directions
    
  Controls:
  - UP, DOWN: control the azimuthul angle of the camera
  - LEFT, RIGHT: control the polar angle (right ascension) of the camera
  - +,-: zoom in and out

*/

Star[] stars;

// Right ascension, azimuthal angle, and dist of camera
float ra = PI/2, aa = 1.65, dist = 520;

// Keyboard control variables
boolean l, r, u, d, p, m;

void setup() {
  size(600, 600, P3D);
  frameRate(30);
  
  stars = new Star[3];
  
  stars[0] = new Star(400, height/2, 0, 0, 100, -12.5, 100);
  stars[1] = new Star(200, height/2, 0, 0, -100, -12.5, 100);
  stars[2] = new Star(300, 100, 0, 0, 0, 50, 50);
  
}

void draw() {
  display();
  moveCamera();
  
  for(Star s : stars) {
    s.show();
  }
  
  // it is important that these steps are done in seperate loops to maintain symmetry
  for(Star s : stars) {
    s.updateAcc();
  }
  
  for(Star s : stars) {
    s.updateVel();
  }
  
  for(Star s : stars) {
    s.updatePos();
  }
}

void display() {
  background(20);
  
  // Show camera position on screen in spherical coordinates
  text("Right Ascension:" + ra, 50, 50);
  text("Azimuthal Angle:" + aa, 50, 70);
  text("Distance:" + dist, 50, 90);
  
  // Display axis
  strokeWeight(5);
  pushMatrix();
  translate(width/2, height/2, 0);
  stroke(255, 0, 0);
  line(-1000, 0, 0, 1000, 0, 0);
  stroke(0, 255, 0);
  line(0, -1000, 0, 0, 1000, 0);
  stroke(0, 0, 255);
  line(0, 0, -1000, 0, 0, 1000);
  popMatrix();
}

// Move the camera according to what key is being held
void moveCamera() {
  camera(dist*sin(aa)*cos(ra) + width/2, 
         dist*cos(aa)+ height/2, 
         dist*sin(aa)*sin(ra), width/2, height/2, 
         0, 0, 1, 0);
  
  
  if (l) ra-=0.05;
  if (r) ra+=0.05;
  if (u) aa-=0.05;
  if (d) aa+=0.05;
  if (m) dist+=3;
  if (p) dist-=3;
  
  if (ra > 2*PI) ra = 0;
  if (ra < 0) ra = 2*PI;
 
  if (aa > PI-0.1) aa = PI-0.1;
  if (aa < 0.1) aa = 0.1;

  if (dist < 0) dist = 0;
  
}

void keyPressed() {
  if (keyCode == LEFT)          l = true;
  if (keyCode == RIGHT)         r = true;  
  if (keyCode == UP)            u = true;
  if (keyCode == DOWN)          d = true;
  if (key == '-' || key == '_') m = true;
  if (key == '=' || key == '+') p = true;
}

void keyReleased() {
  if (keyCode == LEFT)          l = false;
  if (keyCode == RIGHT)         r = false;
  if (keyCode == UP)            u = false;
  if (keyCode == DOWN)          d = false;
  if (key == '-' || key == '_') m = false;
  if (key == '=' || key == '+') p = false;
}