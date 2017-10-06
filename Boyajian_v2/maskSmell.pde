RShape textSmell;
boolean showMaskSmell =false;
boolean MaskSmellIn;

pdLine  MaskSmellLine;
pdLine  MaskSmellLineIn;
pdLine  MaskSmellLineOut;

PShape Smell_1;
PShape Smell_2;
PShape Smell_3;


void maskSmellSetting() {

  textSmell= RG.getText("氣嗅者", "wt.ttf", 72, RFont.CENTER);
  MaskSmellLineIn=new pdLine(500, 1000);
  MaskSmellLineOut=new pdLine(3500, 1000);

  if (showMaskSmell==false) {
    MaskSmellLine=new pdLine(0, 1000);
    MaskSmellIn=true;
    Smell_1 = loadShape("maskSmell/smell_1.obj");
    Smell_2=  loadShape("maskSmell/smell_2.obj");
    Smell_3 = loadShape("maskSmell/smell_3.obj");
    showMaskSmell =true;
  } else if (showMaskSmell==true) {
    MaskSmellIn=false;
  }
  MaskSmellLine.reset();
  MaskSmellLineIn.reset();
  MaskSmellLineIn.done=false;
  MaskSmellLineOut.reset();
}


void maskSmelldrawing() {
  MaskSmellLineIn.update();
  MaskSmellLineOut.update();
  showMaskSmell=returnState(MaskSmellLine, MaskSmellIn);
  s3d.pushMatrix();
  {
    //----fade
    if (MaskSmellIn==true)s3d.translate(0, map(easeOutBack(MaskSmellLine.o), 0, 1, 500, 0));
    else  s3d.translate(0, map(easeInBack(MaskSmellLine.o), 0, 1, 0, -500));
    //----fadeEnd
    {//文字開始
      s3d.pushMatrix();
      s3d.translate(width/2, height/2+125, -50);
      s3d.scale(3.0);
      s3d.fill(color(0.72*255, 0.53*255, 0.0*255), 155);

      {//文字動畫
        if (MaskSmellLineIn.bang==true ) {
          textSmell.children[0].transform(-109, easeInBack(MaskSmellLineIn.oo)*300, 36, 36) ;
          textSmell.children[1].transform(-16, -easeInBack(MaskSmellLineIn.oo)*300, 36, 36) ;
          textSmell.children[2].transform(74, easeInBack(MaskSmellLineIn.oo)*300, 36, 36) ;
        } else if (MaskSmellLineIn.done==true  ) {
          textSmell.children[0].transform(-109, easeInBack(MaskSmellLineOut.o)*300, 36, 36) ;
          textSmell.children[1].transform(-16, -easeInBack(MaskSmellLineOut.o)*300, 36, 36) ;
          textSmell.children[2].transform(74, easeInBack(MaskSmellLineOut.o)*300, 36, 36) ;
        }

        if (MaskSmellLineOut.bang==false) {
          MaskSmellLineIn.done=false;
        }
      }//文字動畫結束

      s3d.strokeWeight(1);
      s3d.noStroke();
      if (MaskSmellLineOut.o>0.001 || MaskSmellLineIn.o>0.001 )
        if ( MaskSmellIn==true )textSmell.draw(s3d);
      s3d.popMatrix();
    }//文字結束
    //-----model

    s3d.translate(width/2, height/2+map(sin(float(frameCount%300)/300*6.28), -1, 1, 0, -50), -50);
    s3d.rotateZ(PI);
    s3d.rotateY(radians(map(sin(float(frameCount%600)/600*6.28), -1, 1, -30, 30)));
    //--------------抖動
    s3d.rotateZ(map(pow(sin(float(frameCount%10)/10*6.28), 8.0), 0, 1, 0, PI*-0.01));
    s3d.scale(0.8);
    //---------------
    s3d.pushMatrix();
    s3d.translate(0, map(pow(sin(a2/180*6.28), 8.0), 0, 1, 0, -40));
    s3d.shape(Smell_1);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    s3d.shape(Smell_2);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    s3d.shape(Smell_3);
    s3d.popMatrix();
    //---------------
  }
  s3d.popMatrix();
}
