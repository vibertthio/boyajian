boolean showMaskTouch =false;
pdLine  MaskTouchLine;
boolean MaskTouchIn;

PShape Touch_1;
PShape Touch_2;
PShape Touch_3;
PShape Touch_4;


void maskTouchSetting() {
  if (showMaskTouch==false) {
    MaskTouchLine=new pdLine(0, 1000);
    MaskTouchIn=true;
    Touch_1 = loadShape("maskTouch/touch_1.obj");
    Touch_2=  loadShape("maskTouch/touch_2.obj");
    Touch_3 = loadShape("maskTouch/touch_3.obj");
    Touch_4 = loadShape("maskTouch/touch_4.obj");
    showMaskTouch =true;
  } else if (showMaskTouch==true) {
    MaskTouchIn=false;
  }
  MaskTouchLine.reset();
}


void maskTouchdrawing() {
  showMaskTouch=returnState(MaskTouchLine, MaskTouchIn);
  s3d.pushMatrix();
  //----fade
  if (MaskTouchIn==true)s3d.translate(0, map(easeOutBack(MaskTouchLine.o), 0, 1, 500, 0));
  else  s3d.translate(0, map(easeInBack(MaskTouchLine.o), 0, 1, 0, -500));
  //----fadeEnd

  s3d.translate(width/2, height/2+100+map(sin(float(frameCount%300)/300*6.28), -1, 1, 0, -50), -50);
  s3d.rotateZ(PI);
  s3d.rotateY(radians(map(sin(float(frameCount%600)/600*6.28), -1, 1, -30, 30)));
  //--------------抖動
  s3d.rotateZ(map(pow(sin(float(frameCount%10)/10*6.28), 8.0), 0, 1, 0, PI*-0.01));
  s3d.scale(0.8);
  //---------------
  s3d.pushMatrix();
  s3d.shape(Touch_1);
  s3d.popMatrix();
  //---------------
  s3d.pushMatrix();
  s3d.shape(Touch_2);
  s3d.popMatrix();
  //---------------
  s3d.pushMatrix();
  s3d.shape(Touch_3);
  s3d.popMatrix();
   //---------------
  s3d.pushMatrix();
  s3d.shape(Touch_4);
  s3d.popMatrix();
  //---------------
  s3d.popMatrix();
}