
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

void s3dDrawing() {

  s3d.beginDraw();
  s3d.background(0, 0, 0, 0);
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
  s3d.endDraw();
}