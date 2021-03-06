RShape textGoat;
boolean showtoolGoat =false;
boolean toolGoatIn;

pdLine  toolGoatLine;
pdLine  toolGoatLineIn;
pdLine  toolGoatLineOut;

PShape Goat_1;
PShape Goat_2;
PShape Goat_3;
PImage GoatImg;
float Goat_x, Goat_y;

void toolGoatSetting() {

  textGoat= RG.getText("召喚鈴刀", "wt.ttf", 72, RFont.CENTER);

  if (showtoolGoat==false) {
    show[14]=1;
    countLife();

    toolGoatIn=true;


    showtoolGoat =true;
  } else if (showtoolGoat==true) {
    toolGoatIn=false;
    show[14]=0;
    countLife();
  }
  toolGoatLineIn=new pdLine(500, 1000);
  toolGoatLineOut=new pdLine(3500, 1000);
  toolGoatLine=new pdLine(0, 1000);
  toolGoatLine.reset();
  toolGoatLineIn.reset();
  toolGoatLineIn.done=false;
  toolGoatLineOut.reset();
}


void toolGoatdrawing() {

  showtoolGoat=returnState(toolGoatLine, toolGoatIn);
  s3d.pushMatrix();
  {
    Goat_x=width/2+countX[14].o;

    if (toolGoatIn==true) Goat_y=height/2+69+ map(easeOutBack(toolGoatLine.o), 0, 1, 500, 0);
    else  Goat_y=height/2+69+map(easeInBack(toolGoatLine.o), 0, 1, 0, -500);

    s3d.translate(Goat_x, Goat_y+anim(300, 0, -50, 2), -50);

    // s3d.pushMatrix();
    // s3d.translate(40, 0, 0);
    // s3d.fill(maskNmae, 155);
    // toolGoatLineIn.update();
    // toolGoatLineOut.update();
    // if (toolGoatLineIn.bang==true ) {
    //   textGoat.children[0].transform(70, easeInBack(toolGoatLineIn.oo)*300, 30, 30) ;
    //   textGoat.children[1].transform(102, -easeInBack(toolGoatLineIn.oo)*300, 30, 30) ;
    //   textGoat.children[2].transform(137, easeInBack(toolGoatLineIn.oo)*300, 30, 30) ;
    //   textGoat.children[3].transform(172, -easeInBack(toolGoatLineIn.oo)*300, 30, 30) ;
    // } else if (toolGoatLineIn.done==true  ) {
    //   textGoat.children[0].transform(70, easeInBack(toolGoatLineOut.o)*300, 30, 30) ;
    //   textGoat.children[1].transform(102, -easeInBack(toolGoatLineOut.o)*300, 30, 30) ;
    //   textGoat.children[2].transform(137, easeInBack(toolGoatLineOut.o)*300, 30, 30) ;
    //   textGoat.children[3].transform(172, -easeInBack(toolGoatLineOut.o)*300, 30, 30) ;
    //   defultCam();
    // }
    // if (toolGoatLineOut.bang==false) toolGoatLineIn.done=false;
    // if (toolGoatLineOut.o<0.99 && toolGoatLineIn.o>0.01 && toolGoatIn==true )textGoat.draw(s3d);
    //
    // s3d.popMatrix();


    s3d.rotateZ(PI);
    s3d.rotateY(radians(anim(570,-30,30,8)));
    //--------------抖動
    s3d.scale(0.73);
    s3d.rotateY(anim(300,-0.2,0.2,4));
    //---------------
    s3d.pushMatrix();
    s3d.shape(Goat_1);
    s3d.popMatrix();
    //---------------
    float angle=2*abs(((step%180)/180)-0.5);
    float angleMap=map(angle,0,1,0,70);

    s3d.pushMatrix();
    s3d.translate(angleMap*-1,0,0);
    if (vol>0.8) s3d.scale(random(1, 1.1));
    else s3d.scale(1);
    s3d.shape(Goat_2);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    s3d.translate(angleMap,0,0);
    if (vol>0.8) s3d.scale(random(1, 1.1));
    else s3d.scale(1);
    s3d.shape(Goat_3);
    s3d.popMatrix();
  }
  s3d.popMatrix();
  if (wireFrameCtl==true) {
    noWireFrame(Goat_1, random(1.80, 2.40), color(0, 165, 250, 120));
    noWireFrame(Goat_2, random(1.80, 2.40), color(0, 165, 250, 120));
    noWireFrame(Goat_3, random(1.80, 2.40), color(0, 165, 250, 120));
  } else {
    setTexture(Goat_1, GoatImg);
    setTexture(Goat_2, GoatImg);
    setTexture(Goat_3, GoatImg);
  }
}
void Goat(boolean theFlag) {
  if (theFlag==true) {
    showtoolGoat=false;
    thread("toolGoatSetting");
    //randomCam();
  } else {
    showtoolGoat=true;
    thread("toolGoatSetting");
  }
}
