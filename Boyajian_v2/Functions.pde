
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
  textSize(26);

  String F="F:"+int((int(frameRate/4))*4);
  String B=indexSelectBlend [blendIndex]  + ":" + blendNames[ indexSelectBlend [blendIndex]  ];
  String I="bgs:" +imgIndex;
  //text(F, 50, 50);
  //text(B, 50, 100 );
  //text(I, 50, 150 );

  fill(0);
  for (int x = -2; x < 3; x++) {
    for (int i = 1; i <= F.length(); i++) {
      text(F.substring(i-1, i), 50+x+i*18, 50);
    }
    for (int i = 1; i <= F.length(); i++) {
      text(F.substring(i-1, i), 50+i*18, 50+x);
    }
  }
  fill(255);
  for (int i = 1; i <= F.length(); i++) {
    text(F.substring(i-1, i), 50+i*18, 50);
  }


  fill(0);
  for (int x = -2; x < 3; x++) {
    for (int i = 1; i <= B.length(); i++) {
      text(B.substring(i-1, i), 50+x+i*18, 100);
    }
    for (int i = 1; i <= B.length(); i++) {
      text(B.substring(i-1, i), 50+i*18, 100+x);
    }
  }
  fill(255);
  for (int i = 1; i <= B.length(); i++) {
    text(B.substring(i-1, i), 50+i*18, 100);
  }


  fill(0);
  for (int x = -2; x < 3; x++) {
    for (int i = 1; i <= I.length(); i++) {
      text(I.substring(i-1, i), 50+x+i*18, 150);
    }
    for (int i = 1; i <= I.length(); i++) {
      text(I.substring(i-1, i), 50+i*18, 150+x);
    }
  }
  fill(255);
  for (int i = 1; i <= I.length(); i++) {
    text(I.substring(i-1, i), 50+i*18, 150);
  }
}

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

void s3dDrawing() {
  a1=(a1+1)%360;
  a2=(a1+1)%180;
  a3=(a1+1)%150;

  s3d.beginDraw();
  s3d.background(255, 0);
  {
    s3d.setMatrix(getMatrix()); // replace the PGraphics-matrix
    s3d.beginCamera();
    s3d.camera( camX + camZ*sin(rotX), camY + camZ*sin(rotY), camZ*cos(rotY)*cos(rotX), camX, camY, 0, 0, 1, 0);  
    //println(rotX, rotY, camX, camY, camZ);
    s3d.endCamera();

    if (resetCamDo==true)resetCam();
  }
  GL2 gl = ((PJOGL)beginPGL()).gl.getGL2();
  gl.glEnable(GL2.GL_BLEND);
  gl.glBlendFunc(GL2.GL_SRC_ALPHA, GL2.GL_ONE_MINUS_SRC_ALPHA);

  gl.glHint( GL2.GL_POLYGON_SMOOTH_HINT, GL2.GL_NICEST );
  gl.glEnable(GL2.GL_ALPHA_TEST);
  gl.glAlphaFunc(GL2.GL_GREATER, 0.1);
  endPGL();

  if (showMaskEye==true) {
    maskEyedrawing();
  }

  if (showMaskListen==true) {
    maskListendrawing();
  }

  if (showMaskSmell==true) {
    maskSmelldrawing();
  }

  if (showMaskTouch==true) {
    maskTouchdrawing();
  }

  s3d.pushMatrix();
  s3d.noStroke();
  s3d.translate(width/2, height/2); 
  s3d.rotateY(radians(287)); 
  s3d.shape(globe);
  s3d.popMatrix();

  s3d.endDraw();
}

void resetCam() {
  float dcX = 600 - camX;
  camX+=dcX*easing;
  camX=float(int(camX*1000))/1000;

  float dcY = 200 - camY;
  camY+=dcY*easing;
  camY=float(int(camY*1000))/1000;

  float dcZ = 430 - camZ;
  camZ+=dcZ*easing;
  camZ=float(int(camZ*1000))/1000;

  float drX = 0 - rotX;
  rotX+=drX*easing;
  rotX=float(int(rotX*1000))/1000;

  float drY = 0 - rotY;
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