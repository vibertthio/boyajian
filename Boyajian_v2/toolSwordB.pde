RShape textSwordB;
boolean showtoolSwordB =false;
boolean toolSwordBIn;

pdLine  toolSwordBLine;
pdLine  toolSwordBLineIn;
pdLine  toolSwordBLineOut;

PShape SwordB_1;
float SwordB_x, SwordB_y;

void toolSwordBSetting() {

  textSwordB= RG.getText("召喚鈴刀", "wt.ttf", 72, RFont.CENTER);
  toolSwordBLineIn=new pdLine(500, 1000);
  toolSwordBLineOut=new pdLine(3500, 1000);

  if (showtoolSwordB==false) {
    show[11]=1;
    countLife();
    toolSwordBLine=new pdLine(0, 1000);
    toolSwordBIn=true;
    SwordB_1 = loadShape("toolSwordB/swordb.obj");

    showtoolSwordB =true;
  } else if (showtoolSwordB==true) {
    toolSwordBIn=false;
    show[11]=0;
    countLife();
  }
  toolSwordBLine.reset();
  toolSwordBLineIn.reset();
  toolSwordBLineIn.done=false;
  toolSwordBLineOut.reset();
}


void toolSwordBdrawing() {
  toolSwordBLineIn.update();
  toolSwordBLineOut.update();
  showtoolSwordB=returnState(toolSwordBLine, toolSwordBIn);
  s3d.pushMatrix();
  {
    SwordB_x=width/2+countX[11].o;
    SwordB_y=height/2+69;
    //----fade
    if (toolSwordBIn==true)s3d.translate(0, map(easeOutBack(toolSwordBLine.o), 0, 1, 500, 0));
    else  s3d.translate(0, map(easeInBack(toolSwordBLine.o), 0, 1, 0, -500));
    //----fadeEnd
    {//文字開始
      s3d.pushMatrix();
      s3d.translate(width/2, height/2-17, -50);
      s3d.scale(3.0);
      s3d.fill(maskNmae, 155);

      {//文字動畫
         if (toolSwordBLineIn.bang==true ) {
          textSwordB.children[0].transform(70, easeInBack(toolSwordBLineIn.oo)*300, 20, 20) ;
          textSwordB.children[1].transform(102, -easeInBack(toolSwordBLineIn.oo)*300, 20, 20) ;
          textSwordB.children[2].transform(137, easeInBack(toolSwordBLineIn.oo)*300, 20, 20) ;
          textSwordB.children[3].transform(172, -easeInBack(toolSwordBLineIn.oo)*300, 20, 20) ;
        } else if (toolSwordBLineIn.done==true  ) {
          textSwordB.children[0].transform(70, easeInBack(toolSwordBLineOut.o)*300, 20, 20) ;
          textSwordB.children[1].transform(102, -easeInBack(toolSwordBLineOut.o)*300, 20, 20) ;
          textSwordB.children[2].transform(137, easeInBack(toolSwordBLineOut.o)*300, 20, 20) ;
          textSwordB.children[3].transform(172, -easeInBack(toolSwordBLineOut.o)*300, 20, 20) ;
          defultCam();
        }

        if (toolSwordBLineOut.bang==false) {
          toolSwordBLineIn.done=false;
        }
      }//文字動畫結束

      s3d.strokeWeight(1);
      s3d.noStroke();
      if (toolSwordBLineOut.o>0.001 || toolSwordBLineIn.o>0.001 )
        if ( toolSwordBIn==true )textSwordB.draw(s3d);
      s3d.popMatrix();
    }//文字結束
    //-----model

    s3d.translate(SwordB_x, SwordB_y+map(sin(float(frameCount%300)/300*6.28), -1, 1, 0, -50), -50);
    s3d.rotateZ(PI);
    s3d.rotateY(radians(map(sin(float(frameCount%600)/600*6.28), -1, 1, -30, 30)));
    //--------------抖動
    s3d.rotateZ(map(pow(sin(float(frameCount%10)/10*6.28), 8.0), 0, 1, 0, PI*-0.01));
    s3d.scale(0.47);
    //---------------
    s3d.pushMatrix();
    s3d.rotateZ(pow(sin(a2/90*6.28), 4.0)*0.2);
    s3d.shape(SwordB_1);
    s3d.popMatrix();

  }
  s3d.popMatrix();
}
void SwordB(boolean theFlag) {
  if (theFlag==true) {
    showtoolSwordB=false;
    thread("toolSwordBSetting");
    randomCam();
  } else {
    showtoolSwordB=true;
    thread("toolSwordBSetting");
  }
}