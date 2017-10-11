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
  toolShieldBLineIn.update();
  toolShieldBLineOut.update();
  showtoolShieldB=returnState(toolShieldBLine, toolShieldBIn);
  s3d.pushMatrix();
  {
    ShieldB_x=width/2+countX[8].o;
    ShieldB_y=height/2+-54;
    //----fade
    if (toolShieldBIn==true)s3d.translate(0, map(easeOutBack(toolShieldBLine.o), 0, 1, 500, 0));
    else  s3d.translate(0, map(easeInBack(toolShieldBLine.o), 0, 1, 0, -500));
    //----fadeEnd
    {//文字開始
      s3d.pushMatrix();
      s3d.translate(width/2, height/2-17, -50);
      s3d.scale(3.0);
      s3d.fill(maskNmae, 155);

      {//文字動畫
        if (toolShieldBLineIn.bang==true ) {
          textShieldB.children[0].transform(40, easeInBack(toolShieldBLineIn.oo)*300, 20, 20) ;
          textShieldB.children[1].transform(97, -easeInBack(toolShieldBLineIn.oo)*300, 20, 20) ;
          textShieldB.children[2].transform(156, easeInBack(toolShieldBLineIn.oo)*300, 20, 20) ;
        } else if (toolShieldBLineIn.done==true  ) {
          textShieldB.children[0].transform(40, easeInBack(toolShieldBLineOut.o)*300, 20, 20) ;
          textShieldB.children[1].transform(97, -easeInBack(toolShieldBLineOut.o)*300, 20, 20) ;
          textShieldB.children[2].transform(156, easeInBack(toolShieldBLineOut.o)*300, 20, 20) ;
          defultCam();
        }

        if (toolShieldBLineOut.bang==false) {
          toolShieldBLineIn.done=false;
        }
      }//文字動畫結束

      s3d.strokeWeight(1);
      s3d.noStroke();
      if (toolShieldBLineOut.o>0.001 || toolShieldBLineIn.o>0.001 )
        if ( toolShieldBIn==true )textShieldB.draw(s3d);
      s3d.popMatrix();
    }//文字結束
    //-----model

    s3d.translate(ShieldB_x, ShieldB_y+110+map(sin(float(frameCount%300)/300*6.28), -1, 1, 0, -50), -50);
    s3d.rotateZ(PI);
    s3d.rotateY(radians(map(sin(float(frameCount%600)/600*6.28), -1, 1, -30, 30)));
    //--------------抖動
    s3d.rotateZ(map(pow(sin(float(frameCount%10)/10*6.28), 8.0), 0, 1, 0, PI*-0.01));
    s3d.scale(0.47);
    //---------------
    s3d.pushMatrix();
    s3d.rotateZ(pow(sin((a2+60)/90*6.28), 4.0)*0.2);
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