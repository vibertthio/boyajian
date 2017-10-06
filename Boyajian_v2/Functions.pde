
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