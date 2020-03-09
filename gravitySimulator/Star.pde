class Star {
  private float mass, r;
  private PVector d, v;
  private color c;
  private PGraphics p;

  /*
  Creates a new star with:
   
   Mass mass in kg
   Position d in meters (1 meter = 1 pixel)
   Velocity v in meters
   Radius r in meters (taken from mass, assuming constant density for simplicity)
   */
  Star(float mass, PVector d, PVector v) {
    this.mass=mass;
    this.d = d.copy();
    this.v = v.copy();
    r = 5;
    colorMode(HSB);

    c = color(random(255), 255, 255);
    p = createGraphics(width, height);
    //pow(mass*3/(4*PI), .3);
  }

  // draws the star to canvas
  public void show() {
    fill(255);
    ellipse(d.x, d.y, r, r);

    image(p, 0, 0);
  }
  
  // update v each tick
  public void updateV() {
    //update v
    v.add(getAcceleration());
  }

  // updates d, called each tick
  public void update() {
    //speed limit
    if (v.mag()>15) v.setMag(15);

    //update d
    PVector temp1 = d.copy();

    d.add(v);

    p.beginDraw();
    p.strokeWeight(3);
    p.stroke(c);
    p.line(temp1.x, temp1.y, d.x, d.y);
    p.endDraw();

    //check walls
    if (wCollisions) {
      if (d.x<0) {
        d.set(1, d.y);
        v.set(-v.x, v.y);
      }
      if (d.x>width) {
        d.set(width-1, d.y);
        v.set(-v.x, v.y);
      }
      if (d.y<0) {
        d.set(d.x, 1);
        v.set(v.x, -v.y);
      }
      if (d.y>height) {
        d.set(d.x, height-1);
        v.set(v.x, -v.y);
      }
    }
    
    if(sCollisions) {
      for(Star s : stars) {
        if (!s.equals(this)) {
          if(d.dist(s.getPos())< r) {
            v.rotate(PI); 
            d.add(v);
          }
        }
      }
    }
  }

  private PVector getAcceleration() {
    PVector a = new PVector(0, 0);

    //global variables ew gross
    for (Star s : stars) {
      if (!s.equals(this)) {
        //get angle of acceleration vector
        float x = s.getPos().x-d.x;
        float y = s.getPos().y-d.y;
        float angle = -atan2(-y, x);

        PVector temp = PVector.fromAngle(angle);

        //set its magnitude based off F=GMm/r^2
        temp.setMag((s.getMass()*G)/pow(d.dist(s.getPos()), 2));

        a.add(temp);
      }
    } 

    return a;
  }


  float getMass() {
    return mass;
  }
  
  float getR() {
    return r;
  }

  PVector getPos() {
    return d;
  }
}