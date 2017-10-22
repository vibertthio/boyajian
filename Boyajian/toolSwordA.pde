RShape textSwordA;
boolean showtoolSwordA =false;
boolean toolSwordAIn;

pdLine  toolSwordALine;
pdLine  toolSwordALineIn;
pdLine  toolSwordALineOut;

PShape SwordA_1;
PImage SwordAImg;

float SwordA_x, SwordA_y;

void toolSwordASetting() {

  textSwordA= RG.getText("鎏金鈍刀", "wt.ttf", 72, RFont.CENTER);


  if (showtoolSwordA==false) {
    show[10]=1;
    countLife();

    toolSwordAIn=true;
    SwordA_1 = loadShape("toolSwordA/sworda.obj");
    SwordAImg=loadImage("toolSwordA/tex_sword_a.png");
    showtoolSwordA =true;
  } else if (showtoolSwordA==true) {
    toolSwordAIn=false;
    show[10]=0;
    countLife();
  }
  toolSwordALineIn=new pdLine(500, 1000);
  toolSwordALineOut=new pdLine(3500, 1000);
  toolSwordALine=new pdLine(0, 1000);
  toolSwordALine.reset();
  toolSwordALineIn.reset();
  toolSwordALineIn.done=false;
  toolSwordALineOut.reset();
}


void toolSwordAdrawing() {

  showtoolSwordA=returnState(toolSwordALine, toolSwordAIn);
  s3d.pushMatrix();
  {
    SwordA_x=width/2+countX[10].o;

    if (toolSwordAIn==true)SwordA_y=height/2+68+map(easeOutBack(toolSwordALine.o), 0, 1, 500, 0);
    else  SwordA_y=height/2+68+map(easeInBack(toolSwordALine.o), 0, 1, 0, -500);

    s3d.translate(SwordA_x, SwordA_y+anim(300, 0, -50, 2), -50);

    // s3d.pushMatrix();
    // s3d.translate(40, 0, 0);
    // s3d.fill(maskNmae, 155);
    // toolSwordALineIn.update();
    // toolSwordALineOut.update();
    // if (toolSwordALineIn.bang==true ) {
    //   textSwordA.children[0].transform(70, easeInBack(toolSwordALineIn.oo)*300, 30, 30) ;
    //   textSwordA.children[1].transform(102, -easeInBack(toolSwordALineIn.oo)*300, 30, 30) ;
    //   textSwordA.children[2].transform(137, easeInBack(toolSwordALineIn.oo)*300, 30, 30) ;
    //   textSwordA.children[3].transform(172, -easeInBack(toolSwordALineIn.oo)*300, 30, 30) ;
    // } else if (toolSwordALineIn.done==true  ) {
    //   textSwordA.children[0].transform(70, easeInBack(toolSwordALineOut.o)*300, 30, 30) ;
    //   textSwordA.children[1].transform(102, -easeInBack(toolSwordALineOut.o)*300, 30, 30) ;
    //   textSwordA.children[2].transform(137, easeInBack(toolSwordALineOut.o)*300, 30, 30) ;
    //   textSwordA.children[3].transform(172, -easeInBack(toolSwordALineOut.o)*300, 30, 30) ;
    //   defultCam();
    // }
    //
    // if (toolSwordALineOut.bang==false) toolSwordALineIn.done=false;
    // if (toolSwordALineOut.o<0.98 && toolSwordALineIn.o>0.01 && toolSwordAIn==true )textSwordA.draw(s3d);
    // s3d.popMatrix();

    s3d.rotateZ(PI);
    s3d.rotateY(radians(map(sin(float(frameCount%600)/600*6.28), -1, 1, -30, 30)));
    //--------------抖動
    s3d.rotateZ(map(pow(sin(float(frameCount%10)/10*6.28), 8.0), 0, 1, 0, PI*-0.01));
    s3d.scale(0.57);
    //---------------
    s3d.pushMatrix();
    s3d.rotateZ(anim(90,0,0.2,8));
    s3d.shape(SwordA_1);
    s3d.popMatrix();
  }
  s3d.popMatrix();
  if (wireFrameCtl==true) {
    noWireFrame(SwordA_1, random(1.80, 2.40), color(0, 165, 250, 120));
  } else {
    setTexture(SwordA_1, SwordAImg);
  }
}
void SwordA(boolean theFlag) {
  if (theFlag==true) {
    showtoolSwordA=false;
    thread("toolSwordASetting");
    //randomCam();
  } else {
    showtoolSwordA=true;
    thread("toolSwordASetting");
  }
}
