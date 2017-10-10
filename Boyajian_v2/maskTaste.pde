RShape textTaste;
boolean showMaskTaste =false;
boolean MaskTasteIn;

pdLine  MaskTasteLine;
pdLine  MaskTasteLineIn;
pdLine  MaskTasteLineOut;

PShape Taste_1;
PShape Taste_2;
PShape Taste_3;
PShape Taste_4;
PShape Taste_5;
PShape Taste_6;

float Taste_x, Taste_y;

void maskTasteSetting() {

  textTaste= RG.getText("百味獸", "wt.ttf", 72, RFont.CENTER);
  MaskTasteLineIn=new pdLine(500, 1000);
  MaskTasteLineOut=new pdLine(3500, 1000);

  if (showMaskTaste==false) {
    show[6]=1;
    countLife();
    MaskTasteLine=new pdLine(0, 1000);
    MaskTasteIn=true;
    Taste_1 = loadShape("maskTaste/taste_1.obj");
    Taste_2=  loadShape("maskTaste/taste_2.obj");
    Taste_3 = loadShape("maskTaste/taste_3.obj");
    Taste_4 = loadShape("maskTaste/taste_4.obj");
    Taste_5 = loadShape("maskTaste/taste_5.obj");
    Taste_6 = loadShape("maskTaste/taste_6.obj");
    showMaskTaste =true;
  } else if (showMaskTaste==true) {
    MaskTasteIn=false;
    show[6]=0;
    countLife();
  }
  MaskTasteLine.reset();
  MaskTasteLineIn.reset();
  MaskTasteLineIn.done=false;
  MaskTasteLineOut.reset();
}


void maskTastedrawing() {
  MaskTasteLineIn.update();
  MaskTasteLineOut.update();
  showMaskTaste=returnState(MaskTasteLine, MaskTasteIn);
  s3d.pushMatrix();
  {
    Taste_x=width/2+countX[6].o;
    Taste_y=height/2+-30;
    //----fade
    if (MaskTasteIn==true)s3d.translate(0, map(easeOutBack(MaskTasteLine.o), 0, 1, 500, 0));
    else  s3d.translate(0, map(easeInBack(MaskTasteLine.o), 0, 1, 0, -500));
    //----fadeEnd

    {//文字開始
      s3d.pushMatrix();
      s3d.translate(width/2, height/2-17, -50);
      s3d.scale(3.0);
      s3d.fill(maskNmae, 155);

      {//文字動畫
        if (MaskTasteLineIn.bang==true ) {
          textTaste.children[0].transform(40, easeInBack(MaskTasteLineIn.oo)*300, 20, 20) ;
          textTaste.children[1].transform(97, -easeInBack(MaskTasteLineIn.oo)*300, 20, 20) ;
          textTaste.children[2].transform(156, easeInBack(MaskTasteLineIn.oo)*300, 20, 20) ;
        } else if (MaskTasteLineIn.done==true  ) {
          textTaste.children[0].transform(40, easeInBack(MaskTasteLineOut.o)*300, 20, 20) ;
          textTaste.children[1].transform(97, -easeInBack(MaskTasteLineOut.o)*300, 20, 20) ;
          textTaste.children[2].transform(156, easeInBack(MaskTasteLineOut.o)*300, 20, 20) ;
          defultCam();
        }

        if (MaskTasteLineOut.bang==false) {
          MaskTasteLineIn.done=false;
        }
      }//文字動畫結束

      s3d.strokeWeight(1);
      s3d.noStroke();
      if (MaskTasteLineOut.o>0.001 || MaskTasteLineIn.o>0.001 )
        if ( MaskTasteIn==true )textTaste.draw(s3d);
      s3d.popMatrix();
    }//文字結束
    //-----model

    s3d.translate(Taste_x, Taste_y+anim(300, 0, -50, 2), -50);
    s3d.rotateZ(PI);
    s3d.rotateY(radians(anim(600, -30, 30, 2)));
    //--------------抖動
    s3d.scale(0.60);
    //---------------
    s3d.pushMatrix();
    s3d.shape(Taste_1);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    s3d.rotateY(radians(anim(180, 0, 180, 2)));
    s3d.shape(Taste_2);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    s3d.rotateY(radians(anim(150, 20, 200, 2)));
    s3d.shape(Taste_3);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    s3d.rotateY(radians(anim(200, 20, 120, 2)));
    s3d.shape(Taste_4);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    s3d.rotateY(radians(anim(100, 50, 160, 2)));
    s3d.shape(Taste_5);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    s3d.rotateY(radians(anim(160, 0, 130, 2)));
    s3d.shape(Taste_6);
    s3d.popMatrix();
    //---------------
  }
  s3d.popMatrix();
}

void Taste(boolean theFlag) {
  if (theFlag==true) {
    showMaskTaste=false;
    thread("maskTasteSetting");
    randomCam();
  } else {
    showMaskTaste=true;
    thread("maskTasteSetting");
  }
}