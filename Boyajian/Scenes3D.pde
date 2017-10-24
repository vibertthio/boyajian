//Scenes3D.pde

float rotX=0;
float rotY=0;
float camX=600;
float camY=200;
float camZ=430;
float easing = 0.02;

float[] cam={960, 200, 430, 0, 0};


PImage eyeParticle;
PImage earParticle;
PImage earParticle_1;
PImage black;
PImage grid;

PShape globe;
PShape Rglobe;

PShape globe2;
PShape Rglobe2;

PMatrix mat_scene;
float randomVel=2;

boolean holdVertex=true;
boolean wireFrameCtl=false;
boolean vertexNoise=false;
boolean resetCamDo=false;
color maskNmae=color(255);

EyeGroup[] eyeGroups;
EarGroup[] earGroups;

float showEyeParticle=0;
float showEarParticle=0;
float showLine=0;
float showCylinder=0;

float ctl32=0;
float ctl33=0;


int eyeNum = 200;
int earNum = 40;
PVector parentPos;
Form forms;
Cylinder cylinders;


void s3dSetting() {
  mat_scene = getMatrix();
  eyeParticle=loadImage("img/p_eye.png");
  earParticle=loadImage("img/p_smell.png");
  earParticle_1=loadImage("img/p_smell_1.png");
  black=loadImage("img/black.png");
  grid=loadImage("img/grid.png");

  eyeGroups = new EyeGroup[eyeNum];
  earGroups = new EarGroup[earNum];
  forms= new Form();
  cylinders= new Cylinder();
  for (int i = 0; i < eyeNum; i++) {
    PVector p = new PVector(random(-600, 600)+width/2, random(-300, 300)+height/2, random(-400, 400));
    eyeGroups[i] = new EyeGroup(p);
  }

  for (int i = 0; i < earNum; i++) {
    PVector p = new PVector(width/2+posAvg(1200, earNum, i)-600, height/2, -90);
    earGroups[i] = new EarGroup(p);
  }

  globe = loadShape("3d/sphere2.obj");
  Rglobe = loadShape("3d/sphere2.obj");

  globe2 = loadShape("3d/sphere.obj");
  Rglobe2= loadShape("3d/sphere.obj");
}

float  Falloff=1.8;


void s3dDrawing() {

  s3d.beginDraw();
  s3d.smooth();
  s3d.background(0, 2);
  if (vertexNoise==true && holdVertex==false) {
    if (randomVel<50) randomVel=(randomVel+(randomVel/200));
  } else if (vertexNoise==false) {
    if (randomVel>2) randomVel=(randomVel-0.1);
  }
  if (mousePressed) {
    //showEyeParticle=200;
    //showEarParticle=200;
  }

  if (showEyeParticle>1) {
    for (int i = 0; i < eyeNum; i++) {
      eyeGroups[i].run();
    }
  }

  if (showEarParticle>1) {
    for (int i = 0; i < earNum; i++) {
      earGroups[i].run();
    }
  }

  if (showLine>1) forms.render(s3d);
  if (showCylinder>1) cylinders.render(s3d);

  s3d.setMatrix(getMatrix()); // replace the PGraphics-matrix
  s3d.lightFalloff(Falloff, 0.001, 0.000);
  s3d.directionalLight(255, 256, 255, 0, -100, -300);
  s3d.pointLight(155, 155, 155, 300, 200, 300);
  s3d.ambientLight(73, 52, 20);
  s3d.beginCamera();
  s3d.camera( camX + camZ*sin(rotX), camY + camZ*sin(rotY), camZ*cos(rotY)*cos(rotX), camX, camY, 0, 0, 1, 0);
  //println(rotX, rotY, camX, camY, camZ);
  parentPos=new PVector(camX + camZ*sin(rotX), camY + camZ*sin(rotY), camZ*cos(rotY)*cos(rotX));
  s3d.endCamera();
  if (resetCamDo==true)resetCam(cam[0], cam[1], cam[2], cam[3], cam[4]);
  // if (mousePressed) {
  //   s3d.stroke(255, 0, 0);
  //   s3d.strokeWeight(2);
  //   s3d.line(width/2, height/2, 0, width/2+200, height/2, 0);
  //   s3d.stroke(0, 255, 0);
  //   s3d.line(width/2, height/2, 0, width/2, height/2-200, 0);
  //   s3d.stroke(0, 0, 255);
  //   s3d.line(width/2, height/2, 0, width/2, height/2, 200);
  //   s3d.pushMatrix();
  //   s3d.stroke(255);
  //   s3d.translate(width/2, height/2, 0);
  //   s3d.sphere(5);
  //   s3d.popMatrix();
  // }

  GL2 gl = ((PJOGL)beginPGL()).gl.getGL2();
  gl.glEnable(GL2.GL_BLEND);
  gl.glBlendFunc(GL2.GL_SRC_ALPHA, GL2.GL_ONE_MINUS_SRC_ALPHA);

  gl.glHint( GL2.GL_POLYGON_SMOOTH_HINT, GL2.GL_NICEST );
  gl.glEnable(GL2.GL_ALPHA_TEST);
  gl.glAlphaFunc(GL2.GL_GREATER, 0.1);


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

  s3d.pushMatrix();//--------------------
  s3d.noStroke();
  s3d.translate(width/2, height/2);
  s3d.rotateY(radians(186));
  s3d.blendMode(ADD );

  if (vertexNoise==true ) randomVertex(globe);
  else returnVertex(Rglobe, globe);

  if (vertexNoise==true ) randomVertex(globe2);
  else returnVertex(Rglobe2, globe2);

  if (wireFrameCtl==true) {
    //s3d.rotateY((float(frameCount)/100)%360);
    noWireFrame(globe, 2.0f, color(255, 60));
    s3d.blendMode(ADD);
  } else {
    setTexture(globe, tex);
  }

  if (vertexNoise==true) {
    //addWireFrame(globe);
  }

  s3d.shape(globe);

  if (wireFrameCtl==true) {
    //s3d.rotateY((float(frameCount)/200)%360);
    s3d.stroke(255);
    s3d.fill(255);
    noWireFrame(globe2, 2.0f, color(0, 165, 250, 120));
    s3d.blendMode(ADD);
  } else {
    globe2.setStroke(true);
    setTexture(globe2, tex2);
  }
  s3d.pushMatrix();//--------------------
  s3d.rotateY(radians(75));
  s3d.rotateZ(radians(anim(600, -10, 10, 2)));
  s3d.scale(1.45*map(ctl33,0,255,1,0.1));

  s3d.shape(globe2);
  s3d.popMatrix();//--------------------

  s3d.blendMode(BLEND);
  s3d.popMatrix();//--------------------
  s3d.endDraw();
  endPGL();
}

void addWireFrame(PShape who) {
  who.setStroke(color(35, 255));
  who.setStrokeWeight(1.8);
  who.setStroke(true);
}
