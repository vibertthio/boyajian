float a1;
float a2;
float a3;
float a4;

float rotX=0;
float rotY=0;
float camX=600;
float camY=200;
float camZ=430;

float easing = 0.05;
boolean resetCamDo=false;
float[] cam={600, 200, 430, 0, 0};

Particle[] particles;
int p_num = 100;
PImage eyeImg;
float showParticleCount=0;

PShape globe;
PShape Rglobe;


void s3dSetting() {
  eyeImg=loadImage("img/p_smell.png");
  particles = new Particle[p_num];
  for (int i = 0; i < p_num; i++) {
    PVector p = new PVector(random(-300, 300)+width/2, random(-300, 300)+height/2, random(-200, 200));
    particles[i] = new Particle(p);
  }
}

void s3dDrawing() {
  a1=(a1+1)%360;
  a2=(a1+1)%180;
  a3=(a1+1)%150;

  s3d.beginDraw();
  //s3d.background(bgbg);
  s3d.background(255, 155, 0, 0);
  if (showMaskEye==true) {
    if (showParticleCount<255) showParticleCount+=1;
  } else {
    if (showParticleCount>0) showParticleCount-=10;
  }

  if (showParticleCount>1) {
    for (int i = 0; i < p_num; i++) {
      particles[i].addForce(particles[i].attractTo(Eye_x, Eye_y));
      particles[i].run();
    }
  }//--------
  {
    s3d.setMatrix(getMatrix()); // replace the PGraphics-matrix

    s3d.lightFalloff(1.80, 0.001, 0.000);
    s3d.directionalLight(255, 256, 255, 0, -100, -300);
    s3d.pointLight(255, 255, 255, 300, 200, 300);
    s3d.ambientLight(73, 52, 20);
    s3d.beginCamera();
    s3d.camera( camX + camZ*sin(rotX), camY + camZ*sin(rotY), camZ*cos(rotY)*cos(rotX), camX, camY, 0, 0, 1, 0);
    //println(rotX, rotY, camX, camY, camZ);
    s3d.endCamera();

    if (resetCamDo==true)resetCam(cam[0], cam[1], cam[2], cam[3], cam[4]);

    if (mousePressed) {
      s3d.stroke(255, 0, 0);
      s3d.strokeWeight(2);
      s3d.line(width/2, height/2, 0, width/2+200, height/2, 0);
      s3d.stroke(0, 255, 0);
      s3d.line(width/2, height/2, 0, width/2, height/2-200, 0);
      s3d.stroke(0, 0, 255);
      s3d.line(width/2, height/2, 0, width/2, height/2, 200);
      s3d.pushMatrix();
      s3d.stroke(255);
      s3d.translate(width/2, height/2, 0);
      s3d.sphere(5);
      s3d.popMatrix();
    }
  }
  GL2 gl = ((PJOGL)beginPGL()).gl.getGL2();
  gl.glEnable(GL2.GL_BLEND);
  gl.glBlendFunc(GL2.GL_SRC_ALPHA, GL2.GL_ONE_MINUS_SRC_ALPHA);

  gl.glHint( GL2.GL_POLYGON_SMOOTH_HINT, GL2.GL_NICEST );
  gl.glEnable(GL2.GL_ALPHA_TEST);
  gl.glAlphaFunc(GL2.GL_GREATER, 0.1);
  endPGL();

  if (showMaskEye==true) maskEyedrawing();
  if (showMaskListen==true)maskListendrawing();
  if (showMaskSmell==true) maskSmelldrawing();
  if (showMaskTouch==true)maskTouchdrawing();
  if (showMaskTaste==true)maskTastedrawing();
  if (showMaskDream==true)maskDreamdrawing();
  if (showMaskMemory==true)maskMemorydrawing();
  if (showMaskFaces==true)maskFacesdrawing();
  if (showtoolSwordA==true)toolSwordAdrawing();
  if (showtoolSwordB==true)toolSwordBdrawing();
  if (showtoolShieldA==true)toolShieldAdrawing();
  if (showtoolShieldB==true)toolShieldBdrawing();


  s3d.pushMatrix();
  s3d.noStroke();
  s3d.translate(width/2, height/2);
  s3d.rotateY(radians(252));

  if (keyPressed==true &&key == 'k') randomVertex(globe);
  else returnVertex(Rglobe, globe);

  s3d.shape(globe);
  s3d.popMatrix();
  s3d.endDraw();
}