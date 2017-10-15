//Scenes3D.pde

float rotX=0;
float rotY=0;
float camX=600;
float camY=200;
float camZ=430;
float easing = 0.02;

float[] cam={600, 200, 430, 0, 0};
float showParticleCount=0;

Particle[] particles;
int particlesNum = 50;
PImage eyeImg;
PImage black;

PShape globe;
PShape Rglobe;
PMatrix mat_scene;
float randomVel=2;

boolean wireFrameCtl=false;
boolean vertexNoise=false;
boolean resetCamDo=false;
color maskNmae=color(255);

void s3dSetting() {
  mat_scene = getMatrix();
  eyeImg=loadImage("img/p_eye.png");
  black=loadImage("img/black.png");
  particles = new Particle[particlesNum];
  for (int i = 0; i < particlesNum; i++) {
    PVector p = new PVector(random(-300, 300)+width/2, random(-300, 300)+height/2, random(-200, 200));
    particles[i] = new Particle(p);
  }
  globe = loadShape("3d/sphere2.obj");
  Rglobe = loadShape("3d/sphere2.obj");
  globe.setStroke(false);
  globe.setTexture(tex);
}

float  Falloff=1.8;


void s3dDrawing() {

  s3d.beginDraw();
  s3d.background(0, 2);

  //s3d.rectMode(CORNER);
  if (wireFrameCtl==true && frameCount%20==0 ) {
    //setMatrix(mat_scene);
    //s3d.fill(0,15);
    //s3d.rect(0,0,width*3,height*3);
  }

  if (vertexNoise==true) {
    if (randomVel<50) randomVel=(randomVel+(randomVel/200));
  } else {
    if (randomVel>2) randomVel=(randomVel-0.1);
  }

  if (showMaskEye==true) {
    if (showParticleCount<255) showParticleCount+=1;
  } else {
    if (showParticleCount>0) showParticleCount-=10;
  }

  if (showParticleCount>1) {
    for (int i = 0; i < particlesNum; i++) {
      particles[i].addForce(particles[i].attractTo(Eye_x, Eye_y));
      particles[i].run();
    }
  }//--------
  {
    s3d.setMatrix(getMatrix()); // replace the PGraphics-matrix

    s3d.lightFalloff(Falloff, 0.001, 0.000);
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

  if (showtoolCloth==true)toolClothdrawing();
  if (showtoolDoor==true)toolDoordrawing();
  if (showtoolGoat==true)toolGoatdrawing();
  if (showtoolWind==true)toolWinddrawing();


  s3d.pushMatrix();
  {
    s3d.noStroke();
    s3d.translate(width/2, height/2);
    s3d.rotateY(radians(252));

    if (vertexNoise==true ) randomVertex(globe);
    else returnVertex(Rglobe, globe);

    if (wireFrameCtl==true) {
      s3d.rotateY((float(frameCount)/100)%360);
      noWireFrame(globe, 2.0f, color(255, 60));
      s3d.blendMode(ADD);
    } else {
      setTexture( globe, tex);
      s3d.blendMode(BLEND);
    }

    s3d.shape(globe);
  }
  s3d.popMatrix();
  s3d.endDraw();
}
