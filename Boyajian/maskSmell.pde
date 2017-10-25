RShape textSmell;
boolean showMaskSmell =false;
boolean MaskSmellIn;

pdLine  MaskSmellLine;
pdLine  MaskSmellLineIn;
pdLine  MaskSmellLineOut;

PShape Smell_1;
PShape Smell_2;
PShape Smell_3;

PShape rSmell_1;
PShape rSmell_2;
PShape rSmell_3;


PImage SmellImg;

float Smell_x, Smell_y;

void maskSmellSetting() {

  textSmell= RG.getText("氣嗅者", "wt.ttf", 72, RFont.CENTER);


  if (showMaskSmell==false) {
    show[5]=1;
    countLife();
    SmellImg=loadImage("maskSmell/tex_smell.png");
    MaskSmellIn=true;
    Smell_1 = loadShape("maskSmell/smell_1.obj");
    Smell_2=  loadShape("maskSmell/smell_2.obj");
    Smell_3 = loadShape("maskSmell/smell_3.obj");

    rSmell_1 = loadShape("maskSmell/smell_1.obj");
    rSmell_2=  loadShape("maskSmell/smell_2.obj");
    rSmell_3 = loadShape("maskSmell/smell_3.obj");
    showMaskSmell =true;
  } else if (showMaskSmell==true) {
    MaskSmellIn=false;
    show[5]=0;
    countLife();
  }

  MaskSmellLineIn=new pdLine(500, 1000);
  MaskSmellLineOut=new pdLine(3500, 1000);
  MaskSmellLine=new pdLine(0, 1000);

  MaskSmellLine.reset();
  MaskSmellLineIn.reset();
  MaskSmellLineIn.done=false;
  MaskSmellLineOut.reset();
}


void maskSmelldrawing() {

  showMaskSmell=returnState(MaskSmellLine, MaskSmellIn);
  s3d.pushMatrix();
  {
    Smell_x=width/2+countX[5].o;


    if (MaskSmellIn==true)Smell_y=height/2+-27+ map(easeOutBack(MaskSmellLine.o), 0, 1, 500, 0);
    else Smell_y=height/2+-27+map(easeInBack(MaskSmellLine.o), 0, 1, 0, -500);

    s3d.translate(Smell_x, Smell_y+anim(300, 0, -50, 2), -50);

    // s3d.pushMatrix();
    // s3d.translate(40,0, 0);
    // s3d.fill(maskNmae, 155);
    // MaskSmellLineIn.update();
    // MaskSmellLineOut.update();
    // if (MaskSmellLineIn.bang==true ) {
    //   textSmell.children[0].transform(40, easeInBack(MaskSmellLineIn.oo)*300, 30, 30) ;
    //   textSmell.children[1].transform(97, -easeInBack(MaskSmellLineIn.oo)*300, 30, 30) ;
    //   textSmell.children[2].transform(156, easeInBack(MaskSmellLineIn.oo)*300, 30, 30) ;
    // } else if (MaskSmellLineIn.done==true  ) {
    //   textSmell.children[0].transform(40, easeInBack(MaskSmellLineOut.o)*300, 30, 30) ;
    //   textSmell.children[1].transform(97, -easeInBack(MaskSmellLineOut.o)*300, 30, 30) ;
    //   textSmell.children[2].transform(156, easeInBack(MaskSmellLineOut.o)*300, 30, 30) ;
    //   defultCam();
    // }
    //
    // if (MaskSmellLineOut.bang==false)  MaskSmellLineIn.done=false;
    // if (MaskSmellLineOut.o<0.99 && MaskSmellLineIn.o>0.001 && MaskSmellIn==true )textSmell.draw(s3d);
    // s3d.popMatrix();

    s3d.rotateZ(PI);
    s3d.rotateY(radians(map(sin(float(frameCount%600)/600*6.28), -1, 1, -30, 30)));
    //--------------抖動
    s3d.rotateZ(map(pow(sin(float(frameCount%10)/10*6.28), 8.0), 0, 1, 0, PI*-0.01));
    s3d.scale(0.70);
    //---------------
    s3d.pushMatrix();//牙齒
    s3d.translate(0, anim(180,0,-40,8));
    if (vertexNoise==true) randomVertex(Smell_1);
    else returnVertex(rSmell_1, Smell_1);
    if (vol>0.8) {
      s3d.scale(1, random(1, 1.2),1);
    } else {
      s3d.scale(1);
    }
    s3d.shape(Smell_1);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    if (vertexNoise==true) randomVertex(Smell_2);
    else returnVertex(rSmell_2, Smell_2);

    s3d.shape(Smell_2);
    s3d.popMatrix();
    //---------------
    Smell_3.disableStyle();//鼻子
    {
      s3d.pushMatrix();
      s3d.tint( color(map(pow(sin((float(frameCount)%300)/300*6.28), 4.0), 0, 1, 0, 255), 255, 255));

      if (vertexNoise==true) randomVertex(Smell_3);
      else returnVertex(rSmell_3, Smell_3);

      s3d.shape(Smell_3);
      s3d.popMatrix();
    }
    Smell_3.enableStyle();

    //---------------
  }
  s3d.popMatrix();
  if (wireFrameCtl==true) {
    noWireFrame(Smell_1, random(1.80, 2.40), color(0, 165, 250, 120));
    noWireFrame(Smell_2, random(1.80, 2.40), color(0, 165, 250, 120));
    noWireFrame(Smell_3, random(1.80, 2.40), color(0, 165, 250, 120));
  } else {
    setTexture(Smell_1, SmellImg);
    setTexture(Smell_2, SmellImg);
    setTexture(Smell_3, SmellImg);
  }

  if (vertexNoise==true) {
    addWireFrame(Smell_1);
    addWireFrame(Smell_2);
    addWireFrame(Smell_3);
  }
}

void Smell(boolean theFlag) {
  if (theFlag==true) {
    showMaskSmell=false;
    thread("maskSmellSetting");
    //randomCam();
  } else {
    showMaskSmell=true;
    thread("maskSmellSetting");
  }
}
