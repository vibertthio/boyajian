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
PShape Touch_5;

PShape rTouch_1;
PShape rTouch_2;
PShape rTouch_3;
PShape rTouch_4;
PShape rTouch_5;

PImage TouchImg;

float Touch_x, Touch_y;

void maskTouchSetting() {

  textTouch= RG.getText("浮游皮面", "wt.ttf", 72, RFont.CENTER);


  if (showMaskTouch==false) {
    show[7]=1;
    countLife();

    MaskTouchIn=true;

    showMaskTouch =true;
  } else if (showMaskTouch==true) {
    MaskTouchIn=false;
    show[7]=0;
    countLife();
  }

  MaskTouchLineIn=new pdLine(500, 1000);
  MaskTouchLineOut=new pdLine(3500, 1000);
  MaskTouchLine=new pdLine(0, 1000);

  MaskTouchLine.reset();
  MaskTouchLineIn.reset();
  MaskTouchLineIn.done=false;
  MaskTouchLineOut.reset();
}


void maskTouchdrawing() {

  showMaskTouch=returnState(MaskTouchLine, MaskTouchIn);
  s3d.pushMatrix();
  {
    Touch_x=width/2+countX[7].o;

    if (MaskTouchIn==true) Touch_y=height/2+52+map(easeOutBack(MaskTouchLine.o), 0, 1, 500, 0);
    else   Touch_y=height/2+52+map(easeInBack(MaskTouchLine.o), 0, 1, 0, -500);

    s3d.translate(Touch_x, Touch_y+anim(300, 0, -50, 2), -50);

    // s3d.pushMatrix();
    // s3d.translate(40, 0, 0);
    // s3d.fill(maskNmae, 155);
    // MaskTouchLineIn.update();
    // MaskTouchLineOut.update();
    // if (MaskTouchLineIn.bang==true ) {
    //   textTouch.children[0].transform(70, easeInBack(MaskTouchLineIn.oo)*300, 30, 30) ;
    //   textTouch.children[1].transform(102, -easeInBack(MaskTouchLineIn.oo)*300, 30, 30) ;
    //   textTouch.children[2].transform(137, easeInBack(MaskTouchLineIn.oo)*300, 30, 30) ;
    //   textTouch.children[3].transform(172, -easeInBack(MaskTouchLineIn.oo)*300, 30, 30) ;
    // } else if (MaskTouchLineIn.done==true  ) {
    //   textTouch.children[0].transform(70, easeInBack(MaskTouchLineOut.o)*300, 30, 30) ;
    //   textTouch.children[1].transform(102, -easeInBack(MaskTouchLineOut.o)*300, 30, 30) ;
    //   textTouch.children[2].transform(137, easeInBack(MaskTouchLineOut.o)*300, 30, 30) ;
    //   textTouch.children[3].transform(172, -easeInBack(MaskTouchLineOut.o)*300, 30, 30) ;
    //   defultCam();
    // }
    //
    // if (MaskTouchLineOut.bang==false) MaskTouchLineIn.done=false;
    // if (MaskTouchLineOut.o<0.99 && MaskTouchLineIn.o>0.001 && MaskTouchIn==true )textTouch.draw(s3d);
    // s3d.popMatrix();

    s3d.rotateZ(PI);
    s3d.rotateY(radians(map(sin(float(frameCount%600)/600*6.28), -1, 1, -30, 30)));
    //--------------抖動
    s3d.rotateZ(map(pow(sin(float(frameCount%10)/10*6.28), 8.0), 0, 1, 0, PI*-0.01));
    s3d.scale(0.50);
    //---------------
    // s3d.pushMatrix();
    // s3d.shape(Touch_1);
    // s3d.popMatrix();
    // //---------------
    // s3d.pushMatrix();
    // s3d.shape(Touch_2);
    // s3d.popMatrix();
    //---------------
    s3d.pushMatrix();

    if (vertexNoise==true) randomVertex(Touch_3);
    else returnVertex(rTouch_3, Touch_3);

    s3d.shape(Touch_3);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    if (vertexNoise==true) randomVertex(Touch_4);
    else returnVertex(rTouch_4, Touch_4);
    s3d.shape(Touch_4);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    for (int i=0; i<10; i++) {
      s3d.pushMatrix();
      if (i<5) {
        s3d.translate(60, i*60-30, 0);
      } else {
        s3d.translate(-60, i*60-30-5*60, 0);
      }
      if (vol>0.8) {
        s3d.scale(1, 1, random(1, 3));
      } else {
        s3d.scale(1);
      }

      if (vertexNoise==true) randomVertex(Touch_5);
      else returnVertex(rTouch_5, Touch_5);

      s3d.shape(Touch_5);
      s3d.popMatrix();
    }

    s3d.popMatrix();
    //---------------
  }
  s3d.popMatrix();
  if (wireFrameCtl==true) {
    // noWireFrame( Touch_1, random(1.80, 2.40), color(255, 120));
    // noWireFrame( Touch_2, random(1.80, 2.40), color(255, 120));
    noWireFrame( Touch_3, random(1.80, 2.40), color(255, 120));
    noWireFrame( Touch_4, random(1.80, 2.40), color(255, 120));
    noWireFrame( Touch_5, random(1.80, 2.40), color(255, 120));
  } else {
    // setTexture( Touch_1, TouchImg);
    // setTexture( Touch_2, TouchImg);
    setTexture(Touch_3, TouchImg);
    setTexture(Touch_4, TouchImg);
    setTexture(Touch_5, TouchImg);
  }
}

void Touch(boolean theFlag) {
  if (theFlag==true) {
    showMaskTouch=false;
    thread("maskTouchSetting");
    //randomCam();
  } else {
    showMaskTouch=true;
    thread("maskTouchSetting");
  }
}
