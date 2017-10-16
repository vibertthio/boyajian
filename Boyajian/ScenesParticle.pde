//ScenesParticle.pde
class Particle {
  PVector  acc;
  PVector  vel;
  PVector  pos;
  float mass;
  float  ang;


  Particle() {
    acc = new PVector(0,random(-1,-5),0);
    mass=random(0.5,1);
    ang=random(0.1);
  }

  void update() {
    pos.add(acc);
    if(pos.y<-300){
      pos.y=400;
      pos.x=random(-600, 600)+width/2;
      pos.z=random(-200, 200);
    }
  }
}
