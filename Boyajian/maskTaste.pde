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

PShape rTaste_1;
PShape rTaste_2;
PShape rTaste_3;
PShape rTaste_4;
PShape rTaste_5;
PShape rTaste_6;

float Taste_x, Taste_y;
PImage TasteImg;

void maskTasteSetting() {

  textTaste= RG.getText("百味獸", "wt.ttf", 72, RFont.CENTER);


  if (showMaskTaste==false) {
    show[6]=1;
    countLife();


    MaskTasteIn=true;

    showMaskTaste =true;
  } else if (showMaskTaste==true) {
    MaskTasteIn=false;
    show[6]=0;
    countLife();
  }

  MaskTasteLineIn=new pdLine(500, 1000);
  MaskTasteLineOut=new pdLine(3500, 1000);
  MaskTasteLine=new pdLine(0, 1000);

  MaskTasteLine.reset();
  MaskTasteLineIn.reset();
  MaskTasteLineIn.done=false;
  MaskTasteLineOut.reset();
}


void maskTastedrawing() {

  showMaskTaste=returnState(MaskTasteLine, MaskTasteIn);
  s3d.pushMatrix();
  {
    Taste_x=width/2+countX[6].o;

    //----fade
    if (MaskTasteIn==true)Taste_y=height/2+-30+map(easeOutBack(MaskTasteLine.o), 0, 1, 500, 0);
    else  Taste_y=height/2+-30+map(easeInBack(MaskTasteLine.o), 0, 1, 0, -500);
    //----fadeEnd
    s3d.translate(Taste_x, Taste_y+anim(300, 0, -50, 2), -50);

    // s3d.pushMatrix();
    // s3d.translate(40, 0, -50);
    // s3d.fill(maskNmae, 155);
    // MaskTasteLineIn.update();
    // MaskTasteLineOut.update();
    // if (MaskTasteLineIn.bang==true ) {
    //   textTaste.children[0].transform(40, easeInBack(MaskTasteLineIn.oo)*300, 30, 30) ;
    //   textTaste.children[1].transform(97, -easeInBack(MaskTasteLineIn.oo)*300, 30, 30) ;
    //   textTaste.children[2].transform(156, easeInBack(MaskTasteLineIn.oo)*300, 30, 30) ;
    // } else if (MaskTasteLineIn.done==true  ) {
    //   textTaste.children[0].transform(40, easeInBack(MaskTasteLineOut.o)*300, 30, 30) ;
    //   textTaste.children[1].transform(97, -easeInBack(MaskTasteLineOut.o)*300, 30, 30) ;
    //   textTaste.children[2].transform(156, easeInBack(MaskTasteLineOut.o)*300, 30, 30) ;
    //   defultCam();
    // }
    // if (MaskTasteLineOut.bang==false) MaskTasteLineIn.done=false;
    // if (MaskTasteLineOut.o<0.99 && MaskTasteLineIn.o>0.001 &&MaskTasteIn==true)textTaste.draw(s3d);
    // s3d.popMatrix();

    s3d.rotateZ(PI);
    s3d.rotateY(radians(anim(600, -30, 30, 2)));
    //--------------抖動
    s3d.scale(0.60);
    //---------------
    s3d.pushMatrix();
    if(vol>0.8){
      s3d.scale(1+random(0.2));
    }else{
      s3d.scale(1);
    }

    if (vertexNoise==true) randomVertex(Taste_1);
    else returnVertex(rTaste_1, Taste_1);

    s3d.shape(Taste_1);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    s3d.rotateY(radians(anim(180, 0, 180, 2)));

    if (vertexNoise==true) randomVertex(Taste_2);
    else returnVertex(rTaste_2, Taste_2);
    s3d.shape(Taste_2);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    s3d.rotateY(radians(anim(150, 30, 300, 2)));

    if (vertexNoise==true) randomVertex(Taste_3);
    else returnVertex(rTaste_3, Taste_3);
    s3d.shape(Taste_3);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    s3d.rotateY(radians(anim(300, 30, 130, 2)));

    if (vertexNoise==true) randomVertex(Taste_4);
    else returnVertex(rTaste_4, Taste_4);
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

    if (vertexNoise==true) randomVertex(Taste_6);
    else returnVertex(rTaste_6, Taste_6);
    s3d.shape(Taste_6);
    s3d.popMatrix();
    //---------------
  }
  s3d.popMatrix();
  if (wireFrameCtl==true) {
    noWireFrame( Taste_1, random(1.80, 2.40), color(0, 165, 250, 120));
    noWireFrame( Taste_2, random(1.80, 2.40), color(0, 165, 250, 120));
    noWireFrame( Taste_3, random(1.80, 2.40), color(0, 165, 250, 120));
    noWireFrame( Taste_4, random(1.80, 2.40), color(0, 165, 250, 120));
    noWireFrame( Taste_5, random(1.80, 2.40), color(0, 165, 250, 120));
    noWireFrame( Taste_6, random(1.80, 2.40), color(0, 165, 250, 120));
  } else {
    setTexture( Taste_1, TasteImg);
    setTexture( Taste_2, TasteImg);
    setTexture(Taste_3, TasteImg);
    setTexture( Taste_4, TasteImg);
    setTexture( Taste_5, TasteImg);
    setTexture(Taste_6, TasteImg);
  }
}

void Taste(boolean theFlag) {
  if (theFlag==true) {
    showMaskTaste=false;
    thread("maskTasteSetting");
    //randomCam();
  } else {
    showMaskTaste=true;
    thread("maskTasteSetting");
  }
}
