
boolean returnState(pdLine l, boolean in) {
  l.update();
  boolean temp=true;
  if (in==true) {
    if (l.done==true) {
      l.done=false;
      temp= true;
    }
  } else if (in==false ) {//fadeout時關閉算圖
    if (l.done==true) {
      temp= false;
    }
  }
  return temp;
}


void showFrameRate() {
  blendMode(BLEND);
  textSize(16);

  String F="F:"+int((int(frameRate/4))*4);
  String B=indexSelectBlend [blendIndex]  + ":" + blendNames[ indexSelectBlend [blendIndex]  ];
  String I="bgs:" +imgIndex;
  //text(F, 50, 50);
  //text(B, 50, 100 );
  //text(I, 50, 150 );


  fill(255);
  text(F, 50, 50);
  text(B, 50, 70);
  text(I, 50, 90);
}



void resetCam(float x, float y, float z, float rx, float ry) {
  float dcX = x - camX;
  camX+=dcX*easing;
  camX=float(int(camX*1000))/1000;

  float dcY = y - camY;
  camY+=dcY*easing;
  camY=float(int(camY*1000))/1000;

  float dcZ = z - camZ;
  camZ+=dcZ*easing;
  camZ=float(int(camZ*1000))/1000;

  float drX = rx - rotX;
  rotX+=drX*easing;
  rotX=float(int(rotX*1000))/1000;

  float drY = ry - rotY;
  rotY+=drY*easing;
  rotY=float(int(rotY*1000))/1000;

  if (abs(dcX)<1 && abs(dcY)<1 && abs(dcZ)<1 && abs(rotX)<0.01 && abs(rotY)<0.01) {
    resetCamDo=false;
  }
}


void autoChBg() {
  if ( frameCount % 100 == 0  ) {
    blendIndex = ( blendIndex + 1 ) % 10;
  }
  if ( frameCount % 300 == 0  ) {
    imgIndex = ( imgIndex + 1 ) % 5;
    blendGLSL.set( "lowLayer", bgs [imgIndex]);
  }
}

float randomVel=6;
void randomVertex(PShape who) {

  if (randomVel<30) {
    randomVel=randomVel+0.1;
  }
  println(randomVel);
  for (int j=0; j<who.getChildCount(); j++) {
    for (int i = 0; i < who.getChild(j).getVertexCount(); i++) {
      PVector v = who.getChild(j).getVertex(i);
      v.x += random(-randomVel, randomVel);
      v.y += random(-randomVel, randomVel);
      v.z += random(-randomVel, randomVel);
      who.getChild(j).setVertex(i, v);
    }
  }
}

void returnVertex(PShape origon, PShape who) {
  if (randomVel>6) {
    randomVel=randomVel-0.1;
  }
  for (int j=0; j<origon.getChildCount(); j++) {
    for (int i = 0; i < origon.getChild(j).getVertexCount(); i++) {
      PVector v = origon.getChild(j).getVertex(i);
      PVector v1 = who.getChild(j).getVertex(i);

      v1.x =(v.x-v1.x)*0.05 +v1.x;
      v1.y =(v.y-v1.y)*0.05 +v1.y;
      v1.z =(v.z-v1.z)*0.05 +v1.z;
      who.getChild(j).setVertex(i, v1);
    }
  }
}

void uiSetting() {
  //---------------*控制開關
  cp5 = new ControlP5(this);
  cp5.addToggle("showPtn")
    .setPosition(40, 300)
    .setSize(40, 20)
    .setId(0)
    ;
  cp5.addToggle("l3Rt")
    .setPosition(40, 250)
    .setSize(40, 20)
    .setId(1)
    ;
  cp5.addToggle("l3Sw")
    .setPosition(100, 250)
    .setSize(40, 20)
    .setId(2)
    ;
  cp5.addToggle("autoCam")
    .setPosition(160, 250)
    .setSize(40, 20)
    .setId(2)
    ;

  //Group MaskToggle = cp5.addGroup("MaskToggle")
  //  .setPosition(40, 350)
  //  .setBackgroundHeight(40)
  //  .setWidth(400)
  //  .setBackgroundColor(color(255, 50))
  //  ;


  cp5.addToggle("Eye")
    .setPosition(10, 350)
    .setSize(30, 20);

  cp5.addToggle("Smell")
    .setPosition(60, 350)
    .setSize(30, 20);

  cp5.addToggle("Listen")
    .setPosition(110, 350)
    .setSize(30, 20);

  cp5.addToggle("Touch")
    .setPosition(160, 350)
    .setSize(30, 20);

  cp5.addToggle("Taste")
    .setPosition(210, 350)
    .setSize(30, 20);

  cp5.addToggle("Memory")
    .setPosition(260, 350)
    .setSize(30, 20);

  cp5.addToggle("Dream")
    .setPosition(310, 350)
    .setSize(30, 20);

  cp5.addToggle("Faces")
    .setPosition(360, 350)
    .setSize(30, 20);

  cp5.addToggle("SwordA")
    .setPosition(420, 350)
    .setSize(30, 20);

  cp5.addToggle("SwordB")
    .setPosition(480, 350)
    .setSize(30, 20);
  cp5.addToggle("ShieldA")
    .setPosition(540, 350)
    .setSize(30, 20);

  cp5.addToggle("ShieldB")
    .setPosition(600, 350)
    .setSize(30, 20);

  //------------------

  cp5.addBang("no")
    .setPosition(100, 300)
    .setSize(40, 20)
    .setColorActive(color(155))
    .setColorForeground(color(155, 0, 0))
    .setId(1)
    ;
  cp5.addBang("blur")
    .setPosition(160, 300)
    .setSize(40, 20)
    .setColorActive(color(155))
    .setColorForeground(color(155, 0, 0))
    .setId(2)
    ;
  cp5.addBang("rgb1")
    .setPosition(220, 300)
    .setSize(40, 20)
    .setColorActive(color(155))
    .setColorForeground(color(155, 0, 0))
    .setId(3)
    ;
  cp5.addBang("rgb2")
    .setPosition(280, 300)
    .setSize(40, 20)
    .setColorActive(color(155))
    .setColorForeground(color(155, 0, 0))
    .setId(4)
    ;
  cp5.addBang("noisy")
    .setPosition(340, 300)
    .setSize(40, 20)
    .setColorActive(color(155))
    .setColorForeground(color(155, 0, 0))
    .setId(4)
    ;
  cp5.addBang("glitch")
    .setPosition(400, 300)
    .setSize(40, 20)
    .setColorActive(color(155))
    .setColorForeground(color(155, 0, 0))
    .setId(4)
    ;
}

public void controlEvent(ControlEvent theEvent) {
  if (theEvent.getController().getName().equals("no")) {
    effectGLSL = loadShader("glsl/no.glsl");
  }
  if (theEvent.getController().getName().equals("blur")) {
    effectGLSL = loadShader("glsl/radialBlur.glsl");
    effectGLSL.set("vol", 1.0);
  }
  if (theEvent.getController().getName().equals("rgb1")) {
    effectGLSL = loadShader("glsl/rgbGlitch_1.glsl");
    effectGLSL.set("vol", 1.0);
  }

  if (theEvent.getController().getName().equals("rgb2")) {
    effectGLSL = loadShader("glsl/rgbGlitch_2.glsl");
    effectGLSL.set("vol", 1.0);
  }

  if (theEvent.getController().getName().equals("noisy")) {
    effectGLSL = loadShader("glsl/Noisy_Mirror.frag");
    effectGLSL.set("vol", 0.4);
  }

  if (theEvent.getController().getName().equals("glitch")) {
    effectGLSL = loadShader("glsl/glitch.glsl");
    effectGLSL.set("vol", 0.6);
  }
}

void l3Rt(boolean theFlag) {
  if (theFlag==true) logo3Rotating=true;
  else logo3Rotating=false;
}

void l3Sw(boolean theFlag) {
  if (theFlag==true) logo3Changing=true;
  else logo3Changing=false;
}

void autoCam(boolean theFlag) {
  if (theFlag==true) autoCamMetro.tgl=true;
  else {
    autoCamMetro.tgl=false;
    defultCam();
  }
}

void countLife() {
  int k=0;
  int kk=0;
  for (int i=0; i<20; i++) k=k+show[i];

  for (int i=0; i<20; i++) if (show[i]==1) {
      kk++;
      countX[i].reset(posAvg(1000,k,kk)-500);
    }

}

float anim(int num,float start,float end,float pp) {
  return map(pow(sin((float(frameCount)%num)/num*6.28), pp), 0, 1, start, end);
}
