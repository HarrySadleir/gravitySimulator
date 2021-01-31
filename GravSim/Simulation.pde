class Simulation {
  // Right ascension, azimuthal angle, and dist of camera
  private float ra = PI/2, aa = 1.65, dist = 520;

  // Keyboard control variables
  private boolean l, r, u, d, p, m;

  public void tick() {
    display();
    moveCamera();
   
    // it is important that these steps are done in seperate loops to maintain symmetry
    for (Star s : stars) s.updateAcc();
    for (Star s : stars) s.updateVel();
    for (Star s : stars) s.updatePos();
  }

  private void display() {
    background(20);
    
    // display all stars and their paths
    for (Star s : stars) s.show();

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
    
    // Show camera position on screen in spherical coordinates
    camera();
    hint(DISABLE_DEPTH_TEST);
    fill(255);
    text("Right Ascension: " + nf(ra, 1, 2), 10, 15);
    text("Azimuthal Angle: " + nf(aa, 1, 2), 10, 35);
    text("Distance: " + nf(dist, 3, 0), 10, 55);
    hint(ENABLE_DEPTH_TEST);
  }

  // Move the camera according to what key is being held
  private void moveCamera() {
    camera(dist*sin(aa)*cos(ra) + width/2, 
      dist*cos(aa)+ height/2, 
      dist*sin(aa)*sin(ra), width/2, height/2, 
      0, 0, 1, 0);


    if (l) ra+=0.05;
    if (r) ra-=0.05;
    if (u) aa+=0.05;
    if (d) aa-=0.05;
    if (m) dist+=3;
    if (p) dist-=3;

    if (ra > 2*PI) ra = 0;
    if (ra < 0) ra = 2*PI;

    if (aa > PI-0.1) aa = PI-0.1;
    if (aa < 0.1) aa = 0.1;

    if (dist < 0) dist = 0;
  }

  public void handlePress() {
    if (keyCode == LEFT)          l = true;
    if (keyCode == RIGHT)         r = true;  
    if (keyCode == UP)            u = true;
    if (keyCode == DOWN)          d = true;
    if (key == '-' || key == '_') m = true;
    if (key == '=' || key == '+') p = true;
  }

  public void handleRelease() {
    if (keyCode == LEFT)          l = false;
    if (keyCode == RIGHT)         r = false;
    if (keyCode == UP)            u = false;
    if (keyCode == DOWN)          d = false;
    if (key == '-' || key == '_') m = false;
    if (key == '=' || key == '+') p = false;
  }
}