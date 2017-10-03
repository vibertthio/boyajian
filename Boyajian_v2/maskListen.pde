boolean showMaskListen =false;
pdLine  MaskListenLine;
boolean MaskListenIn;

PShape listen_1;
PShape listen_2;
PShape listen_3;


void maskListenSetting() {
  if (showMaskListen==false) {
    MaskListenLine=new pdLine(0, 1000);
    MaskListenIn=true;
    listen_1 = loadShape("maskListen/listen_1.obj");
    listen_2=  loadShape("maskListen/listen_2.obj");
    listen_3 = loadShape("maskListen/listen_3.obj");
    showMaskListen =true;
  } else if (showMaskListen==true) {
    MaskListenIn=false;
  }
  MaskListenLine.reset();
}


void maskListendrawing() {
  showMaskListen=returnState(MaskListenLine, MaskListenIn);
  s3d.pushMatrix();
  //----fade
  if (MaskListenIn==true)s3d.translate(0, map(easeOutBack(MaskListenLine.o), 0, 1, 500, 0));
  else  s3d.translate(0, map(easeInBack(MaskListenLine.o), 0, 1, 0, -500));
  //----fadeEnd

  s3d.translate(width/2, height/2+50+map(sin(float(frameCount%300)/300*6.28), -1, 1, 0, -50), -50);
  s3d.rotateZ(PI);
  s3d.rotateY(radians(map(sin(float(frameCount%600)/600*6.28), -1, 1, -30, 30)));
  //--------------抖動
  s3d.rotateZ(map(pow(sin(float(frameCount%10)/10*6.28), 8.0), 0, 1, 0, PI*-0.01));
  s3d.scale(0.55);
  //---------------
  s3d.pushMatrix();

  s3d.shape(listen_1);
  s3d.popMatrix();
  //---------------
  s3d.pushMatrix();

  s3d.shape(listen_2);
  s3d.popMatrix();
  //---------------
  s3d.pushMatrix();

  s3d.shape(listen_3);
  s3d.popMatrix();
  //---------------
  s3d.popMatrix();
}