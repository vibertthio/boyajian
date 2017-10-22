//ScenesGroup.pde

class EyeGroup extends Particle {

  color c;
  int id;
  float soundVol;

  EyeGroup(PVector p){
    pos = p.get();
    c=color(255, random(150, 255), random(150, 255));
    id=int(random(3));
  }

  void run(){
    update() ;
    render();
  }

  void render() {
    if(id==0) soundVol=map(low,0,1,0.1,1);
    if(id==1) soundVol=map(middle,0,1,0.1,1);
    if(id==2) soundVol=map(vol,0,1,0.1,1);

    s3d.pushMatrix();
    s3d.translate(pos.x, pos.y, pos.z);
    //s3d.tint(c, 230);
    s3d.tint(255, 230);
    PVector rtVc = pos.copy().sub(parentPos).setMag(1.0);//unit vector
    float dst = dist(pos.x, pos.z, pos.y, parentPos.x, parentPos.z, parentPos.y);

    float rotx = -atan2(rtVc.y, rtVc.z);
    float roty = atan2(rtVc.x, sqrt(rtVc.y*rtVc.y + rtVc.z*rtVc.z));
    s3d.rotateX(rotx);
    s3d.rotateY(roty);

    s3d.scale(showEyeParticle/255);
    s3d.scale(soundVol);

    if (wireFrameCtl==true) {
      s3d.noFill();
      s3d.stroke(0, 160, 255, 200);
      s3d.strokeWeight(2.0f);
      s3d.ellipse( 0, 0, 30, 30);
      } else{
        s3d.image(eyeParticle, 0, 0, 30, 30);
      }

    s3d.popMatrix();
  }
}


class EarGroup extends Particle {
  color c;
  int id;
  float soundVol;
  float defultSize=0;
  float animCount;


  EarGroup(PVector p){
    pos = p.get();
    c=color(255, random(150, 255), random(150, 255));
    id=int(random(3));
    defultSize=random(20,200);
    animCount=int(random(60,120));
  }

  void run(){
    render();
    defultSize=random(20,200);
  }

  void render(){

    float ss=map(vol,0,1,1,1.4);
    if(id==0) soundVol=low*defultSize*ss;
    if(id==1) soundVol=middle*defultSize*ss;
    if(id==2) soundVol=high*defultSize*ss;

    s3d.pushMatrix();
    s3d.translate(pos.x,pos.y,pos.z);
    s3d.tint(255,200);
    s3d.translate(0,anim(int(animCount),-20*ss,20*ss,2),0);
    s3d.scale(showEarParticle/255);
    if (wireFrameCtl==true) {
      s3d.noFill();
      s3d.stroke(0, 160, 255, 120);
      s3d.strokeWeight(2.0f);
      s3d.rect( 0, 0,30, 30+soundVol);
      s3d.rect( 0, -2, 30, -32-soundVol);
    } else  {
      s3d.image(earParticle_1, 0, 0, 30, 30+soundVol);
      s3d.image(earParticle, 0, -2, 30, -32-soundVol);
    }
    s3d.popMatrix();
  }
}

//PMatrix3D mat = (PMatrix3D)getMatrix();
//mat.m00 = mat.m11 = mat.m22 = 1.0f;
//mat.m01 = mat.m02 = mat.m10 = mat.m12 = mat.m20 = mat.m21 = 0.0f;

//s3d.resetMatrix();
//s3d.applyMatrix(  0.0, 0.0, 1.0, 0.0,
//  0.0, 1.0, 0.0, 0.0,
//  1.0, 0.0, 0.0, 0.0,
//  0.0, 0.0, 0.0, 1.0);
