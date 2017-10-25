RShape textWind;
boolean showtoolWind =false;
boolean toolWindIn;

pdLine  toolWindLine;
pdLine  toolWindLineIn;
pdLine  toolWindLineOut;

PShape Wind_1;
PShape Wind_2;
PShape Wind_3;

PShape rWind_1;
PShape rWind_2;
PShape rWind_3;

PImage WindImg;
float Wind_x, Wind_y;



void toolWindSetting() {

  textWind= RG.getText("召喚鈴刀", "wt.ttf", 72, RFont.CENTER);

  if (showtoolWind==false) {
    show[15]=1;
    countLife();
    WindImg=loadImage("toolWind/tex_wind.png");
    toolWindIn=true;
    Wind_1 = loadShape("toolWind/wind_1.obj");
    Wind_2 = loadShape("toolWind/wind_2.obj");
    Wind_3 = loadShape("toolWind/wind_2.obj");

    rWind_1 = loadShape("toolWind/wind_1.obj");
    rWind_2 = loadShape("toolWind/wind_2.obj");
    rWind_3 = loadShape("toolWind/wind_2.obj");

    showtoolWind =true;
  } else if (showtoolWind==true) {
    toolWindIn=false;
    show[15]=0;
    countLife();
  }
  toolWindLineIn=new pdLine(500, 1000);
  toolWindLineOut=new pdLine(3500, 1000);
  toolWindLine=new pdLine(0, 1000);
  toolWindLine.reset();
  toolWindLineIn.reset();
  toolWindLineIn.done=false;
  toolWindLineOut.reset();
}


void toolWinddrawing() {

  showtoolWind=returnState(toolWindLine, toolWindIn);
  s3d.pushMatrix();
  {
    Wind_x=width/2+countX[15].o;

    if (toolWindIn==true) Wind_y=height/2+10+ map(easeOutBack(toolWindLine.o), 0, 1, 500, 0);
    else  Wind_y=height/2+10+map(easeInBack(toolWindLine.o), 0, 1, 0, -500);

    s3d.translate(Wind_x, Wind_y+anim(300, 0, -50, 2), -50);

    // s3d.pushMatrix();
    // s3d.translate(40, 0, 0);
    // s3d.fill(maskNmae, 155);
    // toolWindLineIn.update();
    // toolWindLineOut.update();
    // if (toolWindLineIn.bang==true ) {
    //   textWind.children[0].transform(70, easeInBack(toolWindLineIn.oo)*300, 30, 30) ;
    //   textWind.children[1].transform(102, -easeInBack(toolWindLineIn.oo)*300, 30, 30) ;
    //   textWind.children[2].transform(137, easeInBack(toolWindLineIn.oo)*300, 30, 30) ;
    //   textWind.children[3].transform(172, -easeInBack(toolWindLineIn.oo)*300, 30, 30) ;
    // } else if (toolWindLineIn.done==true  ) {
    //   textWind.children[0].transform(70, easeInBack(toolWindLineOut.o)*300, 30, 30) ;
    //   textWind.children[1].transform(102, -easeInBack(toolWindLineOut.o)*300, 30, 30) ;
    //   textWind.children[2].transform(137, easeInBack(toolWindLineOut.o)*300, 30, 30) ;
    //   textWind.children[3].transform(172, -easeInBack(toolWindLineOut.o)*300, 30, 30) ;
    //   defultCam();
    // }
    // if (toolWindLineOut.bang==false) toolWindLineIn.done=false;
    // if (toolWindLineOut.o<0.99 && toolWindLineIn.o>0.01 && toolWindIn==true )textWind.draw(s3d);
    //
    // s3d.popMatrix();


    s3d.rotateZ(PI);
    s3d.rotateY(radians(anim(600,-30,30,8)));
    //--------------抖動
    s3d.scale(0.31);
    //---------------
    s3d.pushMatrix();
    s3d.shape(Wind_1);
    s3d.popMatrix();


    float angle=(step%90)/90;
    float angleMap=map(angle,0,1,0,360);

    s3d.pushMatrix();
    s3d.translate(-300,0,0);
    s3d.rotateZ(radians(-angleMap));
    s3d.shape(Wind_2);
    s3d.popMatrix();

    s3d.pushMatrix();
    s3d.translate(300,0,0);
    s3d.rotateZ(radians(angleMap));
    s3d.shape(Wind_3);
    s3d.popMatrix();
  }
  s3d.popMatrix();
  if (wireFrameCtl==true) {
    noWireFrame(Wind_1, random(1.80, 2.40), color(0, 165, 250, 120));
    noWireFrame(Wind_2, random(1.80, 2.40), color(0, 165, 250, 120));
    noWireFrame(Wind_3, random(1.80, 2.40), color(0, 165, 250, 120));
  } else {
    setTexture(Wind_1, WindImg);
    setTexture(Wind_2, WindImg);
    setTexture(Wind_3, WindImg);
  }
}
void Wind(boolean theFlag) {
  if (theFlag==true) {
    showtoolWind=false;
    thread("toolWindSetting");
    //randomCam();
  } else {
    showtoolWind=true;
    thread("toolWindSetting");
  }
}