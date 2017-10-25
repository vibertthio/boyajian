RShape textSwordB;
boolean showtoolSwordB =false;
boolean toolSwordBIn;

pdLine  toolSwordBLine;
pdLine  toolSwordBLineIn;
pdLine  toolSwordBLineOut;

PShape SwordB_1;
PImage SwordBImg;
float SwordB_x, SwordB_y;

void toolSwordBSetting() {

  textSwordB= RG.getText("召喚鈴刀", "wt.ttf", 72, RFont.CENTER);


  if (showtoolSwordB==false) {
    show[11]=1;
    countLife();
    SwordBImg=loadImage("toolSwordB/tex_sword_b.png");
    toolSwordBIn=true;
    SwordB_1 = loadShape("toolSwordB/swordb.obj");

    showtoolSwordB =true;
  } else if (showtoolSwordB==true) {
    toolSwordBIn=false;
    show[11]=0;
    countLife();
  }
  toolSwordBLineIn=new pdLine(500, 1000);
  toolSwordBLineOut=new pdLine(3500, 1000);
  toolSwordBLine=new pdLine(0, 1000);
  toolSwordBLine.reset();
  toolSwordBLineIn.reset();
  toolSwordBLineIn.done=false;
  toolSwordBLineOut.reset();
}


void toolSwordBdrawing() {

  showtoolSwordB=returnState(toolSwordBLine, toolSwordBIn);
  s3d.pushMatrix();
  {
    SwordB_x=width/2+countX[11].o;

    if (toolSwordBIn==true) SwordB_y=height/2+69+ map(easeOutBack(toolSwordBLine.o), 0, 1, 500, 0);
    else  SwordB_y=height/2+69+map(easeInBack(toolSwordBLine.o), 0, 1, 0, -500);

    s3d.translate(SwordB_x, SwordB_y+anim(300, 0, -50, 2), -50);

    // s3d.pushMatrix();
    // s3d.translate(40, 0, 0);
    // s3d.fill(maskNmae, 155);
    // toolSwordBLineIn.update();
    // toolSwordBLineOut.update();
    // if (toolSwordBLineIn.bang==true ) {
    //   textSwordB.children[0].transform(70, easeInBack(toolSwordBLineIn.oo)*300, 30, 30) ;
    //   textSwordB.children[1].transform(102, -easeInBack(toolSwordBLineIn.oo)*300, 30, 30) ;
    //   textSwordB.children[2].transform(137, easeInBack(toolSwordBLineIn.oo)*300, 30, 30) ;
    //   textSwordB.children[3].transform(172, -easeInBack(toolSwordBLineIn.oo)*300, 30, 30) ;
    // } else if (toolSwordBLineIn.done==true  ) {
    //   textSwordB.children[0].transform(70, easeInBack(toolSwordBLineOut.o)*300, 30, 30) ;
    //   textSwordB.children[1].transform(102, -easeInBack(toolSwordBLineOut.o)*300, 30, 30) ;
    //   textSwordB.children[2].transform(137, easeInBack(toolSwordBLineOut.o)*300, 30, 30) ;
    //   textSwordB.children[3].transform(172, -easeInBack(toolSwordBLineOut.o)*300, 30, 30) ;
    //   defultCam();
    // }
    // if (toolSwordBLineOut.bang==false) toolSwordBLineIn.done=false;
    // if (toolSwordBLineOut.o<0.99 && toolSwordBLineIn.o>0.01 && toolSwordBIn==true )textSwordB.draw(s3d);
    //
    // s3d.popMatrix();


    s3d.rotateZ(PI);
    s3d.rotateY(radians(map(sin(float(frameCount%600)/600*6.28), -1, 1, -30, 30)));
    //--------------抖動
    s3d.rotateZ(map(pow(sin(float(frameCount%10)/10*6.28), 8.0), 0, 1, 0, PI*-0.01));
    s3d.scale(0.47);
    //---------------
    s3d.pushMatrix();
    s3d.rotateZ(anim(90,0,0.2,4));
    s3d.shape(SwordB_1);
    s3d.popMatrix();
  }
  s3d.popMatrix();
  if (wireFrameCtl==true) {
    noWireFrame(SwordB_1, random(1.80, 2.40), color(0, 165, 250, 120));
  } else {
    setTexture(SwordB_1, SwordBImg);
  }
}
void SwordB(boolean theFlag) {
  if (theFlag==true) {
    showtoolSwordB=false;
    thread("toolSwordBSetting");
    //randomCam();
  } else {
    showtoolSwordB=true;
    thread("toolSwordBSetting");
  }
}