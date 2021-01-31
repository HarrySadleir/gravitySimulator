/*
  This project will simulate gravity for an arbitrary number of objects in 3 dimensions,
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

// control switch between modes
int mode = 1;
Startup startup;
Simulation simulation;

void setup() {
  size(600, 600, P3D);
  frameRate(30);
  
  stars = new Star[4];
  
  stars[0] = new Star(400, height/2, 30, 0, 100, -12.5, 100, color(150, 10, 10));
  stars[1] = new Star(200, height/2, -50, 0, -107.5, -42.5, 100, color(10, 150, 10));
  stars[2] = new Star(300, 100, 0, -25, 40, 100, 50, color(10, 10, 150));
  stars[3] = new Star(300, 300, -800, 50, 50, 0, 1, color(200, 200, 50));
  
  simulation = new Simulation();
  startup = new Startup();
}

void draw() {
  if (mode == 0) startup.tick();
  if (mode == 1) simulation.tick();
}