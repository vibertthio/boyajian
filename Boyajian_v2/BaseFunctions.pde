
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

void randomVertex(PShape who) {
  for (int j=0; j<who.getChildCount(); j++) {
    for (int i = 0; i < who.getChild(j).getVertexCount(); i++) {
      PVector v = who.getChild(j).getVertex(i);
      v.x += random(-6, 6);
      v.y += random(-6, 6);
      v.z += random(-6, 6);
      who.getChild(j).setVertex(i, v);
    }
  }
}

void returnVertex(PShape origon, PShape who) {
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
    .setSize(40, 20);

  Group MaskToggle = cp5.addGroup("MaskToggle")
    .setPosition(40, 350)
    .setBackgroundHeight(40)
    .setWidth(400)
    .setBackgroundColor(color(255, 50))
    ;


  cp5.addToggle("Eye")
    .setPosition(10, 5)
    .setSize(30, 20)
    .setGroup(MaskToggle);  
  cp5.addToggle("Smell")
    .setPosition(60, 5)
    .setSize(30, 20) 
    .setGroup(MaskToggle);
  cp5.addToggle("Listen")
    .setPosition(110, 5)
    .setSize(30, 20)
    .setGroup(MaskToggle);
  cp5.addToggle("Touch")
    .setPosition(160, 5)
    .setSize(30, 20)
    .setGroup(MaskToggle);
  cp5.addToggle("Taste")
    .setPosition(210, 5)
    .setSize(30, 20)
    .setGroup(MaskToggle);
  cp5.addToggle("Memory")
    .setPosition(260, 5)
    .setSize(30, 20)
    .setGroup(MaskToggle);
  cp5.addToggle("Dream")
    .setPosition(310, 5)
    .setSize(30, 20)
    .setGroup(MaskToggle);
  cp5.addToggle("Faces")
    .setPosition(360, 5)
    .setSize(30, 20) 
    .setGroup(MaskToggle);
}