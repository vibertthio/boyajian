
RShape textListen;
boolean showMaskListen =false;
boolean MaskListenIn;

pdLine  MaskListenLine;
pdLine  MaskListenLineIn;
pdLine  MaskListenLineOut;

PShape listen_1;
PShape listen_2;
PShape listen_3;


void maskListenSetting() {

  textListen= RG.getText("音納耳", "wt.ttf", 72, RFont.CENTER);
  MaskListenLineIn=new pdLine(500, 1000);
  MaskListenLineOut=new pdLine(3500, 1000);

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
  MaskListenLineIn.reset();
  MaskListenLineIn.done=false;
  MaskListenLineOut.reset();
}


void maskListendrawing() {
  MaskListenLineIn.update();
  MaskListenLineOut.update();
  showMaskListen=returnState(MaskListenLine, MaskListenIn);
  s3d.pushMatrix();
  {
    //----fade
    if (MaskListenIn==true)s3d.translate(0, map(easeOutBack(MaskListenLine.o), 0, 1, 500, 0));
    else  s3d.translate(0, map(easeInBack(MaskListenLine.o), 0, 1, 0, -500));
    //----fadeEnd
    {//文字開始
      s3d.pushMatrix();
      s3d.translate(width/2, height/2-17, -50);
      s3d.scale(3.0);
      s3d.fill(maskNmae, 155);

      {//文字動畫
       if (MaskListenLineIn.bang==true ) {
          textListen.children[0].transform(40, easeInBack(MaskListenLineIn.oo)*300, 20, 20) ;
          textListen.children[1].transform(97, -easeInBack(MaskListenLineIn.oo)*300, 20, 20) ;
          textListen.children[2].transform(156, easeInBack(MaskListenLineIn.oo)*300, 20, 20) ;
        } else if (MaskListenLineIn.done==true  ) {
          textListen.children[0].transform(40, easeInBack(MaskListenLineOut.o)*300, 20, 20) ;
          textListen.children[1].transform(97, -easeInBack(MaskListenLineOut.o)*300, 20, 20) ;
          textListen.children[2].transform(156, easeInBack(MaskListenLineOut.o)*300, 20, 20) ;
          defultCam();
        }

        if (MaskListenLineOut.bang==false) {
          MaskListenLineIn.done=false;
        }
      }//文字動畫結束

      s3d.strokeWeight(1);
      s3d.noStroke();
      if (MaskListenLineOut.o>0.001 || MaskListenLineIn.o>0.001 )
        if ( MaskListenIn==true )textListen.draw(s3d);
      s3d.popMatrix();
    }//文字結束
    //-----model
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
  }
  s3d.popMatrix();
}
void Listen(boolean theFlag) {
  if (theFlag==true) {
    showMaskListen=false;
    thread("maskListenSetting");
    randomCam();
  } else {
    showMaskListen=true;
    thread("maskListenSetting");
  }
}