RShape textShieldB;
boolean showtoolShieldB =false;
boolean toolShieldBIn;

pdLine  toolShieldBLine;
pdLine  toolShieldBLineIn;
pdLine  toolShieldBLineOut;

PShape ShieldB_1;
float ShieldB_x, ShieldB_y;

void toolShieldBSetting() {

  textShieldB= RG.getText("迴靈盾", "wt.ttf", 72, RFont.CENTER);


  if (showtoolShieldB==false) {
    show[8]=1;
    countLife();

    toolShieldBIn=true;
    ShieldB_1 = loadShape("toolShieldB/shieldb.obj");

    showtoolShieldB =true;
  } else if (showtoolShieldB==true) {
    toolShieldBIn=false;
    show[8]=0;
    countLife();
  }


  toolShieldBLineIn=new pdLine(500, 1000);
  toolShieldBLineOut=new pdLine(3500, 1000);
  toolShieldBLine=new pdLine(0, 1000);
  toolShieldBLine.reset();
  toolShieldBLineIn.reset();
  toolShieldBLineIn.done=false;
  toolShieldBLineOut.reset();
}


void toolShieldBdrawing() {

  showtoolShieldB=returnState(toolShieldBLine, toolShieldBIn);
  s3d.pushMatrix();
  {
    ShieldB_x=width/2+countX[8].o;

    //----fade
    if (toolShieldBIn==true)ShieldB_y=height/2+56+map(easeOutBack(toolShieldBLine.o), 0, 1, 500, 0);
    else  ShieldB_y=height/2+56+map(easeInBack(toolShieldBLine.o), 0, 1, 0, -500);

    s3d.translate(ShieldB_x, ShieldB_y+anim(300, 0, -50, 2), -50);

    // s3d.pushMatrix();
    // s3d.translate(40,0, 0);
    // s3d.fill(maskNmae, 155);
    // toolShieldBLineIn.update();
    // toolShieldBLineOut.update();
    // if (toolShieldBLineIn.bang==true ) {
    //   textShieldB.children[0].transform(40, easeInBack(toolShieldBLineIn.oo)*300, 30, 30) ;
    //   textShieldB.children[1].transform(97, -easeInBack(toolShieldBLineIn.oo)*300, 30, 30) ;
    //   textShieldB.children[2].transform(156, easeInBack(toolShieldBLineIn.oo)*300, 30, 30) ;
    // } else if (toolShieldBLineIn.done==true  ) {
    //   textShieldB.children[0].transform(40, easeInBack(toolShieldBLineOut.o)*300, 30, 30) ;
    //   textShieldB.children[1].transform(97, -easeInBack(toolShieldBLineOut.o)*300, 30, 30) ;
    //   textShieldB.children[2].transform(156, easeInBack(toolShieldBLineOut.o)*300, 30, 30) ;
    //   defultCam();
    // }
    //
    // if (toolShieldBLineOut.bang==false)  toolShieldBLineIn.done=false;
    // if (toolShieldBLineOut.o<0.99 && toolShieldBLineIn.o>0.001 &&toolShieldBIn==true )textShieldB.draw(s3d);
    //
    // s3d.popMatrix();

    s3d.rotateZ(PI);
    s3d.rotateY(radians(map(sin(float(frameCount%600)/600*6.28), -1, 1, -30, 30)));
    //--------------抖動
    s3d.rotateZ(map(pow(sin(float(frameCount%10)/10*6.28), 8.0), 0, 1, 0, PI*-0.01));
    s3d.scale(0.47);
    //---------------
    s3d.pushMatrix();
    s3d.shape(ShieldB_1);
    s3d.popMatrix();
  }
  s3d.popMatrix();
}
void ShieldB(boolean theFlag) {
  if (theFlag==true) {
    showtoolShieldB=false;
    thread("toolShieldBSetting");
    randomCam();
  } else {
    showtoolShieldB=true;
    thread("toolShieldBSetting");
  }
}
