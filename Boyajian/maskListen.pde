
RShape textListen;
boolean showMaskListen =false;
boolean MaskListenIn;

pdLine  MaskListenLine;
pdLine  MaskListenLineIn;
pdLine  MaskListenLineOut;

PShape Listen_1;
PShape Listen_2;
PShape Listen_3;

PImage ListenImg;

float Listen_x, Listen_y;

void maskListenSetting() {

  textListen= RG.getText("音納耳", "wt.ttf", 72, RFont.CENTER);

  if (showMaskListen==false) {
    show[3]=1;
    countLife();
    ListenImg=loadImage("maskListen/tex_listen.png");
    MaskListenIn=true;
    Listen_1 = loadShape("maskListen/listen_1.obj");
    Listen_2=  loadShape("maskListen/listen_2.obj");
    Listen_3 = loadShape("maskListen/listen_3.obj");
    showMaskListen =true;
  } else if (showMaskListen==true) {
    MaskListenIn=false;
    show[3]=0;
    countLife();
  }
  MaskListenLineIn=new pdLine(500, 1000);
  MaskListenLineOut=new pdLine(3500, 1000);
  MaskListenLine=new pdLine(0, 1000);
  MaskListenLine.reset();
  MaskListenLineIn.reset();
  MaskListenLineIn.done=false;
  MaskListenLineOut.reset();
}


void maskListendrawing() {

  showMaskListen=returnState(MaskListenLine, MaskListenIn);
  s3d.pushMatrix();
  {
    Listen_x=width/2+countX[3].o;

    if (MaskListenIn==true)Listen_y=height/2+27+ map(easeOutBack(MaskListenLine.o), 0, 1, 500, 0);
    else  Listen_y=height/2+27+map(easeInBack(MaskListenLine.o), 0, 1, 0, -500);

    s3d.translate(Listen_x, Listen_y+anim(300, 0, -50, 2), -50);

    // s3d.pushMatrix();//文字動畫
    // s3d.translate(40, 0, 0);
    // s3d.fill(maskNmae, 155);
    //
    // MaskListenLineIn.update();
    // MaskListenLineOut.update();
    // if (MaskListenLineIn.bang==true ) {
    //   textListen.children[0].transform(40, easeInBack(MaskListenLineIn.oo)*300, 30, 30) ;
    //   textListen.children[1].transform(97, -easeInBack(MaskListenLineIn.oo)*300, 30, 30) ;
    //   textListen.children[2].transform(156, easeInBack(MaskListenLineIn.oo)*300, 30, 30) ;
    // } else if (MaskListenLineIn.done==true  ) {
    //   textListen.children[0].transform(40, easeInBack(MaskListenLineOut.o)*300, 30, 30) ;
    //   textListen.children[1].transform(97, -easeInBack(MaskListenLineOut.o)*300, 30, 30) ;
    //   textListen.children[2].transform(156, easeInBack(MaskListenLineOut.o)*300, 30, 30) ;
    //   defultCam();
    // }
    //
    // if (MaskListenLineOut.bang==false) MaskListenLineIn.done=false;
    // if (MaskListenLineOut.o<0.99 &&MaskListenLineIn.o>0.01 && MaskListenIn==true)textListen.draw(s3d);
    //
    // s3d.popMatrix();//文字結束


    s3d.rotateZ(PI);
    s3d.rotateY(radians(map(sin(float(frameCount%600)/600*6.28), -1, 1, -30, 30)));
    //--------------抖動
    s3d.rotateZ(map(pow(sin(float(frameCount%10)/10*6.28), 8.0), 0, 1, 0, PI*-0.01));
    s3d.scale(0.35);
    //---------------
    s3d.pushMatrix();
    s3d.shape(Listen_1);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    s3d.shape(Listen_2);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    s3d.shape(Listen_3);
    s3d.popMatrix();
    //---------------
  }
  s3d.popMatrix();
  if (wireFrameCtl==true) {
    noWireFrame(Listen_1, random(1.80, 2.40), color(255, 120));
    noWireFrame(Listen_2, random(1.80, 2.40), color(255, 120));
    noWireFrame(Listen_3, random(1.80, 2.40), color(255, 120));
  } else {
    setTexture(Listen_1, ListenImg);
    setTexture(Listen_2, ListenImg);
    setTexture(Listen_3, ListenImg);
  }
}
void Listen(boolean theFlag) {
  if (theFlag==true) {
    showMaskListen=false;
    thread("maskListenSetting");
    //randomCam();
  } else {
    showMaskListen=true;
    thread("maskListenSetting");
  }
}
