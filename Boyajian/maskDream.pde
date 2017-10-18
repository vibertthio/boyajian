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

PShape RDream_1;
PShape RDream_2;
PShape RDream_3;
PShape RDream_4;
PShape RDream_5;
PShape RDream_6;

PImage DreamImg;
float Dream_x, Dream_y;

void maskDreamSetting() {

  textDream= RG.getText("食夢術士", "wt.ttf", 72, RFont.CENTER);


  if (showMaskDream==false) {
    show[0]=1;
    countLife();
    DreamImg=loadImage("maskDream/tex_dream_01.png");
    MaskDreamIn=true;

    Dream_1 = loadShape("maskDream/dream_1.obj");
    Dream_2=  loadShape("maskDream/dream_2.obj");
    Dream_3 = loadShape("maskDream/dream_3.obj");
    Dream_4 = loadShape("maskDream/dream_4.obj");
    Dream_5 = loadShape("maskDream/dream_5.obj");
    Dream_6 = loadShape("maskDream/dream_6.obj");

    RDream_1 = loadShape("maskDream/dream_1.obj");
    RDream_2=  loadShape("maskDream/dream_2.obj");
    RDream_3 = loadShape("maskDream/dream_3.obj");
    RDream_4 = loadShape("maskDream/dream_4.obj");
    RDream_5 = loadShape("maskDream/dream_5.obj");
    RDream_6 = loadShape("maskDream/dream_6.obj");
    showMaskDream =true;
  } else if (showMaskDream==true) {
    MaskDreamIn=false;
    show[0]=0;
    countLife();
  }
  MaskDreamLineIn=new pdLine(500, 1000);
  MaskDreamLineOut=new pdLine(3500, 1000);
  MaskDreamLine=new pdLine(0, 1000);
  MaskDreamLine.reset();
  MaskDreamLineIn.reset();
  MaskDreamLineIn.done=false;
  MaskDreamLineOut.reset();
}


void maskDreamdrawing() {
  //MaskDreamLineIn.update();
  //MaskDreamLineOut.update();
  showMaskDream=returnState(MaskDreamLine, MaskDreamIn);
  s3d.pushMatrix();
  {
    Dream_x=width/2+countX[0].o;

    //----fade
    if (MaskDreamIn==true)Dream_y=height/2-3+map(easeOutBack(MaskDreamLine.o), 0, 1, 500, 0);
    else  Dream_y=height/2-3+map(easeInBack(MaskDreamLine.o), 0, 1, 0, -500);
    //----fadeEnd

    s3d.translate(Dream_x, Dream_y+anim(300, 0, -50, 2), -50);
    //s3d.pushMatrix();//文字開始
    //{
    //  s3d.translate(40, 0, 0);
    //  s3d.fill(maskNmae, 155);
    //  if (MaskDreamLineIn.bang==true ) {
    //    textDream.children[0].transform(70, easeInBack(MaskDreamLineIn.oo)*300, 30, 30) ;
    //    textDream.children[1].transform(102, -easeInBack(MaskDreamLineIn.oo)*300, 30, 30) ;
    //    textDream.children[2].transform(137, easeInBack(MaskDreamLineIn.oo)*300, 30, 30) ;
    //    textDream.children[3].transform(172, -easeInBack(MaskDreamLineIn.oo)*300, 30, 30) ;
    //  } else if (MaskDreamLineIn.done==true  ) {
    //    textDream.children[0].transform(70, easeInBack(MaskDreamLineOut.o)*300, 30, 30) ;
    //    textDream.children[1].transform(102, -easeInBack(MaskDreamLineOut.o)*300, 30, 30) ;
    //    textDream.children[2].transform(137, easeInBack(MaskDreamLineOut.o)*300, 30, 30) ;
    //    textDream.children[3].transform(172, -easeInBack(MaskDreamLineOut.o)*300, 30, 30) ;
    //    defultCam();
    //  }

    //  if (MaskDreamLineOut.bang==false) MaskDreamLineIn.done=false;
    //  if (MaskDreamLineOut.o<0.99 && MaskDreamLineIn.o>0.001 && MaskDreamIn==true )textDream.draw(s3d);
    //}
    //s3d.popMatrix();//文字結束


    s3d.rotateZ(PI);
    s3d.rotateY(radians(map(sin(float(frameCount%600)/600*6.28), -1, 1, -30, 30)));
    //--------------抖動
    s3d.rotateZ(map(pow(sin(float(frameCount%10)/10*6.28), 8.0), 0, 1, 0, PI*-0.01));
    s3d.scale(0.52);
    //---------------
    s3d.pushMatrix();
    s3d.shape(Dream_1);
    if (vertexNoise==true) randomVertex(Dream_1);
    else returnVertex(RDream_1, Dream_1);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    s3d.shape(Dream_2);
    if (vertexNoise==true) randomVertex(Dream_2);
    else returnVertex(RDream_2, Dream_2);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    s3d.translate(0, 0, 0);
    s3d.rotateZ(radians(float(frameCount%50)/50*360));
    s3d.translate(0, 30, 0);
    s3d.shape(Dream_3);
    if (vertexNoise==true) randomVertex(Dream_3);
    else returnVertex(RDream_3, Dream_3);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    s3d.translate(0, 188, -44);
    if ((frameCount%400)>300) {
      s3d.rotateX(radians(anim(400, 0, -40, 8)));
    }
    s3d.translate(0, 0, 0);
    s3d.shape(Dream_4);
    if (vertexNoise==true) randomVertex(Dream_4);
    else returnVertex(RDream_4, Dream_4);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    Dream_5.disableStyle();//寶石
    s3d.colorMode(HSB, 100);
    s3d.tint( color(anim(30, 0, 100, 4), 100, 100));
    s3d.shape(Dream_5);
    if (vertexNoise==true) randomVertex(Dream_5);
    else returnVertex(RDream_5, Dream_5);
    Dream_5.enableStyle();
    s3d.popMatrix();
    s3d.colorMode(RGB);
    //---------------
    s3d.pushMatrix();
    s3d.shape(Dream_6);
    if (vertexNoise==true) randomVertex(Dream_6);
    else returnVertex(RDream_6, Dream_6);
    s3d.popMatrix();
    //---------------
  }
  s3d.popMatrix();
  if (wireFrameCtl==true) {
    noWireFrame( Dream_1, random(1.80, 2.40), color(0, 165, 250, 120));
    noWireFrame( Dream_2, random(1.80, 2.40), color(0, 165, 250, 120));
    noWireFrame( Dream_3, random(1.80, 2.40), color(0, 165, 250, 120));
    noWireFrame( Dream_4, random(1.80, 2.40), color(0, 165, 250, 120));
    noWireFrame( Dream_5, random(1.80, 2.40), color(0, 165, 250, 120));
    noWireFrame( Dream_6, random(1.80, 2.40), color(0, 165, 250, 120));

  } else {
    setTexture( Dream_1, DreamImg);
    setTexture( Dream_2, DreamImg);
    setTexture( Dream_3, DreamImg);
    setTexture( Dream_4, DreamImg);
    setTexture( Dream_5, DreamImg);
    setTexture( Dream_6, DreamImg);
  }
}

void Dream(boolean theFlag) {
  if (theFlag==true) {
    showMaskDream=false;
    thread("maskDreamSetting");
    randomCam();
  } else {
    showMaskDream=true;
    thread("maskDreamSetting");
  }
}
