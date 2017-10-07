class Particle {
  PVector acc, vel, pos;
  float mass, incr, ang;
  color c;

  Particle(PVector p) {
    pos = p.get();
    acc = new PVector();
    vel = new PVector();
    mass = random(.2, 2);
    ang = 0;
    incr = random(-.001, .001);
    c=color(255, random(150, 255), random(150, 255));
  }

  void run() {
    update();
    render();
  }

  void update() {
    vel.add(acc);
    vel.limit(5);
    pos.add(vel);
    acc.mult(0);
  }

  void render() {

    ang += incr;
    s3d.pushMatrix();
    s3d.translate(pos.x, pos.y, pos.z);

    s3d.rotate(degrees(ang));
    
    s3d.tint(c,230);
    s3d.scale(showParticleCount/255);
    s3d.image(eyeImg, 0, 0, mass*20, mass*20);
    
    s3d.popMatrix();
  }

  void addForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acc.add(f);
  }
  // From Daniel Schiffman's NOC_2_7_attraction_many sketch.
  PVector attractTo(float x, float y) {
    PVector mousePos = new PVector(x, y);
    PVector dir = PVector.sub(mousePos, pos);
    float dist = dir.mag();
    dist = constrain(dist, 40, 80);
    dir.normalize();
    // combine gravity and attractor_mass as 1 number
    float f = (20*mass)/(dist*dist);
    dir.mult(f);
    return dir;
  }
}