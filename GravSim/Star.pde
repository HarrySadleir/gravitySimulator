class Star {

  // The stars coordinates, velocity and accelerations in m, m/s, and m/s^2 respectively.
  private PVector pos;
  private PVector vel;
  private PVector acc;

  // The stars effective mass, i.e. sqrt(G)*M, where G is the gravitational constant
  private float eM;
  private float r;
  
  ArrayList<PVector> points;
  
  color col;

  // Create a new Star variable with given pos, vel, and mass. Set r proportional to m^(1/3)
  public Star(float x, float y, float z, float vx, float vy, float vz, float eM, color col) {
    this.pos = new PVector(x, y, z);
    this.vel = new PVector(vx, vy, vz);
    this.acc = new PVector(0, 0, 0);

    this.eM = eM;
    
    this.col = col;

    r = 3*pow(eM, 1.0/3);
    
    points = new ArrayList<PVector>();
  }

  // display a sphere of radius r at position this.pos
  public void show() {
    pushMatrix();

    translate(pos.x, pos.y, pos.z);
    fill(col);
    stroke(col);
    sphere(r);

    popMatrix();
    
    noFill();
    stroke(col);
    strokeWeight(2);
    beginShape();
    for(PVector p : this.points) {
      vertex(p.x, p.y, p.z);
    }
    endShape();
  }


  /*---------------Movement functions---------------
   updateAcc, updateVel, and updatePos are meant to be called in that order,
   once every frame.*/

  // reset acc to 0, then for every star, compute the vector distance and add
  // s.eM/|r|^2 in the direction of r.
  public void updateAcc() {
    acc.set(0, 0, 0);
    for (Star s : stars) {
      if (s != this) {
        PVector r = getDistance(s);
        acc.add(r.normalize().mult(s.eM / r.magSq()));
      }
    }
  }

  // update the star's distance
  public void updateVel() {
    this.vel.add(PVector.div(this.acc, 30));
  }

  // update the star's position
  public void updatePos() {
    this.pos.add(PVector.div(this.vel, 30));
    
    this.points.add(this.pos.copy());
    if(this.points.size() > 1000) points.remove(0);
  }

  // ----------------------helper functions---------------------

  // return s.pos-this.pos, the vector from this.pos to s.pos
  private PVector getDistance(Star s) {
    return PVector.sub(s.pos, this.pos);
  }
}