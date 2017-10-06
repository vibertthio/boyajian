RShape textDream;
boolean showMaskDream =false;
boolean MaskDreamIn;

pdLine  MaskDreamLine;
pdLine  MaskDreamLineIn;
pdLine  MaskDreamLineOut;

PShape Dream_1;
PShape Dream_2;
PShape Dream_3;
PShape Dream_4;
PShape Dream_5;
PShape Dream_6;


void maskDreamSetting() {

  textDream= RG.getText("食夢術士", "wt.ttf", 72, RFont.CENTER);
  MaskDreamLineIn=new pdLine(500, 1000);
  MaskDreamLineOut=new pdLine(3500, 1000);

  if (showMaskDream==false) {
    MaskDreamLine=new pdLine(0, 1000);
    MaskDreamIn=true;
    Dream_1 = loadShape("maskDream/dream_1.obj");
    Dream_2=  loadShape("maskDream/dream_2.obj");
    Dream_3 = loadShape("maskDream/dream_3.obj");
    Dream_4 = loadShape("maskDream/dream_4.obj");
    Dream_5 = loadShape("maskDream/dream_5.obj");
    Dream_6 = loadShape("maskDream/dream_6.obj");

    showMaskDream =true;
  } else if (showMaskDream==true) {
    MaskDreamIn=false;
  }
  MaskDreamLine.reset();
  MaskDreamLineIn.reset();
  MaskDreamLineIn.done=false;
  MaskDreamLineOut.reset();
}


void maskDreamdrawing() {
  MaskDreamLineIn.update();
  MaskDreamLineOut.update();
  showMaskDream=returnState(MaskDreamLine, MaskDreamIn);
  s3d.pushMatrix();
  {
  //----fade
  if (MaskDreamIn==true)s3d.translate(0, map(easeOutBack(MaskDreamLine.o), 0, 1, 500, 0));
  else  s3d.translate(0, map(easeInBack(MaskDreamLine.o), 0, 1, 0, -500));
  //----fadeEnd

  {//文字開始
    s3d.pushMatrix();
    s3d.translate(width/2, height/2+125, -50);
    s3d.scale(3.0);
    s3d.fill(color(0.72*255, 0.53*255, 0.0*255), 155);

    {//文字動畫
      if (MaskDreamLineIn.bang==true ) {
        textDream.children[0].transform(-162, easeInBack(MaskDreamLineIn.oo)*300, 36, 36) ;
        textDream.children[1].transform(-81, -easeInBack(MaskDreamLineIn.oo)*300, 36, 36) ;
        textDream.children[2].transform(38, easeInBack(MaskDreamLineIn.oo)*300, 36, 36) ;
        textDream.children[3].transform(122, -easeInBack(MaskDreamLineIn.oo)*300, 36, 36) ;
      } else if (MaskDreamLineIn.done==true  ) {
        textDream.children[0].transform(-162, easeInBack(MaskDreamLineOut.o)*300, 36, 36) ;
        textDream.children[1].transform(-81, -easeInBack(MaskDreamLineOut.o)*300, 36, 36) ;
        textDream.children[2].transform(38, easeInBack(MaskDreamLineOut.o)*300, 36, 36) ;
        textDream.children[3].transform(122, -easeInBack(MaskDreamLineOut.o)*300, 36, 36) ;
      }

      if (MaskDreamLineOut.bang==false) {
        MaskDreamLineIn.done=false;
      }
    }//文字動畫結束

    s3d.strokeWeight(1);
    s3d.noStroke();
    if (MaskDreamLineOut.o>0.001 || MaskDreamLineIn.o>0.001 )
      if ( MaskDreamIn==true )textDream.draw(s3d);
    s3d.popMatrix();
  }//文字結束
  //-----model

  s3d.translate(width/2, height/2+50+map(sin(float(frameCount%300)/300*6.28), -1, 1, 0, -50), -50);
  s3d.rotateZ(PI);
  s3d.rotateY(radians(map(sin(float(frameCount%600)/600*6.28), -1, 1, -30, 30)));
  //--------------抖動
  s3d.rotateZ(map(pow(sin(float(frameCount%10)/10*6.28), 8.0), 0, 1, 0, PI*-0.01));
  s3d.scale(0.8);
  //---------------
  s3d.pushMatrix();
  s3d.shape(Dream_1);
  s3d.popMatrix();
  //---------------
  s3d.pushMatrix();
  s3d.shape(Dream_2);
  s3d.popMatrix();
  //---------------
  s3d.pushMatrix();
  s3d.shape(Dream_3);
  s3d.popMatrix();
   //---------------
  s3d.pushMatrix();
  s3d.shape(Dream_4);
  s3d.popMatrix();
  //---------------
  s3d.pushMatrix();
  s3d.shape(Dream_5);
  s3d.popMatrix();
  //---------------
  s3d.pushMatrix();
  s3d.shape(Dream_6);
  s3d.popMatrix();
  //---------------
  }
  s3d.popMatrix();
}

void Dream(boolean theFlag) {
  if (theFlag==true) {
    showMaskDream=false;
    thread("maskDreamSetting");
  } else {
    showMaskDream=true;
    thread("maskDreamSetting");
  }
}