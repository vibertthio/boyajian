//ScenesParticle.pde
class Particle {
  PVector  acc;
  PVector  vel;
  PVector  pos;
  float mass;
  float  ang;
  float y;


  Particle() {
    y=random(0.5,2);
    acc = new PVector(0,y*-1.0,0);
    mass=random(0.5,1);
    ang=random(0.1);
  }

  void update() {
    float soundVol=map(vol,0,1,1,5);
    acc = new PVector(0,(y*-1.0*soundVol),0);
    pos.add(acc);
    if(pos.y<-400){
      pos.y=400;
      pos.x=random(-600, 600)+width/2;
      pos.z=random(-200, 200);
    }
  }
}