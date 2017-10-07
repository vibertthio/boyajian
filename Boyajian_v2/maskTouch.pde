RShape textTouch;
boolean showMaskTouch =false;
boolean MaskTouchIn;

pdLine  MaskTouchLine;
pdLine  MaskTouchLineIn;
pdLine  MaskTouchLineOut;

PShape Touch_1;
PShape Touch_2;
PShape Touch_3;
PShape Touch_4;


void maskTouchSetting() {

  textTouch= RG.getText("浮游皮面", "wt.ttf", 72, RFont.CENTER);
  MaskTouchLineIn=new pdLine(500, 1000);
  MaskTouchLineOut=new pdLine(3500, 1000);

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
  MaskTouchLineIn.reset();
  MaskTouchLineIn.done=false;
  MaskTouchLineOut.reset();
}


void maskTouchdrawing() {
  MaskTouchLineIn.update();
  MaskTouchLineOut.update();
  showMaskTouch=returnState(MaskTouchLine, MaskTouchIn);
  s3d.pushMatrix();
  {
  //----fade
  if (MaskTouchIn==true)s3d.translate(0, map(easeOutBack(MaskTouchLine.o), 0, 1, 500, 0));
  else  s3d.translate(0, map(easeInBack(MaskTouchLine.o), 0, 1, 0, -500));
  //----fadeEnd

  {//文字開始
    s3d.pushMatrix();
    s3d.translate(width/2, height/2-17, -50);
    s3d.scale(3.0);
    s3d.fill(color(0.72*255, 0.53*255, 0.0*255), 155);

    {//文字動畫
       if (MaskTouchLineIn.bang==true ) {
          textTouch.children[0].transform(70, easeInBack(MaskTouchLineIn.oo)*300, 20, 20) ;
          textTouch.children[1].transform(102, -easeInBack(MaskTouchLineIn.oo)*300, 20, 20) ;
          textTouch.children[2].transform(137, easeInBack(MaskTouchLineIn.oo)*300, 20, 20) ;
          textTouch.children[3].transform(172, -easeInBack(MaskTouchLineIn.oo)*300, 20, 20) ;
        } else if (MaskTouchLineIn.done==true  ) {
          textTouch.children[0].transform(70, easeInBack(MaskTouchLineOut.o)*300, 20, 20) ;
          textTouch.children[1].transform(102, -easeInBack(MaskTouchLineOut.o)*300, 20, 20) ;
          textTouch.children[2].transform(137, easeInBack(MaskTouchLineOut.o)*300, 20, 20) ;
          textTouch.children[3].transform(172, -easeInBack(MaskTouchLineOut.o)*300, 20, 20) ;
          defultCam();
        }

      if (MaskTouchLineOut.bang==false) {
        MaskTouchLineIn.done=false;
      }
    }//文字動畫結束

    s3d.strokeWeight(1);
    s3d.noStroke();
    if (MaskTouchLineOut.o>0.001 || MaskTouchLineIn.o>0.001 )
      if ( MaskTouchIn==true )textTouch.draw(s3d);
    s3d.popMatrix();
  }//文字結束
  //-----model

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
  }
  s3d.popMatrix();
}

void Touch(boolean theFlag) {
  if (theFlag==true) {
    showMaskTouch=false;
    thread("maskTouchSetting");
    randomCam();
  } else {
    showMaskTouch=true;
    thread("maskTouchSetting");
  }
}
