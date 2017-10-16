//ScenesGroup.pde

class EyeGroup extends Particle {

  color c;
  int id;
  float soundVol;


  EyeGroup(PVector p) {
    pos = p.get();
    c=color(255, random(150, 255), random(150, 255));
    id=int(random(3));
  }

  void run() {
    update() ;
    render();
  }

  void render() {
    if (id==0) soundVol=map(low, 0, 1, -5, 40);
    if (id==1) soundVol=map(middle, 0, 1, -5, 40);
    if (id==2) soundVol=map(high, 0, 1, -5, 40);

    s3d.pushMatrix();

    s3d.translate(pos.x, pos.y, pos.z);

    s3d.rotate(degrees(ang));

    s3d.tint(c, 230);
    s3d.scale(showEyeParticle/255);

    if (wireFrameCtl==true) {
      s3d.noFill();
      s3d.stroke(0, 160, 255, 120);
      s3d.strokeWeight(2.0f);
      s3d.ellipse( 0, 0, mass*20+soundVol, mass*20+soundVol);
    } else {
      //PMatrix3D mat = (PMatrix3D)getMatrix();
      //mat.m00 = mat.m11 = mat.m22 = 1.0f;
      //mat.m01 = mat.m02 = mat.m10 = mat.m12 = mat.m20 = mat.m21 = 0.0f;

      //s3d.resetMatrix();
      //s3d.applyMatrix(  0.0, 0.0, 1.0, 0.0, 
      //  0.0, 1.0, 0.0, 0.0, 
      //  1.0, 0.0, 0.0, 0.0, 
      //  0.0, 0.0, 0.0, 1.0);  
      
      //s3d.rotateY(radians(-90));
      s3d.image(eyeParticle, 0, 0, mass*20+soundVol, mass*20+soundVol);
    }

    s3d.popMatrix();
  }
}


class EarGroup extends Particle {
  color c;
  int id;
  float soundVol;
  float defultSize=0;
  int animCount;

  EarGroup(PVector p) {
    pos = p.get();
    c=color(255, random(150, 255), random(150, 255));
    id=int(random(3));
    defultSize=random(20, 200);
    animCount=int(random(400, 600));
  }

  void run() {
    render();
    defultSize=random(20, 200);
  }

  void render() {
    if (id==0) soundVol=low*defultSize;
    if (id==1) soundVol=middle*defultSize;
    if (id==2) soundVol=high*defultSize;
    s3d.pushMatrix();
    s3d.translate(pos.x, pos.y, pos.z);
    s3d.translate(0, anim(animCount, -10, 10, 8), 0);
    s3d.scale(showEarParticle/255);
    if (wireFrameCtl==true) {
      s3d.noFill();
      s3d.stroke(0, 160, 255, 120);
      s3d.strokeWeight(2.0f);
      s3d.rect( 0, 0, 30, 30+soundVol);
      s3d.rect( 0, -2, 30, -32-soundVol);
    } else {
      s3d.image(earParticle_1, 0, 0, 30, 30+soundVol);
      s3d.image(earParticle, 0, -2, 30, -32-soundVol);
    }
    s3d.popMatrix();
  }
}